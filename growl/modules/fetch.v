    module fetch(Z,rampz0_in,inst,c_pc_next,c_pc_stall,ireset,c_imem_addr_sel,pc_plus_offset,branch_taken,temp_in,is_32_in,clk,addr);
    input [15:0] Z;
    input rampz0_in;
    input [15:0] inst;
    input [1:0] c_pc_next;
    input c_pc_stall;
    input ireset;
    input [1:0] c_imem_addr_sel;
    input [15:0] pc_plus_offset;
    input branch_taken;
    input [7:0] temp_in;
    input is_32_in;
    input clk;
    output [15:0] addr;
    wire [15:0] pc_latch_q;
    wire [15:0] pc_stall_out;
    wire [15:0] branch_mux_out;
    wire [15:0] pc_increment_output;
    wire [15:0] next_pc_mux_out;
    wire [15:0] pc_skip_out;
    wire [15:0] addr_mux_out;
    
    latch #(16) pc_latch(
    //Inputs
    .d(next_pc_mux_out),
    .en(ireset),
    .clk(clk),
    .rst(ireset),
    //Outputs
    .q(pc_latch_q));
  
    mux2 #(16) pc_stall(
    //Inputs
    .i0(pc_latch_q),
    .i1(pc_increment_output),
    .sel(c_pc_stall),
    //Outputs
    .out(pc_stall_out));
  
    mux2 #(16) branch_mux(
    //Inputs
    .i0(pc_stall_out),
    .i1(pc_plus_offset),
    .sel(branch_taken),
    //Outputs
    .out(branch_mux_out));
  
    inc #(16) pc_increment(
    //Inputs
    .input(pc_latch_q),
    //Outputs
    .output(pc_increment_output));
  
    mux8 #(16) next_pc_mux(
    //Inputs
    .i0(pc_stall_out),
    .i1(pc_plus_offset),
    .i2(branch_mux_out),
    .i3(inst),
    .i4(temp_in),
    .i5(),
    .i6(pc_skip_out),
    .i7({0000,inst[11:0]}),
    .sel(c_pc_next),
    //Outputs
    .out(next_pc_mux_out));
  
    mux2 #(16) pc_skip(
    //Inputs
    .i0(pc_latch_q+1),
    .i1(pc_latch_q+2),
    .sel(is_32_in),
    //Outputs
    .out(pc_skip_out));
  
    mux4 #(16) addr_mux(
    //Inputs
    .i0(pc_latch_q),
    .i1({0,Z[15:1]}),
    .i2({rampz0_in,Z[15:1]}),
    .i3(),
    .sel(c_imem_addr_sel),
    //Outputs
    .out(addr_mux_out));
  
    assign addr = addr_mux_out;

    endmodule
