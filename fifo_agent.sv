class fifo_agent;
  fifo_generator gen;
  fifo_driver dri;
  fifo_monitor mon;
  int num_test;
  
  function new(mailbox gen2dri,gen2sb,mon2sb,virtual fifo_interface vif,int num_test,fifo_functional_cov cov);
    $display("[AGENT]");
    gen=new(gen2dri,gen2sb);
    dri=new(gen2dri,vif);
    mon=new(vif,mon2sb,num_test,cov);
    this.num_test=num_test;
  endfunction
  
  task run();
    fork 
      gen.run(num_test);
      dri.run();
      mon.run();
      $display("RUN in agent");
    join_any
  endtask
endclass
