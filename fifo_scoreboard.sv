class fifo_scoreboard;
  mailbox gen2sb,mon2sb;
  int received_count=0;
  int max_transaction;
  int pass_count=0,fail_count=0;
  logic [7:0] q [$];
  
  
  function new(mailbox gen2sb,mon2sb,int num_test);
    $display("[SCOREBOARD]");
    this.gen2sb=gen2sb;
    this.mon2sb=mon2sb;
    this.max_transaction=num_test;
  endfunction
  
  task run();
    fifo_transaction tr1,tr2;
    while(received_count<max_transaction) begin
    $display("In sb before get");
    
    gen2sb.get(tr1);
    $display("[SCOREBOARD] DATA_IN = %0h W_EN = %0h R_EN = %0h RST = %0h ",tr1.data_in,tr1.w_en,tr1.r_en,tr1.rst);
    $display("In sb before mn2sb");
      if(tr1.w_en) q.push_back(tr1.data_in);

    mon2sb.get(tr2);
$display("%p",q);
    $display("[SCOREBOARD] DATA_OUT = %0h FULL = %0h EMPTY = %0h ",tr2.data_out,tr2.full,tr2.empty);

    $display("In sb after get");
      
      received_count++;
      

      if(q.pop_front==tr2.data_out) begin
        $display("**********************[PASSED]****************************");
        pass_count++;
      end
    else begin 
      $display("**********************[FAILED]****************************");
      fail_count++;
    end
    end
    $display("PASS COUNT=%0d",pass_count);
    $display("FAIL COUNT=%0d",fail_count);
    
  endtask
  
  function void report();
     $display("\n================= SCOREBOARD REPORT =================");
    $display("PASS COUNT=%0d",pass_count);
    $display("FAIL COUNT=%0d",fail_count);
    $display("Pass Percentage   : %0.2f%%", (pass_count * 100.0) / (pass_count + fail_count));
  endfunction
endclass
