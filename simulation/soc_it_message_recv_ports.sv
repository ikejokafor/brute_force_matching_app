`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////
// soc_it_message_recv_ports.sv
// 2/10/2011
//
// Sungho Park
// Microsystems Design Lab
// Department of Computer Science and Engineering
// Pennsylvania State University
/////////////////////////////////////////////////////////////////////////////
// (REVISION HISTORY)
// 3/26/2011	modified to SOC_IT_v3_00_a
/////////////////////////////////////////////////////////////////////////////

`ifndef	__SOC_IT_MESSAGE_RECV_PORTS__
`define	__SOC_IT_MESSAGE_RECV_PORTS__

interface soc_it_message_recv_ports (
	input	logic						clk							,
	input	logic						rst							,
	output	logic						recv_msg_request			,
	input	logic						recv_msg_ack				,
	output	logic						recv_msg_src_rdy			,
	input	logic						recv_msg_dst_rdy			,
	output	logic	[127:0]				recv_msg_payload			
);

	clocking cb @(posedge clk);
		input	rst							;
		output	recv_msg_request			;
		input	recv_msg_ack				;
		output	recv_msg_src_rdy			;
		input	recv_msg_dst_rdy			;
		output	recv_msg_payload			;
	endclocking

endinterface: soc_it_message_recv_ports

`endif
