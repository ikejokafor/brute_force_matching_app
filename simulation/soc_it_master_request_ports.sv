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

`ifndef	__SOC_IT_MASTER_REQUEST_PORTS__
`define	__SOC_IT_MASTER_REQUEST_PORTS__

interface soc_it_master_request_ports (
	input	logic						clk								,
	input	logic						rst								,
	input	logic 						master_request					,
	output	logic						master_request_ack				,
	output	logic						master_request_complete			,
	output	logic	[6	:0]				master_request_error			,
	output	logic	[3  :0]				master_request_tag				,
	input	logic	[3  :0]				master_request_type				,
	input	logic	[9  :0]				master_request_flow				,
	input	logic	[63 :0]				master_request_local_address	,
	input	logic	[35 :0]             master_request_length			
);

	clocking cb @(posedge clk);
		input	master_request					;
		output	master_request_ack				;
		output	master_request_complete			;
		output	master_request_error			;
		output	master_request_tag				;
		input	master_request_type				;
		input	master_request_flow				;
		input	master_request_local_address	;
		input	master_request_length			;
	endclocking

endinterface: soc_it_master_request_ports

`endif
