    module decode(inst_in,branch_taken_in,clk,rst,is_32_bit,c_new_sreg_sel,c_imem_addr_sel,c_adiw_phase,c_ram_adr_sel,c_sp_op,c_io_op,c_rd_rr_sel,c_branch_mode,c_mem_out_sel,c_alu_a_sel,c_dbus_out_sel,c_rh_op,c_pc_next,c_ex_out_sel,c_rampz_inc,c_rh_sel,c_alu_op,c_pc_stall,c_alu_b_sel,c_imm_type,c_flags_mask,c_pc_offset_mode,c_dbus_addr_sel,c_rd_w_en,c_ram_op);
    input [15:0] inst_in;
    input branch_taken_in;
    input clk;
    input rst;
    output is_32_bit;
    output c_new_sreg_sel;
    output [1:0] c_imem_addr_sel;
    output c_adiw_phase;
    output [2:0] c_ram_adr_sel;
    output [1:0] c_sp_op;
    output [1:0] c_io_op;
    output [1:0] c_rd_rr_sel;
    output c_branch_mode;
    output [1:0] c_mem_out_sel;
    output [1:0] c_alu_a_sel;
    output [1:0] c_dbus_out_sel;
    output [1:0] c_rh_op;
    output [2:0] c_pc_next;
    output c_ex_out_sel;
    output c_rampz_inc;
    output [1:0] c_rh_sel;
    output [3:0] c_alu_op;
    output c_pc_stall;
    output c_alu_b_sel;
    output [3:0] c_imm_type;
    output [7:0] c_flags_mask;
    output c_pc_offset_mode;
    output [1:0] c_dbus_addr_sel;
    output c_rd_w_en;
    output [1:0] c_ram_op;
    wire control0_c_new_sreg_sel;
    wire [1:0] control0_c_imem_addr_sel;
    wire control0_c_adiw_phase;
    wire [1:0] control0_c_sp_op;
    wire [2:0] control0_c_ram_adr_sel;
    wire [1:0] control0_c_io_op;
    wire [1:0] control0_c_ram_op;
    wire control0_c_rd_w_en;
    wire [1:0] control0_c_dbus_addr_sel;
    wire control0_c_pc_offset_mode;
    wire [7:0] control0_c_flags_mask;
    wire [2:0] control0_c_imm_type;
    wire control0_c_alu_b_sel;
    wire control0_c_pc_stall;
    wire [3:0] control0_c_alu_op;
    wire [1:0] control0_c_rh_sel;
    wire control0_c_rampz_inc;
    wire control0_c_ex_out_sel;
    wire [2:0] control0_c_pc_next;
    wire [1:0] control0_c_rh_op;
    wire [1:0] control0_c_dbus_out_sel;
    wire [1:0] control0_c_alu_a_sel;
    wire control0_c_mem_out_sel;
    wire control0_c_branch_mode;
    wire [1:0] control0_c_rd_rr_sel;
    wire [1:0] control0_c_next_state;
    wire control0_c_skip;
    wire [15:0] inst_latch_q;
    wire [1:0] state_reg_q;
    wire is_state_zero_result;
    wire [15:0] which_inst_out;
    wire [1:0] skip_mux_out;
    wire is_inst_32_bit_is_32_bit;
    
    control  control0(
    //Inputs
    .inst(which_inst_out),
    .state(state_reg_q),
    //Outputs
    .c_new_sreg_sel(control0_c_new_sreg_sel),
    .c_imem_addr_sel(control0_c_imem_addr_sel),
    .c_adiw_phase(control0_c_adiw_phase),
    .c_sp_op(control0_c_sp_op),
    .c_ram_adr_sel(control0_c_ram_adr_sel),
    .c_io_op(control0_c_io_op),
    .c_ram_op(control0_c_ram_op),
    .c_rd_w_en(control0_c_rd_w_en),
    .c_dbus_addr_sel(control0_c_dbus_addr_sel),
    .c_pc_offset_mode(control0_c_pc_offset_mode),
    .c_flags_mask(control0_c_flags_mask),
    .c_imm_type(control0_c_imm_type),
    .c_alu_b_sel(control0_c_alu_b_sel),
    .c_pc_stall(control0_c_pc_stall),
    .c_alu_op(control0_c_alu_op),
    .c_rh_sel(control0_c_rh_sel),
    .c_rampz_inc(control0_c_rampz_inc),
    .c_ex_out_sel(control0_c_ex_out_sel),
    .c_pc_next(control0_c_pc_next),
    .c_rh_op(control0_c_rh_op),
    .c_dbus_out_sel(control0_c_dbus_out_sel),
    .c_alu_a_sel(control0_c_alu_a_sel),
    .c_mem_out_sel(control0_c_mem_out_sel),
    .c_branch_mode(control0_c_branch_mode),
    .c_rd_rr_sel(control0_c_rd_rr_sel),
    .c_next_state(control0_c_next_state),
    .c_skip(control0_c_skip));
  
    latch #(16) inst_latch(
    //Inputs
    .d(inst_in),
    .en(is_state_zero_result),
    .clk(clk),
    .rst(rst),
    //Outputs
    .q(inst_latch_q));
  
    register #(2) state_reg(
    //Inputs
    .d(skip_mux_out),
    .clk(clk),
    .rst(rst),
    //Outputs
    .q(state_reg_q));
  
    is_zero #(2) is_state_zero(
    //Inputs
    .d(state_reg_q),
    //Outputs
    .result(is_state_zero_result));
  
    mux2 #(16) which_inst(
    //Inputs
    .i0(inst_latch_q),
    .i1(inst_in),
    .sel(is_state_zero_result),
    //Outputs
    .out(which_inst_out));
  
    mux2 #(2) skip_mux(
    //Inputs
    .i0(0),
    .i1(control0_c_next_state),
    .sel(control0_c_skip&amp;branch_taken_in),
    //Outputs
    .out(skip_mux_out));
  
    is_32_bit  is_inst_32_bit(
    //Inputs
    .inst_in(inst_in),
    //Outputs
    .is_32_bit(is_inst_32_bit_is_32_bit));
  
    assign is_32_bit = is_inst_32_bit_is_32_bit;
    assign c_new_sreg_sel = control0_c_new_sreg_sel;
    assign c_imem_addr_sel = control0_c_imem_addr_sel;
    assign c_adiw_phase = control0_c_adiw_phase;
    assign c_ram_adr_sel = control0_c_ram_adr_sel;
    assign c_sp_op = control0_c_sp_op;
    assign c_io_op = control0_c_io_op;
    assign c_rd_rr_sel = control0_c_rd_rr_sel;
    assign c_branch_mode = control0_c_branch_mode;
    assign c_mem_out_sel = control0_c_mem_out_sel;
    assign c_alu_a_sel = control0_c_alu_a_sel;
    assign c_dbus_out_sel = control0_c_dbus_out_sel;
    assign c_rh_op = control0_c_rh_op;
    assign c_pc_next = control0_c_pc_next;
    assign c_ex_out_sel = control0_c_ex_out_sel;
    assign c_rampz_inc = control0_c_rampz_inc;
    assign c_rh_sel = control0_c_rh_sel;
    assign c_alu_op = control0_c_alu_op;
    assign c_pc_stall = control0_c_pc_stall;
    assign c_alu_b_sel = control0_c_alu_b_sel;
    assign c_imm_type = control0_c_imm_type;
    assign c_flags_mask = control0_c_flags_mask;
    assign c_pc_offset_mode = control0_c_pc_offset_mode;
    assign c_dbus_addr_sel = control0_c_dbus_addr_sel;
    assign c_rd_w_en = control0_c_rd_w_en;
    assign c_ram_op = control0_c_ram_op;

    endmodule
