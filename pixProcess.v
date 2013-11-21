module pixProc(reset, clk,
	       hcount, vcount, // Not used in processing for now
	       two_pixel_vals, // Data Input to be processed
	       write_addr, //Data Address to write in ZBT bank 1
	       two_proc_pixs, // Processed Pixel
	       proc_pix_addr
	       );
   input reset, clk;
   input [10:0] hcount;
   input [9:0] 	vcount;
   input [35:0] two_pixel_vals;
   input [18:0] write_addr; 
   output [35:0] two_proc_pixs;
   output [18:0] proc_pix_addr;
   

   // Removing THREE LSBs
   parameter MASK = 6'b111000;

   // We want to clock our processing
   reg [35:0] 	 two_proc_pixs;
   reg [18:0] 	 proc_pix_addr;
   
   // Simply RGB Thresholding
   always @(posedge clk)
     begin
	two_proc_pixs <= two_pixel_vals & {MASK, MASK, MASK,MASK, MASK, MASK};
	proc_pix_addr <= write_addr;
     end
   
endmodule // pixProc
