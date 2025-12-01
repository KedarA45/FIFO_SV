class fifo_transaction;
  rand logic [7:0]data_in;
  rand logic w_en,r_en,rst;
  logic [7:0]data_out;
  logic full,empty;
  
  constraint data{data_in inside {[1:1000]};}
  constraint read{r_en ==1;}
  constraint write{w_en ==1;}
endclass
