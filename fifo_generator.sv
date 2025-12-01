class fifo_generator;
    mailbox gen2dri,gen2sb;
  
  function new(mailbox gen2dri,gen2sb);
    $display("[GENERATOR]");
    this.gen2dri=gen2dri;
    this.gen2sb=gen2sb;
  endfunction
  
  task run(int num_test);
 fifo_transaction tr;
   
    $display("Starting gen",num_test);
    for(int i=0; i<num_test;i++) begin
      //#10;
    tr=new;

    $display("Starting randomization");
    void'(tr.randomize());
    $display("Randomization done");
    gen2dri.put(tr);
    gen2sb.put(tr);
    $display("[GENERATOR] DATA_IN = %0h W_EN = %0h R_EN = %0h RST = %0h ",tr.data_in,tr.w_en,tr.r_en,tr.rst);
    end
  endtask
endclass
