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

`ifndef	__SOC_IT_MESSAGE_SEND_PORTS__
`define	__SOC_IT_MESSAGE_SEND_PORTS__

interface soc_it_message_send_ports (
	input	logic						clk							,
	input	logic						rst							,
	input	logic						send_msg_request			,
	output	logic						send_msg_ack				,
	output	logic						send_msg_complete			,
	output	logic	[1  :0]				send_msg_error				,
	input	logic						send_msg_src_rdy			,
	output	logic						send_msg_dst_rdy			,
	input	logic	[127:0]				send_msg_payload			
);

	clocking cb @(posedge clk);
		input	rst							;
		input	send_msg_request			;
		output	send_msg_ack				;
		output	send_msg_complete			;
		output	send_msg_error				;
		input	send_msg_src_rdy			;
		output	send_msg_dst_rdy			;
		input	send_msg_payload			;
	endclocking

endinterface: soc_it_message_send_ports

`endif
