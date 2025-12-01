interface fifo_interface(clk,rst);
  input clk,rst;
  logic [7:0]data_in;
  logic w_en,r_en;
  logic [7:0]data_out;
  logic full,empty;
endinterface