class fifo_functional_cov;
  bit [7:0] cov_data_in;
  bit cov_w_en ,cov_r_en;
  
  covergroup fifo_cov;
    coverpoint cov_data_in{bins data_in_b = {[0:$]};}
    coverpoint cov_w_en{bins w_en_b = {[0:$]};}
    coverpoint cov_r_en{bins r_en_b = {[0:$]};}
    cross cov_data_in,cov_w_en,cov_r_en;
  endgroup
  
  function new();
        $display("[INFO] Initializing Coverage...");
        fifo_cov = new();  
  endfunction
  
  function void sample(logic [7:0]data_in,logic w_en,logic r_en);
    if (fifo_cov == null) begin
          $fatal(1, "[ERROR] Covergroup not initialized! Check object creation.");
        end
        cov_data_in = data_in;
        cov_w_en = w_en;
        cov_r_en = r_en;
        fifo_cov.sample();  
    $display("[COVERAGE] Sampled: DATA_IN=%0d, W_EN=%b, R_EN=%b", data_in, w_en, r_en);    
  endfunction
      function void report();
        $display("******************[COVERAGE] Functional Coverage Report: %0.2f%%******************", 		        fifo_cov.get_coverage());
    endfunction
endclass
