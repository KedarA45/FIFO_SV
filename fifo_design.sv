//==============================================================================
// Module: FIFO (First-In First-Out Queue)
// Author: Kedar Adake
// Description:
//   • Simple synchronous FIFO with separate read/write pointers
//   • Supports 8-bit data, depth = 32
//   • Full/Empty flag generation using pointer wrap-around method
//   • Fully synchronous reset
//==============================================================================

module fifo(
    input         clk,        // System clock
    input         rst,        // Active-low synchronous reset
    input  [7:0]  data_in,    // Data to be written into FIFO
    input         w_en,       // Write enable
    input         r_en,       // Read enable
    output reg [7:0] data_out, // FIFO read data
    output        full,       // FIFO full indicator
    output        empty       // FIFO empty indicator
);

    //==========================================================================
    // Internal Signals
    //==========================================================================

    // 6-bit write/read pointers:
    //   • Lower 5 bits index memory (32 locations)
    //   • MSB differentiates wrapped vs non-wrapped pointers for full detection
    reg [5:0] w_ptr;   // Write pointer
    reg [5:0] r_ptr;   // Read pointer

    // FIFO memory: 32 entries × 8 bits
    reg [7:0] fifo [31:0];

    //==========================================================================
    // Write Logic
    //==========================================================================
    always @(posedge clk) begin
        if (!rst) begin
            // Active-low reset: Reset write pointer
            w_ptr <= 0;
        end 
        else begin
            // Write only when FIFO is not full
            if (w_en && !full) begin
                fifo[w_ptr[4:0]] <= data_in; // Write into memory
                w_ptr <= w_ptr + 1;          // Increment pointer (wraps naturally)
            end
        end
    end

    //==========================================================================
    // Read Logic
    //==========================================================================
    always @(posedge clk) begin
        if (!rst) begin
            // Reset read pointer and output
            r_ptr    <= 0;
            data_out <= 0;
        end 
        else begin
            // Read only when FIFO is not empty
            if (r_en && !empty) begin
                data_out <= fifo[r_ptr[4:0]]; // Read memory location
                r_ptr    <= r_ptr + 1;        // Increment pointer
            end
        end
    end

    //==========================================================================
    // Full & Empty Flag Generation
    //==========================================================================

    // EMPTY condition:
    //   • FIFO is empty when write and read pointers are exactly equal
    assign empty = (w_ptr == r_ptr);

    // FULL condition:
    //   • FIFO is full when:
    //       MSB of write pointer != MSB of read pointer
    //       AND lower 5 bits are equal
    //   • This indicates write pointer has wrapped around once more than read
    assign full = ({~w_ptr[5], w_ptr[4:0]} == r_ptr);

endmodule
