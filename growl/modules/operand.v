    module operand(inst_in,c_rd_rr_sel,c_adiw_phase,c_rd_w_en,c_ram_op,c_ram_addr_sel,c_rh_sel,c_imm_type_in,c_rampz_inc,c_sp_op,c_rh_op,mem_out_in,dbus_adr,io_re,io_we,dbus_out,dbusin_ext,sreg_in,clk,rst,rampz,imm_out,rd_out,rr_out,sreg_out,Z,temp,dbusin_int,ram_addr,mem_to_reg_out);
    input [15:0] inst_in;
    input c_rd_rr_sel;
    input c_adiw_phase;
    input c_rd_w_en;
    input [1:0] c_ram_op;
    input [2:0] c_ram_addr_sel;
    input [1:0] c_rh_sel;
    input [2:0] c_imm_type_in;
    input c_rampz_inc;
    input [1:0] c_sp_op;
    input [1:0] c_rh_op;
    input [7:0] mem_out_in;
    input [5:0] dbus_adr;
    input io_re;
    input io_we;
    input [7:0] dbus_out;
    input [7:0] dbusin_ext;
    input [7:0] sreg_in;
    input clk;
    input rst;
    output rampz;
    output [7:0] imm_out;
    output [7:0] rd_out;
    output [7:0] rr_out;
    output [7:0] sreg_out;
    output [15:0] Z;
    output [7:0] temp;
    output [7:0] dbusin_int;
    output [15:0] ram_addr;
    output mem_to_reg_out;
    wire [4:0] rr_mux_out;
    wire [7:0] rf_rd_out;
    wire [7:0] rf_rr_out;
    wire [15:0] rf_rh_out;
    wire [15:0] rf_Z;
    wire [4:0] rd_st_mux_out;
    wire [4:0] rr_ld_mux_out;
    wire wr_en_mux_out;
    wire [4:0] swap_rd_rr_mux_out;
    wire [7:0] temp_q;
    wire [7:0] imm_prep0_imm;
    wire [7:0] io_reg_file_sreg;
    wire [7:0] io_reg_file_spl;
    wire [7:0] io_reg_file_sph;
    wire io_reg_file_rampz;
    wire [7:0] io_reg_file_dbusin_int;
    wire [15:0] add_q_output;
    wire mem_to_reg_result;
    wire [4:0] rd_mux_out;
    wire [15:0] mem_mux_out;
    
    mux2 #(5) rr_mux(
    //Inputs
    .i0({inst_in[9],inst_in[3:0]}),
    .i1({1,inst_in[3:0]}),
    .sel(c_rd_rr_sel),
    //Outputs
    .out(rr_mux_out));
  
    reg_file  rf(
    //Inputs
    .rd_sel(rd_st_mux_out),
    .rr_sel(rr_ld_mux_out),
    .wr_en(wr_en_mux_out),
    .rh_sel(c_rh_sel),
    .rd_in(mem_out_in),
    .rh_op(c_rh_op),
    .clk(clk),
    .rst(rst),
    //Outputs
    .rd_out(rf_rd_out),
    .rr_out(rf_rr_out),
    .rh_out(rf_rh_out),
    .Z(rf_Z));
  
    mux2 #(5) rd_st_mux(
    //Inputs
    .i0(rd_mux_out),
    .i1(add_q_output[4:0]),
    .sel(c_ram_op[0]),
    //Outputs
    .out(rd_st_mux_out));
  
    mux2 #(5) rr_ld_mux(
    //Inputs
    .i0(swap_rd_rr_mux_out),
    .i1(mem_mux_out[4:0]),
    .sel(c_ram_op[1]),
    //Outputs
    .out(rr_ld_mux_out));
  
    mux2 #(1) wr_en_mux(
    //Inputs
    .i0(c_rd_w_en),
    .i1(mem_to_reg_result),
    .sel(c_ram_op[0]),
    //Outputs
    .out(wr_en_mux_out));
  
    mux2 #(5) swap_rd_rr_mux(
    //Inputs
    .i0(rd_mux_out),
    .i1(rr_mux_out),
    .sel(c_ram_op[0]),
    //Outputs
    .out(swap_rd_rr_mux_out));
  
    register #(8) temp(
    //Inputs
    .d(mem_out_in),
    .clk(clk),
    .rst(rst),
    //Outputs
    .q(temp_q));
  
    imm_prep  imm_prep0(
    //Inputs
    .c_imm_type(c_imm_type_in),
    .inst_in(inst_in),
    //Outputs
    .imm(imm_prep0_imm));
  
    loc_io_reg_file  io_reg_file(
    //Inputs
    .c_rampz0_inc(c_rampz_inc),
    .dbusin(0dbusin_ext),
    .dbus_adr(dbus_adr),
    .sreg_in(sreg_in),
    .dbus_out(dbus_out),
    .sp_op(c_sp_op),
    .io_op({io_re,io_we}),
    .clk(clk),
    .rst(rst),
    //Outputs
    .sreg(io_reg_file_sreg),
    .spl(io_reg_file_spl),
    .sph(io_reg_file_sph),
    .rampz(io_reg_file_rampz),
    .dbusin_int(io_reg_file_dbusin_int));
  
    z_adder  add_q(
    //Inputs
    .i0(rf_rh_out),
    .i1(imm_prep0_imm),
    //Outputs
    .output(add_q_output));
  
    is_zero #(11) mem_to_reg(
    //Inputs
    .d(mem_mux_out[15:5]),
    //Outputs
    .result(mem_to_reg_result));
  
    mux4 #(5) rd_mux(
    //Inputs
    .i0({11,inst_in[5:4],c_adiw_phase}),
    .i1(inst_in[8:4]),
    .i2({1,inst_in[7:4]}),
    .i3(0),
    .sel(c_rd_rr_sel),
    //Outputs
    .out(rd_mux_out));
  
    mux8 #(16) mem_mux(
    //Inputs
    .i0(inst_in),
    .i1(rf_rh_out),
    .i2({io_reg_file_sph,io_reg_file_spl}),
    .i3(add_q_output),
    .i4({~inst_in[8],inst_in[8],inst_in[10],inst_in[9],inst_in[3:0]}),
    .i5(),
    .i6(),
    .i7(),
    .sel(c_ram_addr_sel),
    //Outputs
    .out(mem_mux_out));
  
    assign rampz = io_reg_file_rampz;
    assign imm_out = imm_prep0_imm;
    assign rd_out = rf_rd_out;
    assign rr_out = rf_rr_out;
    assign sreg_out = io_reg_file_sreg;
    assign Z = rf_Z;
    assign temp = temp_q;
    assign dbusin_int = io_reg_file_dbusin_int;
    assign ram_addr = mem_mux_out;
    assign mem_to_reg_out = mem_to_reg_result;

    endmodule
