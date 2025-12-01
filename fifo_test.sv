class fifo_test;
  fifo_environment env;
  int num_test;
  function new(virtual fifo_interface vif);
    $display("[TEST]");
    this.num_test=100;
    env= new(vif,num_test);
  endfunction
  
  task run();
    env.run();
    #200;
    env.report();
  endtask
endclass
