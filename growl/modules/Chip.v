    module Chip(cp2,ireset,inst,dbusin,irqlines,pc,adr,iore,iowe,ramadr,ramre,ramwe,dbusout,irqack,arqackar,sleepi,irqok,globint,wdri);
    input cp2;
    input ireset;
    input [15:0] inst;
    input [7:0] dbusin;
    input [22:0] irqlines;
    output [15:0] pc;
    output [15:0] adr;
    output iore;
    output iowe;
    output [15:0] ramadr;
    output ramre;
    output ramwe;
    output [7:0] dbusout;
    output irqack;
    output [4:0] arqackar;
    output sleepi;
    output irqok;
    output globint;
    output wdri;
    wire operand0_rampz;
    wire [7:0] operand0_imm_out;
    wire [7:0] operand0_rd_out;
    wire [7:0] operand0_rr_out;
    wire [7:0] operand0_sreg_out;
    wire [15:0] operand0_Z;
    wire [7:0] operand0_temp;
    wire [7:0] operand0_dbusin_int;
    wire [15:0] operand0_ram_addr;
    wire operand0_mem_to_reg_out;
    wire [7:0] execute0_ex_out;
    wire [7:0] execute0_new_sreg;
    wire [15:0] execute0_pc_plus_offset;
    wire execute0_branch_taken;
    wire [7:0] memory0_mem_output;
    wire [7:0] memory0_dbus_out;
    wire [5:0] memory0_adr;
    wire memory0_ram_re;
    wire memory0_ram_we;
    wire memory0_io_re;
    wire memory0_io_we;
    wire [15:0] fetch0_addr;
    wire decode0_is_32_bit;
    wire decode0_c_new_sreg_sel;
    wire [1:0] decode0_c_imem_addr_sel;
    wire decode0_c_adiw_phase;
    wire [2:0] decode0_c_ram_adr_sel;
    wire [1:0] decode0_c_sp_op;
    wire [1:0] decode0_c_io_op;
    wire [1:0] decode0_c_rd_rr_sel;
    wire decode0_c_branch_mode;
    wire [1:0] decode0_c_mem_out_sel;
    wire [1:0] decode0_c_alu_a_sel;
    wire [1:0] decode0_c_dbus_out_sel;
    wire [1:0] decode0_c_rh_op;
    wire [2:0] decode0_c_pc_next;
    wire decode0_c_ex_out_sel;
    wire decode0_c_rampz_inc;
    wire [1:0] decode0_c_rh_sel;
    wire [3:0] decode0_c_alu_op;
    wire decode0_c_pc_stall;
    wire decode0_c_alu_b_sel;
    wire [3:0] decode0_c_imm_type;
    wire [7:0] decode0_c_flags_mask;
    wire decode0_c_pc_offset_mode;
    wire [1:0] decode0_c_dbus_addr_sel;
    wire decode0_c_rd_w_en;
    wire [1:0] decode0_c_ram_op;
    
    operand  operand0(
    //Inputs
    .inst_in(inst),
    .c_rd_rr_sel(decode0_c_rd_rr_sel),
    .c_adiw_phase(decode0_c_adiw_phase),
    .c_rd_w_en(decode0_c_rd_w_en),
    .c_ram_op(decode0_c_ram_op),
    .c_ram_addr_sel(decode0_c_ram_adr_sel),
    .c_rh_sel(decode0_c_rh_sel),
    .c_imm_type_in(decode0_c_imm_type),
    .c_rampz_inc(decode0_c_rampz_inc),
    .c_sp_op(decode0_c_sp_op),
    .c_rh_op(decode0_c_rh_op),
    .mem_out_in(memory0_mem_output),
    .dbus_adr(memory0_adr),
    .io_re(memory0_io_re),
    .io_we(memory0_io_we),
    .dbus_out(memory0_dbus_out),
    .dbusin_ext(dbusin),
    .sreg_in(execute0_new_sreg),
    .clk(cp2),
    .rst(ireset),
    //Outputs
    .rampz(operand0_rampz),
    .imm_out(operand0_imm_out),
    .rd_out(operand0_rd_out),
    .rr_out(operand0_rr_out),
    .sreg_out(operand0_sreg_out),
    .Z(operand0_Z),
    .temp(operand0_temp),
    .dbusin_int(operand0_dbusin_int),
    .ram_addr(operand0_ram_addr),
    .mem_to_reg_out(operand0_mem_to_reg_out));
  
    execute  execute0(
    //Inputs
    .inst_in(inst),
    .imm_in(operand0_imm_out),
    .rd_in(operand0_rd_out),
    .rr_in(operand0_rr_out),
    .sreg_in(operand0_sreg_out),
    .Z(operand0_Z),
    .temp(operand0_temp),
    .c_alu_a_sel(decode0_c_alu_a_sel),
    .pc_in(fetch0_addr),
    .c_branch_mode(decode0_c_branch_mode),
    .c_alu_b_sel(decode0_c_alu_b_sel),
    .c_flags_mask(decode0_c_flags_mask),
    .c_alu_op(decode0_c_alu_op),
    .c_pc_offset_mode(decode0_c_pc_offset_mode),
    .c_new_sreg_sel(decode0_c_new_sreg_sel),
    .c_ex_out(decode0_c_ex_out_sel),
    //Outputs
    .ex_out(execute0_ex_out),
    .new_sreg(execute0_new_sreg),
    .pc_plus_offset(execute0_pc_plus_offset),
    .branch_taken(execute0_branch_taken));
  
    memory  memory0(
    //Inputs
    .ex_out(execute0_ex_out),
    .dbus_in(operand0_dbusin_int),
    .imm_in(operand0_imm_out),
    .ram_addr_in(operand0_ram_addr),
    .c_ram_re(decode0_c_ram_op[1]),
    .c_ram_we(decode0_c_ram_op[0]),
    .c_io_re(decode0_c_io_op[1]),
    .c_io_we(decode0_c_io_op[0]),
    .c_dbus_adr_sel(decode0_c_dbus_addr_sel),
    .c_dbus_out_sel(decode0_c_dbus_out_sel),
    .c_mem_out_sel(decode0_c_mem_out_sel),
    .mem_to_reg_in(operand0_mem_to_reg_out),
    //Outputs
    .mem_output(memory0_mem_output),
    .dbus_out(memory0_dbus_out),
    .adr(memory0_adr),
    .ram_re(memory0_ram_re),
    .ram_we(memory0_ram_we),
    .io_re(memory0_io_re),
    .io_we(memory0_io_we));
  
    fetch  fetch0(
    //Inputs
    .Z(operand0_Z),
    .rampz0_in(operand0_rampz),
    .inst(inst),
    .c_pc_next(decode0_c_pc_next),
    .c_pc_stall(decode0_c_pc_stall),
    .ireset(ireset),
    .c_imem_addr_sel(decode0_c_imem_addr_sel),
    .pc_plus_offset(execute0_pc_plus_offset),
    .branch_taken(execute0_branch_taken),
    .temp_in(operand0_temp),
    .is_32_in(decode0_is_32_bit),
    .clk(cp2),
    //Outputs
    .addr(fetch0_addr));
  
    decode  decode0(
    //Inputs
    .inst_in(inst),
    .branch_taken_in(execute0_branch_taken),
    .clk(cp2),
    .rst(ireset),
    //Outputs
    .is_32_bit(decode0_is_32_bit),
    .c_new_sreg_sel(decode0_c_new_sreg_sel),
    .c_imem_addr_sel(decode0_c_imem_addr_sel),
    .c_adiw_phase(decode0_c_adiw_phase),
    .c_ram_adr_sel(decode0_c_ram_adr_sel),
    .c_sp_op(decode0_c_sp_op),
    .c_io_op(decode0_c_io_op),
    .c_rd_rr_sel(decode0_c_rd_rr_sel),
    .c_branch_mode(decode0_c_branch_mode),
    .c_mem_out_sel(decode0_c_mem_out_sel),
    .c_alu_a_sel(decode0_c_alu_a_sel),
    .c_dbus_out_sel(decode0_c_dbus_out_sel),
    .c_rh_op(decode0_c_rh_op),
    .c_pc_next(decode0_c_pc_next),
    .c_ex_out_sel(decode0_c_ex_out_sel),
    .c_rampz_inc(decode0_c_rampz_inc),
    .c_rh_sel(decode0_c_rh_sel),
    .c_alu_op(decode0_c_alu_op),
    .c_pc_stall(decode0_c_pc_stall),
    .c_alu_b_sel(decode0_c_alu_b_sel),
    .c_imm_type(decode0_c_imm_type),
    .c_flags_mask(decode0_c_flags_mask),
    .c_pc_offset_mode(decode0_c_pc_offset_mode),
    .c_dbus_addr_sel(decode0_c_dbus_addr_sel),
    .c_rd_w_en(decode0_c_rd_w_en),
    .c_ram_op(decode0_c_ram_op));
  
    assign pc = fetch0_addr;
    assign adr = memory0_adr;
    assign iore = memory0_io_re;
    assign iowe = memory0_io_we;
    assign ramadr = operand0_ram_addr;
    assign ramre = memory0_ram_re;
    assign ramwe = memory0_ram_we;
    assign dbusout = memory0_dbus_out;
    assign irqack = ;
    assign arqackar = ;
    assign sleepi = ;
    assign irqok = ;
    assign globint = ;
    assign wdri = ;

    endmodule
