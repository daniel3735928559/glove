    module reg_file(rd_sel,rr_sel,wr_en,rh_sel,rd_in,rh_op,clk,rst,rd_out,rr_out,rh_out,Z);
    input [4:0] rd_sel;
    input [4:0] rr_sel;
    input wr_en;
    input [1:0] rh_sel;
    input [7:0] rd_in;
    input [1:0] rh_op;
    input clk;
    input rst;
    output [7:0] rd_out;
    output [7:0] rr_out;
    output [15:0] rh_out;
    output [15:0] Z;
    
    assign rd_out = ;
    assign rr_out = ;
    assign rh_out = ;
    assign Z = ;

    endmodule
