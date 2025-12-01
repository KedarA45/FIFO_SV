module fifo(clk,rst,data_in,w_en,r_en,data_out,full,empty);
  //signals declaration
  input          clk,rst;
  input    [7:0] data_in;
  input          w_en,r_en;
  output reg[7:0]data_out;
  output        full,empty;
  
  //internal signals
  reg [5:0]w_ptr,r_ptr;
  
  //memory
  reg [7:0]fifo[31:0];
  
  always @(posedge clk) begin
    if(!rst)
         //rst condition
      w_ptr<=0;
    else begin
      if(w_en&&!full) begin //logic for writing  in the memory when it's not full
        fifo[w_ptr[4:0]] <= data_in;
        w_ptr = w_ptr + 1;
      end
    end
  end
  
  //read operation
  always @(posedge clk) begin
      if(!rst) begin
          //rst condition
      r_ptr<=0;
      data_out <=0;
  end
    else begin
      if(r_en&&!empty) begin //logic for reading from the memory when it's not empty

        data_out <= fifo[r_ptr[4:0]];
        r_ptr <= r_ptr + 1;
      end
    end
  end
  
  //flags condition
  assign full ={~w_ptr[5],w_ptr[4:0]}==r_ptr;//assigning full pointer when MSB of w_ptr becomes 1
    assign empty = w_ptr == r_ptr;//when r_ptr becomes equal to the w_ptr then empty flag will eb high
endmodule
