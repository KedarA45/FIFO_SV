class fifo_environment;
  fifo_agent agt;
  fifo_scoreboard sb;
  mailbox gen2dri, mon2sb,gen2sb;
  int num_test;
  fifo_functional_cov cov;
  
  function new(virtual fifo_interface vif,int num_test);
    $display("[ENVIRONMENT]");
    gen2dri = new();
    gen2sb = new();
    mon2sb = new();
    cov=new();
    agt = new(gen2dri,gen2sb,mon2sb,vif,num_test,cov);
    sb=new(gen2sb,mon2sb,num_test);
  endfunction
  
  task run();
    fork
      agt.run();
      sb.run();
    join
    
  endtask
  function void report();
        $display("[ENV] Generating final reports...");
       sb.report();
        cov.report(); 
    endfunction
endclass