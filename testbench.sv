// Code your testbench here
// or browse Examples
`include "fifo_pkg.sv"
module tb_top;
  import fifo_pkg::*;
  fifo_test t;
  bit clk;
  reg rst=0;
  fifo_interface inf(clk,rst);
  
  fifo dut(.clk(clk),
           .rst(rst),
           .data_in(inf.data_in),
           .w_en(inf.w_en),
           .r_en(inf.r_en),
           .data_out(inf.data_out),
           .full(inf.full),
           .empty(inf.empty));
  
  initial clk = 0;
  always #5 clk = ~clk;
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars;
    rst=0;
    @(posedge clk);
    rst<=1;
    t= new(inf);
    t.run();
    #1000;
    $finish;
  
  end
endmodule
