class fifo_monitor;
  mailbox mon2sb;
  virtual fifo_interface vif;
  int num_test;
  fifo_functional_cov cov;
  
  function new(virtual fifo_interface vif, mailbox mon2sb,int num_test,fifo_functional_cov cov);
    $display("[MONITOR]");
    this.mon2sb=mon2sb;
    this.vif=vif;
    this.num_test=num_test;
    this.cov=cov;
  endfunction
  
  task run();
    int count=0;
     @(posedge vif.clk);
   // @(posedge vif.clk);
    while (count<num_test) begin
     
    //repeat(2) begin
        fifo_transaction tr=new;
    @(posedge vif.clk);
    //tr.data_in=vif.data_in;
    //tr.w_en=vif.w_en;
    tr.r_en=vif.r_en;
    tr.empty=vif.empty;
    if(vif.r_en && !vif.empty)
    //@(posedge vif.clk);
    begin
    @(posedge vif.clk);
      
    tr.data_out=vif.data_out;
    tr.full=vif.full;
    mon2sb.put(tr);
      cov.sample(tr.data_in,tr.w_en,tr.r_en);
      $display($time,"[MONITOR] DATA_OUT = %0h FULL = %0h EMPTY = %0h ",tr.data_out,tr.full,tr.empty);
      count++;
  end
    end
    //end
  endtask
endclass
