// Mappings: 
// c_branch_mode:1 -- nz=1,z=0
// c_rh_op:2 -- dec=10,nop=00,inc=01
// c_ram_adr_sel:3 -- rh_q=11,rh=01,sp=10,inst7=????,inst=00
// c_new_sreg_sel:1 -- sreg=01,alu=00
// c_imm_type:3 -- mask_6_4=100,six=001,ff=101,eight=010,imm_q=110,mask_2_0=011,zero=000
// c_pc_next:3 -- pc_imm12=????,pc_z=101,pc_offset=001,branch=010,skip=110,return=????,next=000,inst=011
// c_skip:1 -- 
// c_dbus_out_sel:2 -- pc_low=00,pc_high=01,ex_out=10
// c_pc_offset_mode:1 -- branch=????,ld_addr_comp=????
// c_rampz_inc:1 -- 
// c_ex_out_sel:1 -- alu=1,inst=0
// c_sp_op:2 -- dec=01,nop=00,inc=10
// c_mem_out_sel:2 -- dbus=00,mem=????,ex_out=01
// c_dbus_addr_sel:2 -- imm_6=00,ram=10,imm_5=01
// c_imem_addr_sel:2 -- ez=????,z=????,pc=????
// c_rd_rr_sel:2 -- adiw=00,4bit=10,5bit=01,r0=????
// c_adiw_phase:1 -- 
// c_io_op:2 -- write=01,nop=00,read=10
// c_rd_w_en:1 -- 
// c_alu_b_sel:1 -- rf=0,imm=1
// c_rh_sel:2 -- rh_x=00,rh_y=01,rh_z=10
// c_next_state:2 -- 
// c_pc_stall:1 -- 
// c_flags_mask:8 -- 
// c_ram_op:2 -- write=01,nop=00,read=10
// c_alu_a_sel:2 -- rf=00,sreg=01,temp=10,zero=11
// c_alu_op:4 -- adc=0001,ror=1010,neg=1100,add=0000,sub=0010,bld=1011,xor=0111,swap=1101,lsr=1001,sbc=0011,asr=1000,or=0110,andn=0101,and=0100
module control(inst,state,c_branch_mode,c_rh_op,c_ram_adr_sel,c_new_sreg_sel,c_imm_type,c_pc_next,c_skip,c_dbus_out_sel,c_pc_offset_mode,c_rampz_inc,c_ex_out_sel,c_sp_op,c_mem_out_sel,c_dbus_addr_sel,c_imem_addr_sel,c_rd_rr_sel,c_adiw_phase,c_io_op,c_rd_w_en,c_alu_b_sel,c_rh_sel,c_next_state,c_pc_stall,c_flags_mask,c_ram_op,c_alu_a_sel,c_alu_op);
input [15:0] inst;
input [1:0] state;
output reg       c_branch_mode;
output reg [1:0] c_rh_op;
output reg [2:0] c_ram_adr_sel;
output reg       c_new_sreg_sel;
output reg [2:0] c_imm_type;
output reg [2:0] c_pc_next;
output reg       c_skip;
output reg [1:0] c_dbus_out_sel;
output reg       c_pc_offset_mode;
output reg       c_rampz_inc;
output reg       c_ex_out_sel;
output reg [1:0] c_sp_op;
output reg [1:0] c_mem_out_sel;
output reg [1:0] c_dbus_addr_sel;
output reg [1:0] c_imem_addr_sel;
output reg [1:0] c_rd_rr_sel;
output reg       c_adiw_phase;
output reg [1:0] c_io_op;
output reg       c_rd_w_en;
output reg       c_alu_b_sel;
output reg [1:0] c_rh_sel;
output reg [1:0] c_next_state;
output reg       c_pc_stall;
output reg [7:0] c_flags_mask;
output reg [1:0] c_ram_op;
output reg [1:0] c_alu_a_sel;
output reg [3:0] c_alu_op;
always @(*)
begin
case(op)
//ADIW
18'b10010110????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b001;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b00;
 c_adiw_phase = 1'b0;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00011111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0000;
end

//
18'b10010110????????_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b00;
 c_adiw_phase = 1'b1;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00011111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0001;
end

//SBIW
18'b10010111????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b001;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b00;
 c_adiw_phase = 1'b0;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00011111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0010;
end

//
18'b10010111????????_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b00;
 c_adiw_phase = 1'b1;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00011111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0011;
end

//ADC
18'b000111??????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b0;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00101111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0001;
end

//ADD
18'b000011??????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b0;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00101111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0000;
end

//SBC
18'b000010??????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b0;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00111111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0010;
end

//SBCI
18'b0100????????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b010;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b10;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00111111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0010;
end

//AND
18'b001000??????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b0;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00001110;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0100;
end

//EOR
18'b001001??????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b0;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00011110;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0111;
end

//OR
18'b001010??????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b0;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00011110;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//MOV
18'b001011??????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b0;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00011110;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b11;
 c_alu_op = 4'b0110;
end

//ANDI
18'b0111????????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b010;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b10;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00001110;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0100;
end

//ORI
18'b0110????????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b010;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b10;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00011110;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//ASR
18'b1001010?????0101_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00001111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b1000;
end

//LSR
18'b1001010?????0110_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00011111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b1001;
end

//ROR
18'b1001010?????0111_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00011111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b1010;
end

//NEG
18'b1001010?????0001_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00111111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b1100;
end

//BCLR
18'b100101001???1000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b00;
 c_imm_type = 3'b100;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'bxxxxxxxx;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b01;
 c_alu_op = 4'b0101;
end

//BSET
18'b100101000???1000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b00;
 c_imm_type = 3'b100;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'bxxxxxxxx;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b01;
 c_alu_op = 4'b0110;
end

//BLD
18'b1111100?????0???_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b011;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b1011;
end

//BST
18'b1111101?????0???_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b011;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b01000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0100;
end

//COM
18'b1001010?????0000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b101;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00011111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0111;
end

//DEC
18'b1001010?????1010_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b101;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00011110;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0000;
end

//INC
18'b1001010?????0011_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b101;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00011110;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0010;
end

//ELPM0
18'b1001010111011000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b1001010111011000_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b0;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b????;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//ELPMdZ
18'b1001000?????0110_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b1001000?????0110_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b0;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//ELPMdZ+
18'b1001000?????0111_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b1001000?????0111_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b0;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'b10;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LPM0Z
18'b1001010111001000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b1001010111001000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b0;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b????;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LPMdZ
18'b1001000?????0100_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b1001000?????0100_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b0;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LPMdZ+
18'b1001000?????0101_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b1001000?????0101_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b1;
 c_ex_out_sel = 1'b0;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'b10;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//CP
18'b000101??????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b0;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00111111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0010;
end

//CPC
18'b000001??????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b0;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00111111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0011;
end

//CPI
18'b0011????????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b010;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b10;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00111111;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0010;
end

//BRBC
18'b111101??????????_00:
begin
 c_branch_mode = 1'b1;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b011;
 c_pc_next = 3'b010;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'b????;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b01;
 c_alu_op = 4'b0100;
end

//BRBS
18'b111100??????????_00:
begin
 c_branch_mode = 1'b0;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b011;
 c_pc_next = 3'b010;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'b????;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b01;
 c_alu_op = 4'b0100;
end

//JMP
18'b1001010?????110?_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b1001010?????110?_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b011;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//IJMP
18'b1001010000001001_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b101;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'bx;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//RJMP
18'b1100????????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b001;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//CALL
18'b1001010?????111?_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'bx;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b1001010?????111?_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b10;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b00;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b01;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'bx;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b10;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b1001010?????111?_10:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b10;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b011;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b01;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b01;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'bx;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'bx;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//ICALL
18'b1001010100001001_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b10;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b00;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b01;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'bx;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b1001010100001001_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b10;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b101;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b01;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b01;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'bx;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'bx;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//RCALL
18'b1101????????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b10;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b00;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b01;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'bx;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b1101????????????_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b10;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b????;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b01;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b01;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'bx;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'bx;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//RET
18'b1001010100001000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b10;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b10;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b1001010100001000_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b10;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b????;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b10;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//RETI
18'b1001010100011000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'bxx;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'bx;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'bx;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'bxx;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'bxx;
 c_rd_w_en = 1'bx;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'bxxxxxxxx;
 c_ram_op = 2'bxx;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//POP
18'b1001000?????1111_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b10;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b10;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//PUSH
18'b1001001?????1111_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b10;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b01;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//STX
18'b1001001?????1100_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'b00;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//STX+
18'b1001001?????1101_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b01;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'b00;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//ST-X
18'b1001001?????1110_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b10;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'b00;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//STY
18'b1000001?????1000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'b01;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//STY+
18'b1001001?????1001_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b01;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'b01;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//ST-Y
18'b1001001?????1010_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b10;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'b01;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//STY+q
18'b10?0??1?????1???_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b11;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b110;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'b01;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//STZ
18'b1000001?????0000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'b10;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//STZ+
18'b1001001?????0001_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b01;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'b10;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//ST-Z
18'b1001001?????0010_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b10;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'b10;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//STZ+q
18'b10?0??1?????0???_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b11;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b110;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'b10;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//STS (32)
18'b1001001?????0000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b1001001?????0000_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b00;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//STS (16)
18'b10101???????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b????;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b10;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b01;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//LDX
18'b1001000?????1100_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'b00;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LDX+
18'b1001000?????1101_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b01;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'b00;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LD-X
18'b1001000?????1110_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b10;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'b00;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LDY
18'b1000000?????1000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'b01;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LDY+
18'b1001000?????1001_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b01;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'b01;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LD-Y
18'b1001000?????1010_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b10;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'b01;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LDY+q
18'b10?0??0?????1???_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b11;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'b01;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LDZ
18'b1000000?????0000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'b10;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LDZ+
18'b1001000?????0001_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b01;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'b10;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LD-Z
18'b1001000?????0010_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b10;
 c_ram_adr_sel = 3'b01;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'b10;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LDZ+q
18'b10?0??0?????0???_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b11;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'b10;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LDS (32)
18'b1001000?????0000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b1001000?????0000_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b00;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LDS (16)
18'b10100???????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'b????;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'b????;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b????;
 c_dbus_addr_sel = 2'b10;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b10;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b10;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//LDI
18'b1110????????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b01;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b10;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b11;
 c_alu_op = 4'b0110;
end

//IN
18'b10110???????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b00;
 c_dbus_addr_sel = 2'b00;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b10;
 c_rd_w_en = 1'b1;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//OUT
18'b10111???????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b000;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b00;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b01;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0110;
end

//SBI
18'b10011010????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b00;
 c_dbus_addr_sel = 2'b01;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b10;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b10011010????????_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b011;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b01;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b01;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b10;
 c_alu_op = 4'b0110;
end

//CBI
18'b10011000????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b00;
 c_dbus_addr_sel = 2'b01;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b10;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b10011000????????_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b011;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'b10;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'b1;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'b01;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b01;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b10;
 c_alu_op = 4'b0100;
end

//SBIC
18'b10011001????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b00;
 c_dbus_addr_sel = 2'b01;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b10;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b10011001????????_01:
begin
 c_branch_mode = 1'b0;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b011;
 c_pc_next = 3'b000;
 c_skip = 1'b1;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b10;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b10;
 c_alu_op = 4'b0100;
end

//
18'b10011001????????_10:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b110;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//SBIS
18'b10011011????????_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'b00;
 c_dbus_addr_sel = 2'b01;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b10;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b01;
 c_pc_stall = 1'b1;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//
18'b10011011????????_01:
begin
 c_branch_mode = 1'b1;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b011;
 c_pc_next = 3'b000;
 c_skip = 1'b1;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b10;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b10;
 c_alu_op = 4'b0100;
end

//
18'b10011011????????_10:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b110;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//SBRC
18'b1111110?????0???_00:
begin
 c_branch_mode = 1'b0;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b011;
 c_pc_next = 3'b000;
 c_skip = 1'b1;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0100;
end

//
18'b1111110?????0???_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b110;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//SBRS
18'b1111111?????0???_00:
begin
 c_branch_mode = 1'b1;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'b011;
 c_pc_next = 3'b000;
 c_skip = 1'b1;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b1;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0100;
end

//
18'b1111111?????0???_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b110;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//CPSE
18'b000100??????????_00:
begin
 c_branch_mode = 1'b0;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b1;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'b01;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'b0;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'b00;
 c_alu_op = 4'b0010;
end

//
18'b000100??????????_01:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b110;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

//NOP
18'b0000000000000000_00:
begin
 c_branch_mode = 1'bx;
 c_rh_op = 2'b00;
 c_ram_adr_sel = 3'bxxx;
 c_new_sreg_sel = 1'b01;
 c_imm_type = 3'bxxx;
 c_pc_next = 3'b000;
 c_skip = 1'b0;
 c_dbus_out_sel = 2'bxx;
 c_pc_offset_mode = 1'bx;
 c_rampz_inc = 1'b0;
 c_ex_out_sel = 1'bx;
 c_sp_op = 2'b00;
 c_mem_out_sel = 2'bxx;
 c_dbus_addr_sel = 2'bxx;
 c_imem_addr_sel = 2'b????;
 c_rd_rr_sel = 2'bxx;
 c_adiw_phase = 1'bx;
 c_io_op = 2'b00;
 c_rd_w_en = 1'b0;
 c_alu_b_sel = 1'bx;
 c_rh_sel = 2'bxx;
 c_next_state = 2'b00;
 c_pc_stall = 1'b0;
 c_flags_mask = 8'b00000000;
 c_ram_op = 2'b00;
 c_alu_a_sel = 2'bxx;
 c_alu_op = 4'bxxxx;
end

endcase
end
endmodule

