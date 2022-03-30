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

`ifndef	__SOC_IT_MASTER_DESCRIPTOR_PORTS__
`define	__SOC_IT_MASTER_DESCRIPTOR_PORTS__

interface soc_it_master_descriptor_ports (
	input	logic					clk								,
	input	logic					rst								,
	input	logic					master_descriptor_src_rdy		,
	output	logic					master_descriptor_dst_rdy		,
	output	logic	[3  :0]			master_descriptor_tag			,
	input	logic	[127:0]			master_descriptor				
);

	clocking cb @(posedge clk);
		input	master_descriptor_src_rdy			;
		output	master_descriptor_dst_rdy			;
		output	master_descriptor_tag				;
		input	master_descriptor					;
	endclocking

endinterface: soc_it_master_descriptor_ports

`endif
