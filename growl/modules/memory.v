    module memory(ex_out,dbus_in,imm_in,ram_addr_in,c_ram_re,c_ram_we,c_io_re,c_io_we,c_dbus_adr_sel,c_dbus_out_sel,c_mem_out_sel,mem_to_reg_in,mem_output,dbus_out,adr,ram_re,ram_we,io_re,io_we);
    input [7:0] ex_out;
    input [7:0] dbus_in;
    input [7:0] imm_in;
    input [15:0] ram_addr_in;
    input c_ram_re;
    input c_ram_we;
    input c_io_re;
    input c_io_we;
    input [1:0] c_dbus_adr_sel;
    input [1:0] c_dbus_out_sel;
    input c_mem_out_sel;
    input mem_to_reg_in;
    output [7:0] mem_output;
    output [7:0] dbus_out;
    output [5:0] adr;
    output ram_re;
    output ram_we;
    output io_re;
    output io_we;
    wire [7:0] mem_mux_out;
    wire [7:0] dbus_mux_out;
    wire [5:0] adr_mux_out;
    
    mux2 #(8) mem_mux(
    //Inputs
    .i0(dbus_in),
    .i1(ex_out),
    .sel(c_mem_out_sel|mem_to_reg_in),
    //Outputs
    .out(mem_mux_out));
  
    mux4 #(8) dbus_mux(
    //Inputs
    .i0(),
    .i1(),
    .i2(ex_out),
    .i3(),
    .sel(c_dbus_out_sel),
    //Outputs
    .out(dbus_mux_out));
  
    mux4 #(6) adr_mux(
    //Inputs
    .i0(imm_in[5:0]),
    .i1({1,imm_in[4:0]}),
    .i2({ram_addr_in[6],ram_addr_in[4:0]}),
    .i3(),
    .sel(c_dbus_adr_sel),
    //Outputs
    .out(adr_mux_out));
  
    assign mem_output = mem_mux_out;
    assign dbus_out = dbus_mux_out;
    assign adr = adr_mux_out;
    assign ram_re = ;
    assign ram_we = ;
    assign io_re = c_io_re|((ram_addr_in[15:7]==0)&amp;(ram_addr_in[6]^ram_addr_in[5])&amp;c_ram_re);
    assign io_we = c_io_we|((ram_addr_in[15:7]==0)&amp;(ram_addr_in[6]^ram_addr_in[5])&amp;c_ram_we);

    endmodule
