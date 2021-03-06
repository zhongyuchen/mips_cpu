`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/05 21:21:56
// Design Name: 
// Module Name: Ram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Ram(
      input clk,   //存储器时钟信号
      input ena,   //存储器有效信号，高电平时存储器才运行，否则输出 z 
      input [31:0] addr,//输入地址，指定数据读写的地址 
      input [2:0] switch,
      input [31:0] data_in, 
      input we,
      output [31:0]data_out //存储器读出的数据，
);

    reg [31:0] ram [1023:0];
    
    assign data_out = ena?((switch==3'b100)?{24'b0,ram[addr][7:0]}:
                          (switch==3'b010)?{16'b0,ram[addr][15:0]}:
                          (switch==3'b001)?{ram[addr]}:32'bz):32'bz;
                          
    always@(posedge clk)
        if(ena) begin
            if(we) begin
                if(switch==3'b100)
                    ram[addr][7:0] = data_in[7:0];
                else if(switch==3'b010)
                    ram[addr][15:0] = data_in[15:0];
                else if(switch==3'b001)
                    ram[addr] = data_in;
            end
        end
endmodule
