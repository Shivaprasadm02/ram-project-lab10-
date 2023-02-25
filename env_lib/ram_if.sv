/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename		:	ram_if.sv   

Description		:	Interface for dual port ram_testbench

Author Name		:	Putta Satish

Support e-mail  : 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version			:	1.0

*********************************************************************************************/
// Definition of an interface block ram_if with clock as an input
interface ram_if(input bit clock);
   
	logic [63:0] data_in;
	logic [63:0] data_out;
	logic [11:0] rd_address;
	logic [11:0] wr_address;
	logic        read;
	logic        write;

	//Write bfm clocking block
	clocking wr_drv_cb@(posedge clock);
		default input #1 output #1;
		output wr_address;
		output data_in;
		output write;
	endclocking: wr_drv_cb
 
	//Read BFM clocking block
	clocking rd_drv_cb@(posedge clock);
		default input #1 output #1;
		output read;
		output rd_address;
	endclocking: rd_drv_cb

	//read minitor clocking block
	clocking rd_mon_cb@(posedge clock);
		default input #1 output #1;
		input read;
		input rd_address;
		input data_out;
	endclocking: rd_mon_cb

	//write monitor clocking block
	clocking wr_mon_cb@(posedge clock);
		default input #1 output #1;
		input write;
		input wr_address;
		input data_in;
	endclocking: wr_mon_cb

	//Write BFM modport
	modport WR_BFM (clocking wr_drv_cb);

	//Read BFM modport
	modport RD_BFM (clocking rd_drv_cb);

	//Write monitor modport
	modport WR_MON (clocking wr_mon_cb);

	//Read Monitor modport
	modport RD_MON (clocking rd_mon_cb);
    

endinterface: ram_if

