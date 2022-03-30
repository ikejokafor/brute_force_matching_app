`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Copyright 2016 SiliconScapes, LLC. All Rights Reserved.			
//				
// Engineer:		
//
// Create Date:		
// Design Name:		
// Module Name:		
// Project Name:	
// Target Devices:  
// Tool versions:
// Description:		
//
// Dependencies:
//	 
// 	 
//
// Revision:
//
//
//
//
// Additional Comments:
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//-----------------------------------------------------------------------------------------------------------------------------------------------
// Includes
//-----------------------------------------------------------------------------------------------------------------------------------------------
`include "soc_it_master_request_ports.sv"
`include "soc_it_master_descriptor_ports.sv"
`include "soc_it_master_data_ports.sv"
`include "soc_it_slave_ports.sv"
`include "soc_it_message_send_ports.sv"
`include "soc_it_message_recv_ports.sv"
`include "soc_it_driver.sv"


program soc_it_bfm_program (
	soc_it_master_request_ports		master_request_ports		,
	soc_it_master_descriptor_ports	master_descriptor_ports		,
	soc_it_master_data_ports		master_data_ports			,
	soc_it_slave_ports				slave_ports					,
	soc_it_message_send_ports		message_send_ports			,
	soc_it_message_recv_ports		message_recv_ports			
);

	//-----------------------------------------------------------------------------------------------------------------------------------------------
	// Variables
	//-----------------------------------------------------------------------------------------------------------------------------------------------
	soc_it_driver driver;
	
	
	
	// BEGIN Program --------------------------------------------------------------------------------------------------------------------------------
	initial begin
		driver = new 	(	
							master_request_ports		,
							master_descriptor_ports		,
							master_data_ports			,
							slave_ports					,
							message_send_ports			,
							message_recv_ports			
						);


		driver.initMemory();
		fork
			driver.do_service();
		join		
	end
	// END Program ----------------------------------------------------------------------------------------------------------------------------------

endprogram

