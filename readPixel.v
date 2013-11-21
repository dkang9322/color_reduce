module readPix(reset, clk,
	       hcount, vcount, // Used for write_addr1
	       two_pixel_data, // Data output
	       vram_read_data, // Physical data from ZBT bank 0
	       write_addr1
	       );
   input reset, clk;
   input [10:0] hcount;
   input [9:0] 	vcount;
   output [35:0] two_pixel_data;
   output [18:0] write_addr1; // done
   input [35:0]  vram_read_data;

   // Address to read from ZBT bank 0
   wire [18:0] 	 vram_addr;
   
   // Same code from vram_display
   //forecast hcount & vcount 8 clock cycles ahead to get data from ZBT
   wire [10:0] hcount_f = (hcount >= 1048) ? (hcount - 1048) : (hcount + 8);
   wire [9:0] vcount_f = (hcount >= 1048) ? ((vcount == 805) ? 0 : vcount + 1) : vcount;

   // Change of address scheme to compensate for reading color
   assign vram_addr = {vcount_f, hcount_f[9:1]};

   /* No Compensation Needed, as we are writing to ZBT bank 1
      Just need to make sure to delay the addresses and write enable
      appropriately*/
   /*
   // Address to write is a two_cycle delayed version of vram_addr,
   // compensates for ZBT 2 clock cycle read delay
   always @(posedge clk)
     begin
	delayed_one <= vram_addr;
	write_addr1 <= delayed_one;
     end
    */
   
   // Address to write to ZBT bank 1 is the same address
   wire [18:0] write_addr1 = vram_addr;
   wire [35:0] two_pixel_data = vram_read_data;

endmodule // readPix

