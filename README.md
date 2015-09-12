## Synopsis

Glove is a set of utilities for designing modules in limited Verilog
without requiring any more writing of actual Verilog than you wish to
do by hand.

It consists of two main pieces: Over (found in `over.html` and
`over.js`) and ControlGen (done by `gen_controls.py`).

Over is an HTML5 Canvas app for connecting and navigating modules that
can be expressed purely in structural Verilog.  The chip data is
stored in an XML format that can be converted to Verilog using
`verilog.xsl`.  There is an experimental XSLT file `pipeline_reg.xsl`
for automatically adding pipeline registers between stages of the
chip.

ControlGen is a Python script for generating a control module for such
a chip, and more generally can be used to construct state machines.

## Running Over

To run Over, simply clone this repo, nagivate to the directory, run
`python3 -m http.server 8888` and put `localhost:8888/over.html` into
your browser.

## Running ControlGen

To run ControlGen, do:

```
./control_gen.py controls.csv mappings.csv control_module_name verilog|xml
```

where controls.csv is a CSV file whose columns are the various
possible conditions and whose rows are the values (possibly by name
instead of by number) of various control registers under the
corresponding conditions, and mappings.csv maps those names to actual
binary values.

If the fourth argument is `verilog` it will output the appropriate
case statement inside a verilog module named by the third argument.
If instead the fourth arg is `xml`, it will output a module_type
definition of the control module's interface.

An example of a controls.csv and mappings.csv is found in the `growl`
directory.

## Converting to Verilog

When you have finished creating the chip, the "Save" button will put
the corresponding XML into the textbox at the bottom of the page.
Copy this out into a separate XML file (say, called chip.xml).

Then

```
xsltproc verilog.xsl chip.xml
```

will output all the Verilog modules separated by a line of the form

```
// ----
```

These can be broken out into separate files by a simple sed script.
For exmaple, see `growl/build`.

## Experimental Auto-Pipelining

`pipeline_reg.xsl` is intended for use in pipelining an XML chip.

It will take all modules in the top-level Chip module_type and will
create a `bank' for each of them, with one register for each wire that
goes from an earlier module to a later one in the pipeline order (so
for instance, if a wire connects stage 1 to stage 4, then registers
wll be created in the banks following stages 1, 2, and 3).  The
pipeline order is currently determined by the xsl using the ordering
of the module XML elements in the file.  If the file was created
solely using rover, this will correspond to the creation order, but
the elements can be reordered by hand if the creation order is not the
correct pipeline order.

This xsl will create a register bank for the last stage as well, so
this extra bank will have to be deleted by hand.  It would not be
difficult to add a parameter to the stylesheet allowing the last bank
to be specified.  

## License

Glove is licensed under the [MIT License](http://opensource.org/licenses/MIT)
