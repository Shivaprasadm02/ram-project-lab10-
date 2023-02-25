/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename		:	top.sv   

Description		:	Top for dual port ram_testbench

Author Name		:	Putta Satish

Support e-mail  : 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

*********************************************************************************************/
  // Include the test.sv 
`include "test.sv"
module top();
  
	parameter cycle = 10;
  
	reg clock;

	//Instantiate the interface
	ram_if DUV_IF(clock);

	//Declare an handle for the test as test_h
	test test_h;
   
	//instantiate the DUV

   ram_4096 RAM (.clk        (clock),
				.data_in    (DUV_IF.data_in),
				.data_out   (DUV_IF.data_out),
				.wr_address (DUV_IF.wr_address),
				.rd_address (DUV_IF.rd_address),
				.read       (DUV_IF.read),
				.write      (DUV_IF.write)
				); 

	initial
		begin
  //Create the object for test and pass the interface instances as arguments
			test_h = new(DUV_IF,DUV_IF, DUV_IF, DUV_IF);
  //Call the task build_and_run
			test_h.build_and_run();
		end

	//Generate the clock
	initial
			begin
				clock=1'b0;
				forever #(cycle/2) clock=~clock;
			end

 endmodule
