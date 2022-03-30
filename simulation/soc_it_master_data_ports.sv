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

`ifndef	__SOC_IT_MASTER_DATA_PORTS__
`define	__SOC_IT_MASTER_DATA_PORTS__

interface soc_it_master_data_ports (
	input	logic					clk								,
	input	logic					rst								,
	output	logic					master_datain_src_rdy			,
	input	logic					master_datain_dst_rdy			,
	output	logic	[3  :0]			master_datain_tag				,
	output	logic	[127:0]			master_datain					,
	input	logic					master_dataout_src_rdy			,
	output	logic					master_dataout_dst_rdy			,
	output	logic	[3  :0]			master_dataout_tag				,
	input	logic	[127:0]			master_dataout					
);

	clocking cb @(posedge clk);
		output	master_datain_src_rdy			;
		input	master_datain_dst_rdy			;
		output	master_datain_tag				;
		output	master_datain					;
		input	master_dataout_src_rdy			;
		output	master_dataout_dst_rdy			;
		output	master_dataout_tag				;
		input	master_dataout					;
	endclocking

endinterface: soc_it_master_data_ports

`endif
