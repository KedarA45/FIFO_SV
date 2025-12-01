class fifo_driver;
  mailbox gen2dri;
  virtual fifo_interface vif;
  
  function new(mailbox gen2dri,virtual fifo_interface vif);
    $display("[DRIVER]");
    this.vif=vif;
    this.gen2dri=gen2dri;
  endfunction
  
  task run();
    fifo_transaction tr;
    forever begin
    gen2dri.get(tr);
      @(posedge vif.clk);
      @(posedge vif.clk);
    $display($time,"[DRIVER] DATA_IN = %0h W_EN = %0h R_EN = %0h RST = %0h ",tr.data_in,tr.w_en,tr.r_en,tr.rst);
    //vif.rst<=tr.rst;
    vif.data_in<=tr.data_in;
    vif.w_en<=tr.w_en;
    vif.r_en<=tr.r_en;
     end
    
  endtask
endclass
