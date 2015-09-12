    module execute(inst_in,imm_in,rd_in,rr_in,sreg_in,Z,temp,c_alu_a_sel,pc_in,c_branch_mode,c_alu_b_sel,c_flags_mask,c_alu_op,c_pc_offset_mode,c_new_sreg_sel,c_ex_out,ex_out,new_sreg,pc_plus_offset,branch_taken);
    input [15:0] inst_in;
    input [7:0] imm_in;
    input [7:0] rd_in;
    input [7:0] rr_in;
    input [7:0] sreg_in;
    input [15:0] Z;
    input [7:0] temp;
    input [1:0] c_alu_a_sel;
    input [15:0] pc_in;
    input c_branch_mode;
    input c_alu_b_sel;
    input [7:0] c_flags_mask;
    input [3:0] c_alu_op;
    input c_pc_offset_mode;
    input c_new_sreg_sel;
    input c_ex_out;
    output [7:0] ex_out;
    output [7:0] new_sreg;
    output [15:0] pc_plus_offset;
    output branch_taken;
    wire [7:0] alu0_result;
    wire [6:0] alu0_flags;
    wire [7:0] output_mux_out;
    wire [7:0] z_mux_out;
    wire [7:0] sreg_mux_out;
    wire [7:0] sreg_compute_output;
    wire [15:0] pc_offset_comp_pc_plus_offset;
    wire [7:0] aluB_mux_out;
    wire [7:0] aluA_mux_out;
    
    alu  alu0(
    //Inputs
    .A(aluA_mux_out),
    .B(aluB_mux_out),
    .op(c_alu_op),
    .T(sreg_in[7]),
    .C(sreg_in[0]),
    //Outputs
    .result(alu0_result),
    .flags(alu0_flags));
  
    mux2 #(8) output_mux(
    //Inputs
    .i0(z_mux_out),
    .i1(alu0_result),
    .sel(c_ex_out),
    //Outputs
    .out(output_mux_out));
  
    mux2 #(8) z_mux(
    //Inputs
    .i0(inst_in[15:8]),
    .i1(inst_in[7:0]),
    .sel(Z[0]),
    //Outputs
    .out(z_mux_out));
  
    mux2 #(8) sreg_mux(
    //Inputs
    .i0(alu0_result),
    .i1(sreg_compute_output),
    .sel(c_new_sreg_sel),
    //Outputs
    .out(sreg_mux_out));
  
    bitwise_mux  sreg_compute(
    //Inputs
    .i0({0,alu0_flags}),
    .i1(sreg_in),
    .mask(c_flags_mask),
    //Outputs
    .output(sreg_compute_output));
  
    offset_comp  pc_offset_comp(
    //Inputs
    .pc(pc_in),
    .inst(inst_in),
    .c_pc_offset_mode(c_pc_offset_mode),
    //Outputs
    .pc_plus_offset(pc_offset_comp_pc_plus_offset));
  
    mux2 #(8) aluB_mux(
    //Inputs
    .i0(rr_in),
    .i1(imm_in),
    .sel(c_alu_b_sel),
    //Outputs
    .out(aluB_mux_out));
  
    mux4 #(8) aluA_mux(
    //Inputs
    .i0(rd_in),
    .i1(sreg_in),
    .i2(temp),
    .i3(0),
    .sel(c_alu_a_sel),
    //Outputs
    .out(aluA_mux_out));
  
    assign ex_out = output_mux_out;
    assign new_sreg = sreg_mux_out;
    assign pc_plus_offset = pc_offset_comp_pc_plus_offset;
    assign branch_taken = c_branch_mode~^alu0_flags[1];

    endmodule
