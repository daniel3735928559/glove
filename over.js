/*TODO

- Make brief connections display at start as well as at end, and make
  them display sensibly if more than one thing is briefly connected to
  a given target.

- (fixed) Some bug with renaming modules where other pins with the
  same name elsewhere in the chip are also affected

- (fixed) When you delete a module, disassociate its associated cboxes

- (done) Make multiple connections between pairs of pins represented
  only by one wire (e.g. in0 & (in0 << 1) should only have one wire
  drawn).

- (fixed) When you rename a module, also rename its associated cboxes.

- (done) Make pins have an `explode' attribute which makes combination
  of inputs explicit

- (done) Change so that holding down 'b' while connecting makes
  connection brief, and holding down 'c' while connecting sets
  connection colour

- (done) Make C-H toggle status_div

- (done) Make a `colourise' function that behaves like connect except
  allows you to specify a colour for the given connection.

- (done) Comments tieable to modules/ins/outs (possibly more than 1)

- (fixed) If input pin connected to output pin, and input pin is
  renamed, output pin's connection is not updated accordingly

- (fixed) Resizing comments--yellow circle is in wrong place

- (maybe not anymore?) Combine is broken maybe?

- (done) Make labelling a pin module to :3 change the width of the pin only

- (done) Make pin widths adjustable by renaming

- (done) Allow comment types--hold Ctrl while clicking on comment in
  comment mode to set type.  M-t in comment mode to show only comments
  in a comma-delimited list of types.

- (done) Allow comment boxes

- (done) In `Arrange' mode, make holding down 's' allow selecting
  multiple modules to move

- (done) Make `swap pins' a feature of `Edit type' (hold down 's'
  while selecting two pins (both input or both output) of a module for
  swapping)

- (done) Provide more user-friendly help text onscreen 

- (done) Use keyboard shortcuts

- (done) Allow wires to specify waypoints like: 
  <src ...><wp x="123" y="43"/>...</src>
  and make these waypoints editable

- (done) 20130507: Fix connections from same pin to different pins on same
  module

- (done) Allow parameters for modules

- (done) Updated DTD--now update: 
    draw functions (done)
    connect_click  (done)
    del_click      (done)
    label_click    (done)
    breakout_click (done)

- (done) Allow multiple connections to a single target, and include a
  way to specify how the inputs are combined (which requires that all
  the inputs are used).  That is, write combine_click

- (done) Use xpath to select the right nodes for things like deleting
  errant connections rather than iterating through all nodes as we do
  currently

- (fixed) Make circular dependency testing proper like before

- (fixed) del type doesn't work because of depends_on being broken

- (fixed) deleting an input or output module breaks connections

- (done) make 'Breakout' button so that when you click a pin it
  creates a corresponding input (or output, as needed) pin module of
  the same width, as well as a connection from the pin to that pin
  module

- (fixed) new type doesn't work

- (fixed) XML export doesn't work

*/

var shortcuts = {};
var waypoint_radius = 5;
var current_waypoint = null;
var adown = false;
var bdown = false;
var cdown = false;
var ddown = false;
var sdown = false;
var xdown = false;
var tdown = false;
var pin_height = 15;
var pin_width = 60;
var module_width = 2*pin_width;
var header_height = 20;
var current_pin_ID = [null,null];
var selected_pins = {};
var base_doc = (new window.DOMParser()).parseFromString(document.getElementById("xmlout").value, "text/xml")
var chip_base = base_doc.documentElement;

var action_buttons = [];
var state_buttons = [];
var nav_buttons = []; //Displays which submodule of which submodule we are currently editing
var type_buttons = [];
var state = "Arrange";


var can = document.getElementById("main_canvas");
var c = can.getContext("2d");

function clone(o) {
    var newObj = (o instanceof Array) ? [] : {};
    for (var i in o) {
	if (i == 'clone') continue;
	if (o[i] && typeof o[i] == "object") {
	    newObj[i] = clone(o[i]);
	}
	else newObj[i] = o[i]
    }
    return newObj;
};

var comment_display_types = ["doc"];
var associating_module = null;
var resizing_comment = null;
var selected_type = "";
var top_modules = {}; // object acting as an assoc array of all modules in the top level of the circuit, listed by name
var modules = top_modules; // object acting as an assoc array of all modules currently being displayed, listed by name
var module_types = {}; // similarly
var grid_spacing = 20;
var current_pin = [null,null];
var swapping_pin = [null,null];
var dragStartX = 0;
var dragStartY = 0;

// Click handler functions

function path_click(x,y){
    if(current_waypoint == null){
	var w = find_waypoint(x,y);
	console.log(w);
	if(w == null) return;
	if(adown && w.nodeName != "src"){
	    nw = base_doc.createElement("wp");
	    nw.setAttribute("x",x);
	    nw.setAttribute("y",y);
	    w.parentNode.insertBefore(nw,w.nextSibling);
	    current_waypoint = nw;
	}
	else if(bdown && w.nodeName != "src"){
	    nw = base_doc.createElement("wp");
	    nw.setAttribute("x",x);
	    nw.setAttribute("y",y);
	    w.parentNode.insertBefore(nw,w);
	    current_waypoint = nw;
	}
	else if(ddown && w.nodeName != "src"){
	    w.parentNode.removeChild(w);
	}
	else{
	    if(w.nodeName == "src"){
		nw = base_doc.createElement("wp");
		nw.setAttribute("x",x);
		nw.setAttribute("y",y);
		w.appendChild(nw);
		current_waypoint = nw;
	    }
	    else current_waypoint = w;
	}
    }
    else{
	current_waypoint = null;
    }
}

function path_move(x,y){
    if(current_waypoint != null){
	nx = grid_spacing*Math.floor(x/grid_spacing)+5;
	ny = grid_spacing*Math.floor(y/grid_spacing)+pin_height/2;
	current_waypoint.setAttribute("x",nx);
	current_waypoint.setAttribute("y",ny);
	draw_all(c,can);
    }
}

function label_click(x,y){
    m = find_point_in_mod(x,y);
    if(m == null) return;
    var old_name = m.getAttribute("name");
    var new_name = prompt("New name for " + old_name + ((m.nodeName == "in" || m.nodeName == "out") ? "\n(Enter as name[:width] depending on whether you want to change the width)" : ""));
    if(new_name == null || new_name == "") return;
    if(/^:[0-9]*$/.test(new_name) && (m.nodeName == "in" || m.nodeName == "out")){
	m.setAttribute("width",new_name.substring(1));
	new_name = old_name;
    }
    else if(/^[A-Za-z_][A-Za-z_0-9]*:[0-9]*$/.test(new_name) && (m.nodeName == "in" || m.nodeName == "out")){
	var arr = new_name.split(":");
	new_name = arr[0];
	m.setAttribute("width",arr[1]);
    }
    if(find_module(new_name,current_type) != null){
	alert("Already exists");
	return;
    }
    //Search for any connections made involving me and rename them: 
    //Search first for any connections I made to anything and rename them: 
    var nodes = base_doc.evaluate(".//conn/src[@mod='"+m.getAttribute("name")+"']", current_type, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
    for(var i=0 ; i < nodes.snapshotLength; i++){
	console.log(nodes.snapshotItem(i));
	nodes.snapshotItem(i).setAttribute("mod",new_name);
	// If we are renaming an input pin of current_type, need to also set the pin attribute of the src
	if(m.nodeName == "in") nodes.snapshotItem(i).setAttribute("pin",new_name);
    }

    //Search for any cboxes associated to me and update them as needed
    var nodes = base_doc.evaluate(".//cbox/assoc[@mod='"+m.getAttribute("name")+"']", current_type, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
    for(var i=0 ; i < nodes.snapshotLength; i++){ nodes.snapshotItem(i).setAttribute("mod",new_name); }

    //If in addition the thing we are renaming is a pin, be careful to rename all connections anywhere in the chip that involved that pin
    if(m.nodeName == "in"){
	var mtype = m.parentNode.getAttribute("name");
	var nodes = base_doc.evaluate("//module[@type='"+mtype+"']/conn[@target='"+m.getAttribute("name")+"']", base_doc, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	for(var i=0 ; i < nodes.snapshotLength; i++){ nodes.snapshotItem(i).setAttribute("target",new_name); }
    }
    else if(m.nodeName == "out"){
	var mtype = m.parentNode.getAttribute("name");
	var nodes = base_doc.evaluate("//module[@type='"+mtype+"']", base_doc, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	for(var i=0 ; i < nodes.snapshotLength; i++){
	    var mod = nodes.snapshotItem(i);
	    var cons = base_doc.evaluate("//conn/src[@mod='"+mod.getAttribute("name")+"' and @pin='"+m.getAttribute("name")+"']", base_doc, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	    for(var j=0 ; j < cons.snapshotLength; j++){ cons.snapshotItem(j).setAttribute("pin",new_name); }
	}
    }    
    m.setAttribute("name",new_name); 
}

function edit_click(x,y){
    if(sdown){
	var m = find_point_in_mod(x,y);
	if(m == null) return;
	var p = find_point_in_pin(x,y,m);
	if(p == null){ return; }
	var arr = pin_loc(p,m);
	console.log(p,m);
	if(swapping_pin[0] == null) swapping_pin = [p,m];
	else if(swapping_pin[0] == p && swapping_pin[1] == m) swapping_pin = [null,null];
	else if(swapping_pin[1] == m && p.nodeName == swapping_pin[0].nodeName){ 
	    // In this case we have selected a pin to swap with of the
	    // same sort (in/out) as the pin we selected
	    var next_guy = p.nextElementSibling;
	    console.log(next_guy);
	    console.log(p);
	    if(next_guy == swapping_pin[0]) p.parentNode.insertBefore(swapping_pin[0],p);
	    else{
		p.parentNode.insertBefore(p,swapping_pin[0]);
		if(next_guy == null) p.parentNode.appendChild(swapping_pin[0]);
		else p.parentNode.insertBefore(swapping_pin[0],next_guy);
	    }
	    console.log(next_guy);
	    console.log(p);
	    swapping_pin = [null,null];
	}
	console.log(swapping_pin)
    }
    else{
	swapping_pin = [null,null]
	var b = find_in(x,y,type_buttons);
	var etype;
	if(b == null || b == type_buttons[0]){
	    var m = find_point_in_mod(x,y);
	    if(m == null) return;
	    else if(mod.nodeName == "module") etype = m.getAttribute("type");
	}
	else etype = b.text;
	current_type = find_mod_type(etype);
	var i = nav_buttons.length;
	nav_buttons = [nav_buttons[0]];
	add_button(etype,function(){},nav_buttons[0].y,nav_buttons);
    }
}

function set_param_click(x,y){
    var m = find_point_in_mod(x,y);
    if(m == null) return;

    var old_param = m.getAttribute("param");
    var new_param = prompt("Parameter value to pass to " + m.getAttribute("name"),old_param == null ? "" : old_param);
    if(new_param != null){
	if(new_param == "") m.removeAttribute("param")
	else m.setAttribute("param",new_param)
    }
}

function breakout_click(x,y){
    var m = find_point_in_mod(x,y);
    if(m == null) return;
    var p = find_point_in_pin(x,y,m);
    if(p == null){ return; }
    var new_name = prompt("Name for new pin: ", p.getAttribute("name"));
    if(new_name == null || new_name == "") return;
    if(m.nodeName == "module"){
	if(p.nodeName == "in"){
	    var new_port = base_doc.createElement("in");
	    new_port.setAttribute("name",new_name);
	    new_port.setAttribute("width",p.getAttribute("width"));
	    new_port.setAttribute("x",40);
	    new_port.setAttribute("y",pin_loc(p,m)[1]);
	    current_type.appendChild(new_port);
	    var new_conn = base_doc.createElement("conn");
	    new_conn.setAttribute("target", p.getAttribute("name"));
	    var new_src = base_doc.createElement("src");
	    new_src.setAttribute("pin", new_name);
	    new_src.setAttribute("mod", new_name);
	    m.appendChild(new_conn);
	    new_conn.appendChild(new_src);
	}
	if(p.nodeName == "out"){
	    var new_port = base_doc.createElement("out");
	    new_port.setAttribute("name",new_name);
	    new_port.setAttribute("width",p.getAttribute("width"));
	    new_port.setAttribute("x",1500);
	    new_port.setAttribute("y",pin_loc(p,m)[1]);
	    current_type.appendChild(new_port);
	    var new_conn = base_doc.createElement("conn");
	    new_conn.setAttribute("target", new_name);
	    var new_src = base_doc.createElement("src");
	    new_src.setAttribute("pin", p.getAttribute("name"));
	    new_src.setAttribute("mod", m.getAttribute("name"));
	    new_port.appendChild(new_conn);
	    new_conn.appendChild(new_src);
	}
    }
    draw_all(c,can);
}

function del_type_click(x,y){
    var b = find_in(x,y,type_buttons);
    var etype;
    if(b == null || b == type_buttons[0]){
	var m = find_point_in_mod(x,y);
	if(m == null || m.nodeName != "module") return;
	else etype = m.getAttribute("type");
    }
    else etype = b.text;
    var the_type = find_mod_type(etype);
    if(depends_on(chip,the_type,100)){
	alert("This module exists in the chip");
	return;
    }
    else{
	chip_base.removeChild(the_type);
	generate_type_buttons(type_buttons[0].y);
    }
}

//is there anything of type type_b in type_a?
function depends_on(type_a,type_b,maxdepth){
    if(maxdepth <= 0) return true; //We probably have a circle if we got this far?
    if(type_a == type_b) return true;
    var cons = [];
    for(var mod = type_a.firstElementChild; mod != null; mod = mod.nextElementSibling){
	if(mod.nodeName == "module" && depends_on(find_mod_type(mod.getAttribute("type")),type_b,maxdepth-1)) return true;
    }
    return false;
}

function place_click(x,y){
    if(selected_type == "") return;
    var new_name = prompt("name for new " + selected_type);
    if(new_name == null || new_name == "") return;
    if(find_module(new_name,current_type) != null) alert("Already exists");
    //Test for circular dependencies: 
    else if(depends_on(find_mod_type(selected_type),current_type,100)){ alert("Circular dependency!"); return;}
    else{
	newmod = base_doc.createElement("module");
	newmod.setAttribute("name",new_name);
	newmod.setAttribute("type",selected_type);
	newmod.setAttribute("x",x);
	newmod.setAttribute("y",y);
	current_type.appendChild(newmod);
    }
}

function del_click(x,y){
    var m = find_point_in_mod(x,y);
    if(m == null) return;
    //Search for any connections I made to anything and delete them
    var nodes = base_doc.evaluate(".//conn/src[@mod='"+m.getAttribute("name")+"']", current_type, null, XPathResult.ANY_TYPE, null);
    var torem = [];
    for(var r = nodes.iterateNext(); r != null; r = nodes.iterateNext()){ torem.push(r); }
    for(var i = 0; i < torem.length; i++){ torem[i].parentNode.removeChild(torem[i]); }

    //Search for any cboxes associated to me and disassociate them as needed
    var nodes = base_doc.evaluate(".//cbox/assoc[@mod='"+m.getAttribute("name")+"']", current_type, null, XPathResult.ANY_TYPE, null);
    torem = [];
    for(var r = nodes.iterateNext(); r != null; r = nodes.iterateNext()){ torem.push(r); }
    for(var i = 0; i < torem.length; i++){ torem[i].parentNode.removeChild(torem[i]); }

    //If in addition the thing we are deleting was a pin, be careful to delete all connections anywhere in the chip that involved that pin
    if(m.nodeName == "in"){
	var mtype = m.parentNode.getAttribute("name");
	var nodes = base_doc.evaluate("//module[@type='"+mtype+"']/conn[@target='"+m.getAttribute("name")+"']", base_doc, null, XPathResult.ANY_TYPE, null);
	var torem = [];
	for(var cx = nodes.iterateNext(); cx != null; cx = nodes.iterateNext()){ torem.push(cx); }
	for(var i = 0; i < torem.length; i++){ torem[i].parentNode.removeChild(torem[i]); }
    }
    else if(m.nodeName == "out"){
	var mtype = m.parentNode.getAttribute("name");
	var nodes = base_doc.evaluate("//module[@type='"+mtype+"']", base_doc, null, XPathResult.ANY_TYPE, null);
	var torem = [];
	for(var mod = nodes.iterateNext(); mod != null; mod = nodes.iterateNext()){
	    var cons = base_doc.evaluate("//conn/src[@mod='"+mod.getAttribute("name")+"' and @pin='"+m.getAttribute("name")+"']", base_doc, null, XPathResult.ANY_TYPE, null);
	    for(var con = cons.iterateNext(); con != null; con = cons.iterateNext()){ torem.push(con); }
	}
	for(var i = 0; i < torem.length; i++){ torem[i].parentNode.removeChild(torem[i]); }
    }
    current_type.removeChild(m);
    draw_all(c,can);
}

function io_click(x,y){
/*    if(current_type.getAttribute("name") == "Chip"){
	alert("Top level cannot have pins");//Maybe true?
	return;
    }*/
    var t = prompt("Enter "+state.toLowerCase()+" pin as name:width");
    if(t != null && t != ""){
	if(!(/^[A-Za-z_][A-Za-z_0-9]*:[0-9]*$/.test(t))){
	    alert("Bad input");
	    return;
	}
	var arr = t.split(":");
	var pin_name = arr[0];
	var pin_width = arr[1];
	var port = base_doc.createElement(state == "Input" ? "in" : "out");
	port.setAttribute("name", pin_name);
	port.setAttribute("width", pin_width);
	port.setAttribute("x", x);
	port.setAttribute("y", y);
	current_type.appendChild(port);
    }
}

function connect_click(x,y){
    var m = find_point_in_mod(x,y);
    if(m == null) return;
    var p = find_point_in_pin(x,y,m);
    if(p == null){ return; }
    var arr = pin_loc(p,m);
    if(((p.nodeName == "out" && m.nodeName != "out") || m.nodeName == "in") && (current_pin[0] != p | current_pin[1] != m)){
	selected_pins = {};
	selected_pins[pin_ID(p,m)] = true;
	current_pin = [p,m];
	console.log(m.getAttribute("name")+"' and @pin='"+p.getAttribute("name"));
	var cons = base_doc.evaluate("/chip/module_type//conn/src[@mod='"+m.getAttribute("name")+"' and @pin='"+p.getAttribute("name")+"']", base_doc, null, XPathResult.ANY_TYPE, null);
	//console.log(cons.iterateNext());
	for(cx = cons.iterateNext(); cx != null; cx = cons.iterateNext()){ selected_pins[cx.parentNode.parentNode.getAttribute("name") + "." + cx.parentNode.getAttribute("target")] = true; }
    }
    else if(current_pin[0] != null){
	var cp = current_pin;
	if(cp[1] != m &&  (m.nodeName == "out" || p.nodeName == "in")){
	    //We've clicked on an input pin while we have an output pin of a different module selected: 
	    if(pin_ID(p,m) in selected_pins){
		console.log(pin_ID(p,m))
		//We were already connected to it
		if(!bdown && !tdown) delete selected_pins[pin_ID(p,m)]
		else if(tdown){
		    var new_colour = prompt("Enter HTML colour (e.g. FFFFFF, white, etc.)");
		    if(new_colour == null) return;
		}
		// m has a child conn with a src child with pin==cp[0].getAttribute("name") and mod==cp[0].getAttribute("name")
		var cons = base_doc.evaluate("conn[@target='"+p.getAttribute("name")+"']/src[@mod='"+cp[1].getAttribute("name")+"' and @pin='"+cp[0].getAttribute("name")+"']", m, null, XPathResult.ANY_TYPE, null);
		var torem = [];
		console.log("//module[@name='"+m.getAttribute("name")+"']/conn[@target='"+p.getAttribute("name")+"']/src[@mod='"+cp[1].getAttribute("name")+"' and @pin='"+cp[0].getAttribute("name")+"']");
		for(cx = cons.iterateNext(); cx != null; cx = cons.iterateNext()){ console.log("AA"); console.log(cx); torem.push(cx); }
		for(var i = 0; i < torem.length; i++){
		    if(!bdown && !tdown) torem[i].parentNode.removeChild(torem[i]);
		    else if(bdown) torem[i].setAttribute("brief",torem[i].getAttribute("brief") == "1" ? "0" : "1");
		    else if(tdown){ torem[i].setAttribute("colour",new_colour); tdown = false;}
		}
		
	    }
	    else{
		//We were not already connected to it
		selected_pins[pin_ID(p,m)] = true;
		var con = base_doc.evaluate("./conn[@target='"+p.getAttribute("name")+"']", m, null, XPathResult.ANY_UNORDERED_NODE_TYPE, null).singleNodeValue;
		if(con == null){
		    con = base_doc.createElement("conn");
		    con.setAttribute("target",p.getAttribute("name"));
		}
		var nsrc = base_doc.createElement("src");
		nsrc.setAttribute("pin", cp[0].getAttribute("name"));
		nsrc.setAttribute("mod", cp[1].getAttribute("name"));
		if(bdown) nsrc.setAttribute("brief", "1");
		m.appendChild(con);
		con.appendChild(nsrc);
	    }
	}
	else if(current_pin[0] == p && current_pin[1] == m){
	    current_pin = [null,null];
	    selected_pins = {};
	}
    }
}

function combine_click(x,y){
    var m = find_point_in_mod(x,y);
    if(m == null) return;
    var p = find_point_in_pin(x,y,m);
    if(p == null){ return; }
    var arr = pin_loc(p,m); 
    if(p.nodeName == "in" || m.nodeName == "out"){
	var con = base_doc.evaluate("./conn[@target='"+p.getAttribute("name")+"']", m, null, XPathResult.ANY_UNORDERED_NODE_TYPE, null).singleNodeValue;
	if(con == null){
	    con = base_doc.createElement("conn");
	    con.setAttribute("target",p.getAttribute("name"));
	    m.appendChild(con);
	}
	if(xdown){
	    con.setAttribute("explode",con.getAttribute("explode") == "1" ? "0" : "1");
	    return;
	}
	var srcs = base_doc.evaluate("./src", con, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
	var l = srcs.snapshotLength;
	var s = "Specify the input:\n";
	var current_combo = "";
	console.log("hi" + l);
	if(l > 0){
	    var pins = [];
	    var pins_by_number = [];
	    var pins_by_ID = [];
	    var pin_not_yet_cloned_by_number = []; //How we manage to only copy the waypoints for one instance of each src
	    var j = 0;
	    for(var i = 0; i < l; i++){
		var the_pin = srcs.snapshotItem(i).getAttribute("mod") + "." + srcs.snapshotItem(i).getAttribute("pin");
		if(!(the_pin in pins)){
		    pins[the_pin] = srcs.snapshotItem(i);
		    pins_by_number[j] = srcs.snapshotItem(i);
		    pin_not_yet_cloned_by_number[j] = true;
		    pins_by_ID[the_pin] = j;
		    s += "\t in"+(j++)+" = " + the_pin + "\n";
		}
	    }
	    var ch = con.firstChild;
	    while(ch){
		if(ch.nodeType == 3) current_combo = current_combo + ch.textContent;
		else if(ch.nodeType == 1 && ch.nodeName == "src") current_combo += "in" + pins_by_ID[ch.getAttribute("mod") + "." + ch.getAttribute("pin")];
		ch = ch.nextSibling;
	    }
	}
	else current_combo = con.firstChild == null ? "" : con.firstChild.textContent;
	var t = prompt(s,current_combo.trim().replace(/[\n ]+/g," "));
	if(t != null && t != ""){
	    var arr = [];
	    // Find the first index and instance of in[0-9]+ in t: 
	    var idx = t.search(/in[0-9]+/);
	    var mat = t.match(/in[0-9]+/);
	    while(idx != -1){
		if(idx > 0) arr.push(t.substring(0,idx));
		arr.push(t.substring(idx,idx+mat[0].length));
		t = t.substring(idx+mat[0].length);
		// Find the next index and instance of in[0-9]+ in t: 
		idx = t.search(/in[0-9]+/);
		mat = t.match(/in[0-9]+/);
	    }
	    if(t.length != 0) arr.push(t);
	    while (con.firstChild){ con.removeChild(con.firstChild); }
	    for(var i = 0; i < arr.length; i++){
		if(/in[0-9]+/.test(arr[i])){
		    var input = parseInt(arr[i].substring(2));
		    if(input in pins_by_number){
			con.appendChild(pins_by_number[input].cloneNode(pin_not_yet_cloned_by_number[input]));
			if(pin_not_yet_cloned_by_number[input]) pin_not_yet_cloned_by_number[input] = false;
		    }
		    else con.appendChild(base_doc.createTextNode(arr[i]));
		}
		else{
		    var txt = base_doc.createTextNode(arr[i])
		    con.appendChild(txt);
		}
	    }
	}
    }
}

function comment_move(x,y){
    if(resizing_comment != null){
	var nw = parseInt(resizing_comment.getAttribute("w"))+x-dragStartX;
	if(nw > 50){
	    resizing_comment.setAttribute("w",nw);
	    resizing_comment.setAttribute("h",comment_height(resizing_comment.childNodes[0].nodeValue.trim(),parseInt(nw)));
	    dragStartX = x;
	}
	draw_all(c,can);
    }
}

function comment_click(x,y){
    if(resizing_comment != null){
	resizing_comment.setAttribute("h",comment_height(resizing_comment.childNodes[0].nodeValue.trim(),parseInt(resizing_comment.getAttribute("w"))));
	resizing_comment = null;
	return;
    }
    var m = find_point_in_comment_corner(x,y);
    if(m != null){
	resizing_comment = m;
	dragStartX = x;
	return;
    }
    m = find_point_in_comment(x,y);
    if(m == null){
	m = find_point_in_mod(x,y);
	if(m == null){
	    var ntype = prompt("Comment type\n(Currently active: "+(comment_display_types.length == 0 ? "[all]" : comment_display_types.join(","))+")");
	    if(ntype == null) return;
	    var comment = prompt("Your comment");
	    if(comment == null || comment == "") return;
	    cb = base_doc.createElement("cbox");
	    cb.setAttribute("x",x);
	    cb.setAttribute("y",y);
	    cb.setAttribute("w",120);
	    cb.setAttribute("h",comment_height(comment.trim(),120));
	    cb.setAttribute("type",ntype);
	    cb.appendChild(base_doc.createTextNode(comment));
	    current_type.appendChild(cb);
	}
	else if(adown && associating_module != null){
	    console.log("w");
	    var ams = base_doc.evaluate("./assoc[@mod='"+m.getAttribute("name")+"']",associating_module, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
	    if(ams == null){
		console.log("hi");
		//We are not associated to this module ams--associate
		var elt = base_doc.createElement("assoc");
		elt.setAttribute("mod",m.getAttribute("name"));
		associating_module.appendChild(elt);
	    }
	    else associating_module.removeChild(ams); //We as associated to ams--disassociate
	}
    }
    else{
	if(tdown){
	    var ctype = prompt("Type",m.getAttribute("type"));
	    if(ctype == null) return;
	    else m.setAttribute("type",ctype.replace(/,/g,''));
	    tdown = false;
	}
	else if(adown){
	    // If a is down, de/select this comment 
	    if(associating_module == m) associating_module = null;
	    else associating_module = m;
	}
	else{
	    var comment = prompt("Edit comment",m.childNodes[0].nodeValue);
	    if(comment == "") m.parentNode.removeChild(m); 
	    else if(comment == null) return;
	    else{
		m.childNodes[0].nodeValue = comment;
		m.setAttribute("h",comment_height(comment,parseInt(cb.getAttribute("w"))));
	    }
	}
    }
}

function arrange_click(x,y){
    if(dragging.length == 0 || sdown){
	var m = find_point_in_mod(x,y);
	if(m == null) m = find_point_in_comment(x,y);
	if(m != null){
	    var foundit = false;
	    for(i in dragging){
		if(dragging[i] == m){
		    dragging.splice(i,1)
		    foundit = true;
		}
	    }
	    if(!foundit) dragging.push(m);
	}
	dragStartX = Math.floor(x/grid_spacing)*grid_spacing;
	dragStartY = Math.floor(y/grid_spacing)*grid_spacing;
	
    }
    else{
	x = Math.floor(x/grid_spacing)*grid_spacing;
	y = Math.floor(y/grid_spacing)*grid_spacing;
	dragging = [];
	draw_all(c,can);
    }
}

function arrange_move(x,y){
    if(!sdown){
	x = Math.floor(x/grid_spacing)*grid_spacing;
	y = Math.floor(y/grid_spacing)*grid_spacing;
	for(var i in dragging){
	    var mx = (x-dragStartX)+parseInt(dragging[i].getAttribute("x"));
	    var my = (y-dragStartY)+parseInt(dragging[i].getAttribute("y"));
	    if(mx % grid_spacing != 0) mx = Math.floor(mx/grid_spacing)*grid_spacing;
	    if(my % grid_spacing != 0) my = Math.floor(my/grid_spacing)*grid_spacing;
	    dragging[i].setAttribute("x",mx);
	    dragging[i].setAttribute("y",my);
	    draw_all(c,can);
	}
	dragStartX = x;
	dragStartY = y;
    }
}

// Parse/output XML functions: 

function from_XML(){
    base_doc = (new window.DOMParser()).parseFromString(document.getElementById("xmlout").value, "text/xml");
    chip_base = base_doc.documentElement;
    console.log(chip_base);
    chip  = find_mod_type("Chip");
    current_type = chip;
    generate_type_buttons(type_buttons[0].y);
    draw_all(c,can);
}
function generate_XML(){
    var output = (new XMLSerializer()).serializeToString(base_doc);
    output = output.replace(/\>([^\n])/g,">\n$1");
    console.log(output);
    document.getElementById("xmlout").value = output;
    //Now try to send the result to saver.py:

    document.getElementById("status_div").innerHTML = "If you wish to save the file locally, run saver.py [filename] and start chromium with --allow-file-access-from-files --disable-web-security";
    
    try{
	var xhr = new XMLHttpRequest();
	xhr.open("POST", "http://localhost:4444", true);
	xhr.setRequestHeader("Content-type", "text/xml");
	xhr.setRequestHeader("Content-length", output.length);
	xhr.setRequestHeader("Connection", "close");
	
	xhr.onreadystatechange = function() {
	    if(xhr.readyState == 4 && xhr.status == 200) {
		document.getElementById("status_div").innerHTML = "Success: " + xhr.responseText;
	    }
	    else if(xhr.readyState == 4 && xhr.status == 500) {
		document.getElementById("status_div").innerHTML = "Error: " + xhr.responseText;
	    }
	}
	xhr.send(output); }
    catch(e){
	document.getElementById("status_div").innerHTML = "Could not communicate with localhost:4444.  If you wish to save the file locally, run saver.py [filename]";
    }
}

// Button functions: 

function button(text,action,x,y,w,h,shortcut){
    this.text = text;
    this.action = action;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.selected = false;
    this.shortcut = shortcut;
    this.draw = function(c){
	c.fillStyle = this.selected ? "#99FF99" : "white";
	c.fillRect(this.x,this.y,this.w,this.h);
	c.strokeStyle = "black";
	c.strokeRect(this.x,this.y,this.w,this.h);
	c.fillStyle = "black";
	c.font = "10px Sans";
	c.fillText(this.text+(this.shortcut ? " ("+this.shortcut+")": ""),this.x+5,this.y+10);
    }
}

function add_button(text,action,y,arr,shortcut){
    var b = new button(text,action,10+arr.length*80, y,80,20,shortcut);
    if(shortcut != null){ shortcuts[shortcut] = b; }
    arr.push(b);
}
function generate_type_buttons(y){
    type_buttons = [];
    add_button("[New]",function(){
	    var t = prompt("Name for new module type");
	    if(t != null && t != ""){
		if(find_mod_type(t) != null) alert("already exists");
		else{
		    var elt = base_doc.createElement("module_type");
		    elt.setAttribute("name",t);
		    chip_base.appendChild(elt);
		    generate_type_buttons(type_buttons[0].y);
		}
	    }
	},y,type_buttons);
    for(var e = chip_base.firstElementChild; e != null; e = e.nextElementSibling){
	if(e.nodeName = "module_type" && e.getAttribute("name") != "Chip") add_button(e.getAttribute("name"),function(){selected_type = this.text; for(var b in type_buttons){type_buttons[b].selected = false;} this.selected = true;},y,type_buttons);
    }
}
function generate_state_buttons(y){
    for(var s in states){
	add_button(s,function(){state = this.text;for(var b in state_buttons){state_buttons[b].selected = false;} current_pin = ""; current_waypoint = null; dragging = []; associating_module = null; selected_pins = {}; this.selected = true;document.getElementById("status_div").innerHTML = states[state]["info"];},y,state_buttons,states[s]["key"]);
    }
}

// var states = {"Arrange":{"click":arrange_click,"move":arrange_move,"key":"a","info":"Drag modules to move them"},
// 	      "Edit Path":{"click":path_click,"move":path_move,"key":"e","info":"Drag the yellow points.  Hold 'a' (resp. 'b') while clicking to add a point after (resp. before) the dragged point"}}

var states = {"Arrange":{"click":arrange_click,"move":arrange_move,"key":"a","info":"Drag modules to move them.  Hold 's' and click on modules to de/select multiple modules for moving."},
	      "Edit Path":{"click":path_click,"move":path_move,"key":"e","info":"Drag the yellow points.  Hold 'a' (resp. 'b') while clicking to add a point after (resp. before) the dragged point.  Hold 'd' while clicking to delete a point."},
	      "Comment":{"click":comment_click,"move":comment_move,"key":"w","info":"Click to create a comment box, or click an existing box to edit a comment.  Edit a comment to [empty string] to remove it.  Drag the yellow dot to resize box.  Hold Ctrl while clicking a comment to set its type.  Press M-t to specify which types to display.  Hold a while clicking a comment to select it, and then hold a while clicking a module to toggle association between the comment and the module"},
	      "Connect":{"click":connect_click,"move":function(){},"key":"c","info":"Click the source and then the target of the connection you wish to create/delete.  Hold 'b' while clicking the target (of either an existing or a new connection) to put the name of the source in front of target rather than drawing a wire.  Hold Ctrl while clicking the target of an existing connection to set the colour of the wire."},
	      "Combine":{"click":combine_click,"move":function(){},"key":"x","info":"Click an input pin and enter a verilog expression that describes how the inputs should be fed in.  Hold 'x' while cliking a pin to toggle making the combination always visible."},
	      "Set Param":{"click":set_param_click,"move":function(){},"key":"p","info":"Click a module to set the parameter(s) you want to pass to the module"},
	      "Input":{"click":io_click,"move":function(){},"key":"i","info":"Click anywhere to create an input pin for the current module type"},
	      "Output":{"click":io_click,"move":function(){},"key":"o","info":"Click anywhere to create an output pin for the current module type"},
	      "Name Mod":{"click":label_click,"move":function(){},"key":"l","info":"Click a module to change its name.  Click a pin module to change its name and/or its width"},
	      "New Mod":{"click":place_click,"move":function(){},"key":"n","info":"Click anywhere to create a new module of whatever type is selected"},
	      "Del Mod":{"click":del_click,"move":function(){},"key":"r","info":"Click on a module to delete it"},
	      "Breakout":{"click":breakout_click,"move":function(){},"key":"b","info":"Click any pin to create a corresponding input/output pin (as appropriate) in the current type."},
	      "Edit Type":{"click":edit_click,"move":function(){},"key":"z","info":"Click a module or a type button to edit that module type.  Hold 's' to swap the order of pins"},
	      "Del Type":{"click":del_type_click,"move":function(){},"key":"d","info":"Click a module type button to delete that type (provided it isn't used in the chip)"}};

generate_state_buttons(10);
generate_type_buttons(40);
//Nav buttons: 
add_button("[Top]",function(){current_type = chip;nav_buttons = [nav_buttons[0]]; draw_all(c,can);},70,nav_buttons);
//XML action buttons: 
add_button("To XML",function(){generate_XML()},100,action_buttons);
add_button("Import",function(){from_XML()},100,action_buttons);

can.addEventListener("keydown",key_down, false);
can.addEventListener("keyup",key_up, false);
can.addEventListener("mouseover",function(e){can.focus()}, false);
can.addEventListener("mousedown",mouse_click, false);
can.addEventListener("mousemove",mouse_move, false);

var dragging = [];

function get_nontype_buttons(){
    return state_buttons.concat(action_buttons).concat(nav_buttons).concat([type_buttons[0]]);
}

function get_buttons(){
    return state_buttons.concat(type_buttons).concat(action_buttons).concat(nav_buttons);
}

// Navigation/Searching functions: 

function find_module(m_name,mtype){
    return base_doc.evaluate("*[@name='"+m_name+"']", mtype, null, XPathResult.ANY_TYPE, null).iterateNext();
}

function find_pin(pin_name,mtype){
    return base_doc.evaluate("in[@name='"+pin_name+"'] | out[@name='"+pin_name+"']", mtype, null, XPathResult.ANY_TYPE, null).iterateNext();
}

function find_mod_type(mtype_name){
    return base_doc.evaluate("/chip/module_type[@name='"+mtype_name+"']", base_doc, null, XPathResult.ANY_TYPE, null).iterateNext();
}

function ID_pin(pinID){
    var arr = pinID.split(".");
    var mod = find_module(arr[0],current_type);
    if(mod.nodeName != "module") return [mod,mod]
    var mtype = find_mod_type(mod.getAttribute("type"));
    var pin = find_pin(arr[1],mtype);
    return [pin,mod]
}

function pin_ID(p,m){ return m.getAttribute("name")+"."+p.getAttribute("name"); }

function pin_index(p,m){
    if(m.nodeName == "in" || m.nodeName == "out"){
	return 0;
    }
    else if(m.nodeName == "module"){
	mtype = find_mod_type(m.getAttribute("type"));
	var ps = mtype.getElementsByTagName("in");
	for(var i = 0; i < ps.length; i++){
	    if(ps[i].getAttribute("name") == p.getAttribute("name")) return i;
	}
	var ps = mtype.getElementsByTagName("out");
	for(var i = 0; i < ps.length; i++){
	    if(ps[i].getAttribute("name") == p.getAttribute("name")) return i;
	}
    }
    return -1;
}

function pin_loc(p,m){
    if(m.nodeName == "module") return [parseInt(m.getAttribute("x"))+(p.nodeName == "out" ? module_width-pin_width+5 : -5), parseInt(m.getAttribute("y"))+(header_height+grid_spacing*pin_index(p,m))];
    else if(p.nodeName == "in") return [parseInt(p.getAttribute("x"))+module_width/2-pin_width+5, parseInt(p.getAttribute("y"))+header_height];
    else if(p.nodeName == "out") return [parseInt(p.getAttribute("x"))-5, parseInt(p.getAttribute("y"))+header_height];
}

//Drawing functions

function draw_grid(c,s,w,h){
    c.lineWidth = 1;
    c.strokeStyle = "#CCCCCC";
    c.beginPath();
    for(var i=0; i <= w; i+=s){
	c.moveTo(i,0);
	c.lineTo(i,h);
    }
    for(var i=0; i <= h; i+=s){
	c.moveTo(0,i);
	c.lineTo(w,i);
    }
    c.stroke();
}

function draw_path(x,y,tx,ty,src,c,can){
    c.strokeStyle = src.getAttribute("colour") != null && src.getAttribute("colour") != "" ? src.getAttribute("colour") : "purple";
    c.lineWidth = 2;
    c.beginPath();
    //Draw a horizontal line
    c.moveTo(x,y);
    c.lineTo(x+grid_spacing, y);
    //console.log(x,y,tx,ty);
    var waypointcount = base_doc.evaluate("count(./wp)", src, null, XPathResult.NUMBER_TYPE, null).numberValue;
    var lastx = -1;
    if(waypointcount == 0){
	//c.lineTo(x+grid_spacing, y);
	if(tx < x){
	    c.lineTo(x+2*grid_spacing, y+(ty > y ? 100 : -100));
	    c.lineTo(tx-2*grid_spacing, y+(ty > y ? 100 : -100));
	}
	else if(tx > x + 3*grid_spacing) c.lineTo(tx-3*grid_spacing, y);
    }
    else{
	var waypoints = base_doc.evaluate("./wp", src, null, XPathResult.ANY_TYPE, null);
	for(var p = waypoints.iterateNext(); p != null; p = waypoints.iterateNext()){
	    lastx = parseInt(p.getAttribute("x"));
	    c.lineTo(parseInt(p.getAttribute("x")),parseInt(p.getAttribute("y")));
	}
    }
    if(lastx == -1 || lastx <= grid_spacing*Math.floor(tx/grid_spacing)+(x%grid_spacing)-grid_spacing) c.lineTo(grid_spacing*Math.floor(tx/grid_spacing)+(x%grid_spacing)-grid_spacing, ty);
    c.lineTo(tx,ty);
    c.stroke();

    if(state == "Edit Path"){
	if(waypointcount == 0){
	    c.fillStyle = "yellow";
	    c.beginPath();
	    c.moveTo(x+grid_spacing,y);
	    c.arc(x+grid_spacing,y,waypoint_radius,0,2*Math.PI,false);
	    c.lineTo(x+grid_spacing,y);
	    c.closePath();
	    c.fill()
	}
	else{
	    waypoints = base_doc.evaluate("./wp", src, null, XPathResult.ANY_TYPE, null);
	    for(var p = waypoints.iterateNext(); p != null; p = waypoints.iterateNext()){ 
		c.fillStyle = current_waypoint == p ? "red" : "yellow";
		c.beginPath();
		c.moveTo(parseInt(p.getAttribute("x")),parseInt(p.getAttribute("y")));
		c.arc(parseInt(p.getAttribute("x")),parseInt(p.getAttribute("y")),waypoint_radius,0,2*Math.PI,false);
		c.moveTo(parseInt(p.getAttribute("x")),parseInt(p.getAttribute("y")));
		c.closePath();
		c.fill()
	    }
	}
    }
}

function draw_connection(con,c,can){
    var target_mod = con.parentNode;
    if(target_mod.nodeName == "out") var target_pin = target_mod;
    else{
	var target_type = find_mod_type(target_mod.getAttribute("type"));
	var target_pin = find_pin(con.getAttribute("target"),target_type);
    }
    var tloc = pin_loc(target_pin,target_mod);var tx = tloc[0];var ty = tloc[1]+pin_height/2;

    // Write out the input combo if the connection is exploded: 
    if(con.getAttribute("explode") == "1"){
	var combo = "";
	var ch = con.firstChild;
	while(ch){
	    if(ch.nodeType == 3) combo += " "+ch.textContent.trim()+" ";
	    else if(ch.nodeType == 1 && ch.nodeName == "src") combo += ch.getAttribute("mod") + (ch.getAttribute("pin") == ch.getAttribute("mod") ? "" : "." + ch.getAttribute("pin"));
	    ch = ch.nextSibling;
	}
	var combo_width = c.measureText(combo+" ").width;
	tx -= combo_width+5;
	c.strokeStyle = "#CCCCCC";
	c.strokeRect(tx,tloc[1],combo_width,pin_height);
	c.strokeStyle = "purple";
	c.beginPath();
	c.moveTo(tx+combo_width,tloc[1]+pin_height/2);
	c.lineTo(tx+combo_width+5,tloc[1]+pin_height/2);
	c.closePath();
	c.stroke();
	c.fillStyle = "ffff99";
	c.fillRect(tx,tloc[1],c.measureText(combo+" ").width,pin_height);
	c.fillStyle = "black";
	c.fillText(combo,tx,ty+2);
	
    }
    
    var srcs = con.getElementsByTagName('src');
    var brief_srcs = [];
    var path_srcs = {};//Store like {pin_ID:[src_elt,x,y]}
    for(var i = 0; i < srcs.length; i++){
	var src_mod = find_module(srcs[i].getAttribute("mod") == "" ? srcs[i].getAttribute("pin") : srcs[i].getAttribute("mod"),current_type);
	if(src_mod.nodeName == "in") var src_pin = src_mod;
	else{
	    var src_type = find_mod_type(src_mod.getAttribute("type"));
	    var src_pin = find_pin(srcs[i].getAttribute("pin"),src_type);
	}
	//console.log("AAAAAAA");
	//console.log(src_mod);
	//console.log(srcs[i]);
	//console.log(con);
	//console.log(con.parentNode);
	if(srcs[i].getAttribute("brief") == "1"){
	    brief_srcs.push((src_mod.nodeName == "in" ? "" : srcs[i].getAttribute("mod")+":")+srcs[i].getAttribute("pin"));
	}
	else{
	    var loc = pin_loc(src_pin,src_mod);var x = loc[0]+pin_width;var y = loc[1]+pin_height/2;
	    var pin_id = srcs[i].getAttribute("mod") + "." + srcs[i].getAttribute("pin");
	    if(!(pin_id in path_srcs))  path_srcs[pin_id] = [srcs[i],x,y];
	    //draw_path(x,y,tx,ty,srcs[i],c,can);
	}
    }
    for(s in path_srcs){
	draw_path(path_srcs[s][1],path_srcs[s][2],tx,ty,path_srcs[s][0],c,can);
    }
    //Draw brief connections: 
    if(brief_srcs.length > 0){
	c.strokeStyle = "purple";
	c.beginPath();
	//Draw a horizontal line
	c.moveTo(tx-grid_spacing,ty);
	c.lineTo(tx,ty);
	c.stroke();
	c.fillStyle = "black";
	var ss = brief_srcs.join(",");
	c.fillText(ss,tx-grid_spacing-c.measureText(ss+" ").width,ty+pin_height/2-3);
    }
}

function get_mod_height(m){
    var mtype = find_mod_type(m.getAttribute("type"));
    var ins = mtype.getElementsByTagName('in');
    var outs = mtype.getElementsByTagName('out');
    return Math.max(ins.length,outs.length)*grid_spacing + header_height;
}

function draw_module(m,c,can){
    name = m.getAttribute("name")+(m.getAttribute("param") != null ? "("+m.getAttribute("param")+")" : "");
    x = parseInt(m.getAttribute("x"));
    y = parseInt(m.getAttribute("y"));
    //Find the corresponding module type and thereby find all pins this specifies
    var mtype = find_mod_type(m.getAttribute("type"));
    if(mtype  == null){ alert("parse error"); return; }
    var ins = mtype.getElementsByTagName('in');
    var outs = mtype.getElementsByTagName('out');
    var h = get_mod_height(m);
    var w = module_width;
    //Draw module, name, etc.
    c.strokeStyle = "black";
    c.strokeRect(x,y,w,h);
    c.fillStyle = dragging.indexOf(m) == -1 ? "white" : "#CCCCFF";
    c.fillRect(x,y,w,h);
    c.fillStyle = "black";
    c.font = "bold 10px Sans";
    c.fillText(name,x+10,y+10);
    c.font = "10px Sans";
    //Draw pins
    for(var i = 0; i < ins.length; i++){ draw_pin(ins[i],m,false,c,can); }
    for(var i = 0; i < outs.length; i++){ draw_pin(outs[i],m,true,c,can); }
}

function draw_pin(p,m,is_out,c,can){
    //Draw the pin p as a pin on the module m
    locs = pin_loc(p,m);
    var x = locs[0];
    var y = locs[1];
    var w = pin_width;
    var h = pin_height;
    c.fillStyle = (current_pin[0] == p && current_pin[1] == m) ? "#CCFFCC" : ((swapping_pin[0] == p && swapping_pin[1] == m) ? "#FCC" : "white");
    c.fillRect(x,y,pin_width,pin_height);
    c.strokeStyle = pin_ID(p,m) in selected_pins ? "blue" : "#CCCCCC";
    c.strokeRect(x,y,pin_width,pin_height);
    c.fillStyle = "black";
    c.fillText(p.getAttribute("name") + ":" + p.getAttribute("width"),x,y+10);
}

function draw_pin_mod(p,m,is_out,c,can){
    name = p.getAttribute("name");
    x = parseInt(p.getAttribute("x"));
    y = parseInt(p.getAttribute("y"));
    var w = module_width/2;
    var h = header_height+grid_spacing;
    //Draw pin, name, etc.
    c.strokeStyle = "black";
    c.strokeRect(x,y,w,h);
    c.fillStyle = dragging.indexOf(p) == -1 ? "white" : "#CCCCFF";
    //c.fillStyle = "white";
    c.fillRect(x,y,w,h);
    c.fillStyle = "black";
    c.font = "bold 10px Sans";
    c.fillText(name,x+10,y+10);
    c.font = "10px Sans";
    //Draw pins
    //x += is_out ? -5 : w-pin_width+5;
    //y += header_height;
    var arr = pin_loc(p,m);
    x = arr[0];
    y = arr[1];
    c.fillStyle = (current_pin[0] == p && current_pin[1] == p) ? "#CCFFCC" : "white";
    c.fillRect(x,y,pin_width,pin_height);
    c.strokeStyle = pin_ID(p,p) in selected_pins ? "blue" : "#CCCCCC";
    c.strokeRect(x,y,pin_width,pin_height);
    c.fillStyle = "black";
    c.fillText(p.getAttribute("name") + ":" + p.getAttribute("width"),x,y+10);
    //Draw the pin p as a pin module
}

function string_to_lines(s,w){
    var ws = s.split(" ");
    var ls= [];
    var current_line = "";
    for(i in ws){	
	if(c.measureText(current_line+ws[i]+" ").width > w){
	    ls.push(current_line);
	    current_line = ws[i] + " ";
	}
	else current_line += ws[i]+" ";
    }
    ls.push(current_line);
    return ls;
}

function comment_height(s,w){
    return string_to_lines(s,w-20).length*12+10;
}

function draw_cbox(b,c,can){
    var s = b.childNodes[0].nodeValue.trim();
    var x = parseInt(b.getAttribute("x"));
    var y = parseInt(b.getAttribute("y"));
    var w = parseInt(b.getAttribute("w"));
    var ls = string_to_lines(s,w-20);
    var h = ls.length*12+10;
    //console.log(h);
    c.strokeStyle = "black";
    c.strokeRect(x,y,w,h);
    c.fillStyle = dragging.indexOf(b) == -1 ? (associating_module == b ? "EEFFCC" : "EEFFEE") : "#CCCCFF";
    c.fillRect(x,y,w,h);
    c.fillStyle = "black";
    c.font = "10px Sans";
    if(state == "Comment"){
	c.fillStyle = "yellow";
	c.beginPath();
	c.moveTo(x+w,y+h);
	c.arc(x+w,y+h,waypoint_radius,0,2*Math.PI,false);
	c.lineTo(x+w,y+h);
	c.closePath();
	c.fill()
    }
    //console.log(c.measureText(s).width);
    c.fillStyle = "black";
    for(i in ls){
	c.fillText(ls[i],x+10,y+15+12*i);
    }
    if(b.getAttribute("type") != null && b.getAttribute("type") != ""){
	c.fillStyle = "yellow";
	c.fillText(b.getAttribute("type"),x+10,y);
    }
    var ams = base_doc.evaluate("./assoc", b, null, XPathResult.ANY_TYPE, null);
    for(var r = ams.iterateNext(); r != null; r = ams.iterateNext()){
	var am = base_doc.evaluate("./module[@name='"+r.getAttribute("mod")+"'] | ./in[@name='"+r.getAttribute("mod")+"'] | ./out[@name='"+r.getAttribute("mod")+"']", current_type, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
	if(am == null) console.log(r,am,ams,"PROBLEM!!");
	c.strokeStyle = "orange";
	c.beginPath();
	c.moveTo(x,y);
	c.lineTo(parseInt(am.getAttribute("x")),parseInt(am.getAttribute("y")));
	c.closePath();
	c.stroke();
    }
}

function draw_bbox(b,c,can){
    return;
}

function draw_type(t,c,can){
    //draw all ins, outs, and modules:

    var ctype_cond = comment_display_types.length == 0 ? "" : "[@type='"+comment_display_types.join("' or @type='") + "']";
    var ins = t.getElementsByTagName("in");
    var outs = t.getElementsByTagName("out");
    var mods = t.getElementsByTagName("module");
    var cbs = base_doc.evaluate("./cbox"+ctype_cond, t, null, XPathResult.ANY_TYPE, null);
    var bbs = t.getElementsByTagName("bbox");
    for(var i = cbs.iterateNext(); i != null; i = cbs.iterateNext()){ draw_cbox(i,c,can); }
    for(var i = 0; i < bbs.length; i++){ draw_bbox(bbs[i],c,can); }
    for(var i = 0; i < ins.length; i++){ draw_pin_mod(ins[i],current_type,false,c,can); }
    for(var i = 0; i < outs.length; i++){ draw_pin_mod(outs[i],current_type,true,c,can); }
    for(var i = 0; i < mods.length; i++){ draw_module(mods[i],c,can); }

    //Then draw all connections
    var cons = base_doc.evaluate("/chip/module_type[@name='"+t.getAttribute("name")+"']//conn", base_doc, null, XPathResult.ANY_TYPE, null);
    for(var r = cons.iterateNext(); r != null; r = cons.iterateNext()){ draw_connection(r,c,can); }
}

function draw_all(c,can){
    c.clearRect(0,0,can.width,can.height);
    draw_grid(c,grid_spacing,can.width,can.height);
    var all_buttons = get_buttons();
    for(var d in get_buttons()){
	all_buttons[d].draw(c);
    }
    draw_type(current_type,c,can);
}

function key_down(e){
    if(e.keyCode == 97 || e.keyCode == 65) adown = true;
    else if(e.keyCode == 98 || e.keyCode == 66) bdown = true;
    else if(e.keyCode == 99 || e.keyCode == 67) cdown = true;
    else if(e.keyCode == 120 || e.keyCode == 88) xdown = true;
    else if(e.keyCode == 115 || e.keyCode == 83) sdown = true;
    else if(e.keyCode == 100 || e.keyCode == 68) ddown = true;
    var ch = String.fromCharCode(e.keyCode).toLowerCase();
    //console.log(ch,e.altKey,shortcuts);
    if(e.altKey && e.shiftKey && (e.keyCode == 104 || e.keyCode == 72)){
	if(document.getElementById("status_div").style.visibility == "hidden") document.getElementById("status_div").style.visibility = "visible"
	else document.getElementById("status_div").style.visibility = "hidden"
    }
    if(e.altKey && e.shiftKey && ch in shortcuts){
	shortcuts[ch].action();
	draw_all(c,can);
    }
    else if(e.ctrlKey) tdown = true;
    else if(state == "Comment" && e.altKey && (e.keyCode == 116 || e.keyCode == 84)){
	var prompt_string = "Enter a comment-delimited list of types from the following list (or enter nothing to select all types): \n";
	var ctypes = [];
	var cts = base_doc.evaluate("//cbox/@type", current_type, null, XPathResult.ANY_TYPE, null);
	for(var i = cts.iterateNext(); i != null; i = cts.iterateNext()){
	    var ctype = i.textContent;
	    if(ctypes.indexOf(ctype) == -1) ctypes.push(ctype);
	}
	prompt_string += ctypes.join(", ");
	var the_types = prompt(prompt_string,comment_display_types.join(","));
	if(the_types == null) return;
	else if(the_types == "" )comment_display_types = [];
	else comment_display_types = the_types.trim().replace(/, +/g,',').split(",");
	draw_all(c,can);
    }
}

function key_up(e){
    if(e.keyCode == 97 || e.keyCode == 65) adown = false;
    else if(e.keyCode == 115 || e.keyCode == 83) sdown = false;
    else if(e.keyCode == 120 || e.keyCode == 88) xdown = false;
    else if(e.keyCode == 98 || e.keyCode == 66) bdown = false;
    else if(e.keyCode == 99 || e.keyCode == 67) cdown = false;
    else if(e.keyCode == 100 || e.keyCode == 68) ddown = false;
    if(!e.ctrlKey) tdown = false;
}

function mouse_click(e){
    var x = e.pageX - can.offsetLeft;
    var y = e.pageY - can.offsetTop;
    var b;
    if(state == "Edit Type" || state == "Del Type") b = find_in(x,y,get_nontype_buttons());
    else b = find_in(x,y,get_buttons());
    if(b != null) b.action();
    else states[state].click(x,y);
    draw_all(c,can);
}

function mouse_move(e){
    var x = e.pageX - can.offsetLeft;
    var y = e.pageY - can.offsetTop;
    states[state].move(x,y);
    //if(states[state].move != do_nothing)
	//draw_all(c,can);
}

function find_in(x,y,arr){
    for(var mod in arr){
	var m = arr[mod];
	if(x >= m.x && x <= m.x+m.w && y >= m.y && y <= m.y+m.h){ return m; }
    }
    return null;
}

function find_point_in_pin(x,y,m){
    if(m.nodeName == "in" || m.nodeName == "out"){
	var arr = pin_loc(m,m); var px = arr[0]; var py = arr[1];
	if(x >= px && x <= px+pin_width && y >= py && y <= py+pin_height) return m; 
	else return null;
    }
    var mtype = find_mod_type(m.getAttribute("type"));
    for(pin = mtype.firstElementChild; pin != null; pin = pin.nextElementSibling){
	if(pin.nodeName == "in" || pin.nodeName == "out"){
	    var arr = pin_loc(pin,m); var px = arr[0]; var py = arr[1];
	    if(x >= px && x <= px+pin_width && y >= py && y <= py+pin_height) return pin;
	}
    }
    return null;
}

function find_waypoint(x,y){
/*    var cons = base_doc.evaluate(".//conn", current_type, null, XPathResult.ANY_TYPE, null);
    for(var con = cons.iterateNext(); con != null; con = cons.iterateNext()){ 
	var srcs = con.getElementsByName("src");
	var distinct_srcs = []
	for(var i in srcs){
	    
	}
    }*/

    var waypoints = base_doc.evaluate(".//wp", current_type, null, XPathResult.ANY_TYPE, null);
    for(var p = waypoints.iterateNext(); p != null; p = waypoints.iterateNext()){ 
	wx = parseInt(p.getAttribute("x"));
	wy = parseInt(p.getAttribute("y"));
	if((x-wx)*(x-wx)+(y-wy)*(y-wy) < waypoint_radius*waypoint_radius) return p;
    }
    waypoints = base_doc.evaluate(".//src[count(./wp)=0]", current_type, null, XPathResult.ANY_TYPE, null);
    for(var s = waypoints.iterateNext(); s != null; s = waypoints.iterateNext()){ 
	console.log(current_type);
	console.log(s);
	var src_mod = find_module(s.getAttribute("mod") == "" ? s.getAttribute("pin") : s.getAttribute("mod"),current_type);
	console.log(src_mod);
	if(src_mod.nodeName == "in") var src_pin = src_mod;
	else{
	    var src_type = find_mod_type(src_mod.getAttribute("type"));
	    var src_pin = find_pin(s.getAttribute("pin"),src_type);
	}
	var loc = pin_loc(src_pin,src_mod);
	var wx = loc[0]+pin_width+grid_spacing;;
	var wy = loc[1]+pin_height/2;
	if((x-wx)*(x-wx)+(y-wy)*(y-wy) < waypoint_radius*waypoint_radius) return s;
    }
    return null;
}

function find_point_in_comment(x,y){
    cbs = base_doc.evaluate("./cbox", current_type, null, XPathResult.ANY_TYPE, null);
    for(var s = cbs.iterateNext(); s != null; s = cbs.iterateNext()){ 
	var mx = parseInt(s.getAttribute("x")); var my = parseInt(s.getAttribute("y")); var mw = parseInt(s.getAttribute("w"));var mh = parseInt(s.getAttribute("h"));  
	if((comment_display_types.length == 0 || comment_display_types.indexOf(s.getAttribute("type")) != -1) && x >= mx && x <= mx+mw && y >= my && y <= my+mh){ return s; }
    }
    return null;
}

function find_point_in_comment_corner(x,y){
    cbs = base_doc.evaluate("./cbox", current_type, null, XPathResult.ANY_TYPE, null);
    for(var s = cbs.iterateNext(); s != null; s = cbs.iterateNext()){ 
	var mx = parseInt(s.getAttribute("x")); var my = parseInt(s.getAttribute("y")); var mw = parseInt(s.getAttribute("w"));var mh = parseInt(s.getAttribute("h"));
	console.log(x,y);
	console.log(mx+mw,my+mh);
	if((comment_display_types.length == 0 || comment_display_types.indexOf(s.getAttribute("type")) != -1) && (x - mx - mw)*(x - mx - mw)+(y - my - mh)*(y - my - mh) < waypoint_radius*waypoint_radius){ return s; }
    }
    return null;
}

function find_point_in_mod(x,y){
    for(mod = current_type.firstElementChild; mod != null; mod = mod.nextElementSibling){
	if(mod.nodeName == "module"){
	    var mx = parseInt(mod.getAttribute("x")); var my = parseInt(mod.getAttribute("y")); 
	    if(x >= mx && x <= mx+module_width && y >= my && y <= my+header_height+get_mod_height(mod)){ return mod; }//3 is not right
	}
	else if(mod.nodeName == "in" || mod.nodeName == "out"){
	    var mx = parseInt(mod.getAttribute("x")); var my = parseInt(mod.getAttribute("y")); 
	    if(x >= mx && x <= mx+module_width/2 && y >= my && y <= my+header_height+grid_spacing){ return mod; }
	}
    }
    return null;
}

var chip = find_mod_type("Chip");
var current_type = chip;
draw_all(c,can);
