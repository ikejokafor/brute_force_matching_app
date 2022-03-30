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
module soc_it_bfm_top (
	vendor_id						,
	device_id						,
	class_code						,
	revision_id						,
	
	master_clk						,
	master_rst						,
	master_request					,
	master_request_ack				,
	master_request_complete			,
	master_request_option			,
	master_request_error			,
	master_request_tag				,
	master_request_type				,
	master_request_flow				,
	master_request_local_address	,
	master_request_length			,
	
	master_descriptor_src_rdy		,
	master_descriptor_dst_rdy		,
	master_descriptor_tag			,
	master_descriptor				,
	
	master_datain_src_rdy			,
	master_datain_dst_rdy			,
	master_datain_option			,
	master_datain_tag				,
	master_datain					,
	
	master_dataout_src_rdy			,
	master_dataout_dst_rdy			,
	master_dataout_option			,
	master_dataout_tag				,
	master_dataout					,
	
	slave_clk						,
	slave_rst						,
	slave_burst_start				,
	slave_burst_length				,
	slave_burst_rnw					,
	slave_address					,
	slave_transaction_id			,
	slave_transaction_option		,
	slave_address_valid				,
	slave_address_ack				,
	slave_wrreq						,
	slave_wrack						,
	slave_be						,
	slave_datain					,
	slave_rdreq						,
	slave_rdack						,
	slave_dataout					,
	
	send_msg_request 				,
	send_msg_ack					,
	send_msg_complete				,
	send_msg_error					,
	send_msg_src_rdy 				,
	send_msg_dst_rdy				,
	send_msg_payload 				,
	
	recv_msg_request				,
	recv_msg_ack 					,
	recv_msg_src_rdy				,
	recv_msg_dst_rdy				,
	recv_msg_payload				
	
);

	//-----------------------------------------------------------------------------------------------------------------------------------------------
	// Inputs / Ouputs
	//-----------------------------------------------------------------------------------------------------------------------------------------------
	input		[15:0]		vendor_id							;
	input		[15:0]		device_id							;
	input		[23:0]		class_code							;
	input		[7:0]		revision_id							;

	input					master_clk							;
	input					master_rst							;
	input 					master_request						;
	output					master_request_ack					;
	output					master_request_complete				;
	input		[3	:0]		master_request_option				;	
	output		[6	:0]		master_request_error				;
	output		[3  :0]		master_request_tag					;
	input		[3  :0]		master_request_type					;
	input		[9  :0]		master_request_flow					;
	input		[63 :0]		master_request_local_address		;
	input		[35 :0]		master_request_length				;
	// SAP Master Descriptor Interface 
	input					master_descriptor_src_rdy			;
	output					master_descriptor_dst_rdy			;
	output		[3  :0]		master_descriptor_tag				;
	input		[127:0]		master_descriptor					;
	// SAP Master Data Interface 
	output   	   			master_datain_src_rdy				;
	input					master_datain_dst_rdy				;
	output		[3	:0]		master_datain_option				;
	output		[3  :0]		master_datain_tag					;
	output		[127:0]		master_datain						;
	
	input					master_dataout_src_rdy				;
	output					master_dataout_dst_rdy				;
	output		[3	:0]		master_dataout_option				;
	output		[3  :0]		master_dataout_tag					;
	input		[127:0]		master_dataout						;
	// SAP Slave Interface 
	input					slave_clk							;
	input					slave_rst							;
	output					slave_burst_start					;
	output		[12:0]		slave_burst_length					;
	output					slave_burst_rnw						;
	output 		[63 :0]		slave_address						;
	output		[3  :0]		slave_transaction_id				;
	output		[3  :0]		slave_transaction_option			;
	output					slave_address_valid					;
	input					slave_address_ack					;
	output 		[3  :0]		slave_wrreq							;
	input					slave_wrack							;
	output 		[15 :0] 	slave_be							;
	output 		[127:0]		slave_datain						;
	output 		[3  :0]  	slave_rdreq							;
	input 		      		slave_rdack							;
	input 		[127:0]		slave_dataout						;
	// SAP Message Send Interface (Unused)
	input					send_msg_request 					;
	output					send_msg_ack						;
	output					send_msg_complete					;
	output		[1  :0]		send_msg_error						;
	input					send_msg_src_rdy 					;
	output					send_msg_dst_rdy					;
	input		[127:0]		send_msg_payload 					;
	// SAP Message Recv Interface (Unused)	
	output					recv_msg_request					;
	input					recv_msg_ack 						;
	output					recv_msg_src_rdy					;
	input					recv_msg_dst_rdy					;
	output		[127:0]		recv_msg_payload					;
	
	
	
	//-----------------------------------------------------------------------------------------------------------------------------------------------
	// Module Instantiations
	//-----------------------------------------------------------------------------------------------------------------------------------------------
	soc_it_master_request_ports
	i0_soc_it_master_request_ports (
		.clk							(master_clk						),
		.rst							(master_rst						),
		.master_request					(master_request					),
		.master_request_ack				(master_request_ack				),
		.master_request_complete		(master_request_complete		),
		.master_request_error			(master_request_error			),
		.master_request_tag				(master_request_tag				),
		.master_request_type			(master_request_type			),
		.master_request_flow			(master_request_flow			),
		.master_request_local_address	(master_request_local_address	),
		.master_request_length			(master_request_length			)
	);
	

	soc_it_master_descriptor_ports
	i0_soc_it_master_descriptor_ports (
		.clk							(master_clk						),
		.rst							(master_rst						),
		.master_descriptor_src_rdy		(master_descriptor_src_rdy		),
		.master_descriptor_dst_rdy		(master_descriptor_dst_rdy		),
		.master_descriptor_tag			(master_descriptor_tag			),
		.master_descriptor				(master_descriptor				)
	);

	
	soc_it_master_data_ports
	i0_soc_it_master_data_ports (
		.clk							(master_clk						),
		.rst							(master_rst						),
		.master_datain_src_rdy			(master_datain_src_rdy			),
		.master_datain_dst_rdy			(master_datain_dst_rdy			),
		.master_datain_tag				(master_datain_tag				),
		.master_datain					(master_datain					),
		.master_dataout_src_rdy			(master_dataout_src_rdy			),
		.master_dataout_dst_rdy			(master_dataout_dst_rdy			),
		.master_dataout_tag				(master_dataout_tag				),
		.master_dataout					(master_dataout					)
	);

	
	soc_it_slave_ports
	i0_soc_it_slave_ports (
		.clk							(master_clk						),
		.rst							(master_rst						),
		.slave_address					(slave_address					),
		.slave_transaction_id			(slave_transaction_id			),
		.slave_address_valid			(slave_address_valid			),
		.slave_address_ack				(slave_address_ack				),
		.slave_wrreq					(slave_wrreq					),
		.slave_wrack					(slave_wrack					),
		.slave_be						(slave_be						),
		.slave_datain					(slave_datain					),
		.slave_rdreq					(slave_rdreq					),
		.slave_rdack					(slave_rdack					),
		.slave_dataout					(slave_dataout					)
	);

	
	soc_it_message_send_ports
	i0_soc_it_message_send_ports (
		.clk							(master_clk						),
		.rst							(master_rst						),
		.send_msg_request				(send_msg_request				),
		.send_msg_ack					(send_msg_ack					),
		.send_msg_complete				(send_msg_complete				),
		.send_msg_error					(send_msg_error					),
		.send_msg_src_rdy				(send_msg_src_rdy				),
		.send_msg_dst_rdy				(send_msg_dst_rdy				),
		.send_msg_payload				(send_msg_payload				)
	);

	
	soc_it_message_recv_ports
	i0_soc_it_message_recv_ports (
		.clk							(master_clk						),
		.rst							(master_rst						),
		.recv_msg_request				(recv_msg_request				),
		.recv_msg_ack					(recv_msg_ack					),
		.recv_msg_src_rdy				(recv_msg_src_rdy				),
		.recv_msg_dst_rdy				(recv_msg_dst_rdy				),
		.recv_msg_payload				(recv_msg_payload				)
	);
	
	
	soc_it_bfm_program
	i0_soc_it_bfm_program	(
		.master_request_ports		(i0_soc_it_master_request_ports		),
		.master_descriptor_ports	(i0_soc_it_master_descriptor_ports	),
		.master_data_ports			(i0_soc_it_master_data_ports		),
		.slave_ports				(i0_soc_it_slave_ports				),
		.message_send_ports			(i0_soc_it_message_send_ports		),
		.message_recv_ports			(i0_soc_it_message_recv_ports		)
	);
	

endmodule

