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

`ifndef	__SOC_IT_SLAVE_PORTS__
`define	__SOC_IT_SLAVE_PORTS__

interface soc_it_slave_ports (
	input	logic					clk								,
	input	logic					rst								,
	output	logic	[63 :0] 		slave_address					,
	output	logic	[3  :0]			slave_transaction_id			,
	output	logic					slave_address_valid				,
	input	logic					slave_address_ack				,
	output	logic	[3  :0]			slave_wrreq						,
	input	logic					slave_wrack						,
	output	logic	[15 :0] 		slave_be						,
	output	logic	[127:0]			slave_datain					,
	output	logic	[3  :0] 		slave_rdreq						,
	input	logic        			slave_rdack						,
	input	logic 	[127:0]			slave_dataout					
);

	clocking cb @(posedge clk);
		input	rst								;
		output	slave_address					;
		output	slave_transaction_id			;
		output	slave_address_valid				;
		input	slave_address_ack				;
		output	slave_wrreq						;
		input	slave_wrack						;
		output	slave_be						;
		output	slave_datain					;
		output	slave_rdreq						;
		input	slave_rdack						;
		input	slave_dataout					;
	endclocking

endinterface

`endif
