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

`ifndef	__SOC_IT_DRIVER__
`define	__SOC_IT_DRIVER__

//-----------------------------------------------------------------------------------------------------------------------------------------------
// Includes
//-----------------------------------------------------------------------------------------------------------------------------------------------
`include "soc_it_master_request_ports.sv"
`include "soc_it_master_descriptor_ports.sv"
`include "soc_it_master_data_ports.sv"
`include "soc_it_slave_ports.sv"
`include "soc_it_message_send_ports.sv"
`include "soc_it_message_recv_ports.sv"
`include "soc_it_defs.vh"

typedef class soc_it_driver;
typedef enum bit {TRUE = 1, FALSE = 0} bool;
typedef bit [127:0] mem_queue_t[$];

`define DEFAULT_TAG 4'b1000

class soc_it_driver;
	
	//-----------------------------------------------------------------------------------------------------------------------------------------------
	// Class Properties
	//-----------------------------------------------------------------------------------------------------------------------------------------------	
	virtual 	soc_it_master_request_ports 	m_req_ports 	;	
	virtual		soc_it_master_descriptor_ports 	m_desc_ports 	;
	virtual		soc_it_master_data_ports 		m_data_ports 	;
	virtual 	soc_it_slave_ports 				m_slv_ports 	;
	virtual 	soc_it_message_send_ports 		m_send_ports 	;
	virtual 	soc_it_message_recv_ports 		m_recv_ports 	;
	
	bit			[63:0]		m_descriptor_address;
	bit			[63:0]		m_local_address;
	bit 		[35:0]		m_local_length;
	bit 		[3 :0]		m_req_type;
	bit			[15:0]		m_device_id;
	
	bit 		[63:0]		m_mainMemory[bit[63:0]];
	integer					m_rand_latency;
	logic		[3:0]		m_tag;
	bit 		[63:0] 		descriptor_address;
	bit 		[7:0] 		msg_type;
	semaphore  				m_sema;

	extern task initMemory();
	extern function new	(	
							virtual soc_it_master_request_ports req_ports, 
							virtual soc_it_master_descriptor_ports desc_ports, 
							virtual soc_it_master_data_ports data_ports, 
							virtual soc_it_slave_ports slv_ports,
							virtual soc_it_message_send_ports msgsend_ports, 
							virtual soc_it_message_recv_ports msgrecv_ports
						);
	extern task do_service();	
	extern task accept_descriptor();
	extern task display_request();
	extern task accept_data_master(bit[63:0] descriptor_address, bit[63:0] local_length, logic[3:0] tag);	
	extern task inject_data_master(bit[63:0] descriptor_address, bit[63:0] local_length, logic[3:0] tag);
	extern task sendMsgTransaction(logic [63:0] memSpaceAddress, int length); 
	extern task delay(integer cycles);
	extern function mem_queue_t readFromMem(bit [63:0] startAddress, bit[35:0] length);
	extern function void writeToMem(bit [127:0] mem_piece, bit [63:0] startAddress, bit[35:0] length);
	extern task display_descriptor(bit [127:0] descriptor);
	extern task display_data(integer count, bit [127:0] data);
	
endclass: soc_it_driver	

	
	
//-----------------------------------------------------------------------------------------------------------------------------------------------
// Define Class Methods
//-----------------------------------------------------------------------------------------------------------------------------------------------	
task soc_it_driver::initMemory();

	integer fid;	
	bit [63:0] mem_piece;
	bit [63:0] address;
	string line;
	
	//Data
	fid = $fopen("master_data.txt", "r");
	while (!$feof(fid))	begin
		$fgets(line, fid);
		if($feof(fid)) begin
			break;
		end
		
		$sscanf(line, "%016X\t%016X\n", address, mem_piece);
		m_mainMemory[address] = mem_piece;
	end
	$fclose(fid);
	
endtask : initMemory

function soc_it_driver::new	(	
								virtual soc_it_master_request_ports req_ports, 
								virtual soc_it_master_descriptor_ports desc_ports, 
								virtual soc_it_master_data_ports data_ports, 
								virtual soc_it_slave_ports slv_ports,
								virtual soc_it_message_send_ports msgsend_ports, 
								virtual soc_it_message_recv_ports msgrecv_ports
							);
	
	m_req_ports 	= req_ports; 
	m_desc_ports 	= desc_ports; 
	m_data_ports 	= data_ports;
	m_slv_ports 	= slv_ports;
	m_send_ports 	= msgsend_ports;
	m_recv_ports 	= msgrecv_ports;	
	
	m_desc_ports.cb.master_descriptor_src_rdy	<= 0;
	m_desc_ports.cb.master_descriptor_dst_rdy	<= 0;
	m_desc_ports.cb.master_descriptor_tag		<= `DEFAULT_TAG;

	m_req_ports.cb.master_request_ack			<= 0;
	m_req_ports.cb.master_request_complete		<= 0;
	m_req_ports.cb.master_request_error			<= 0;
	m_req_ports.cb.master_request_tag			<= `DEFAULT_TAG;
	

	m_data_ports.cb.master_datain_src_rdy		<= 0;
	m_data_ports.cb.master_datain_tag			<= `DEFAULT_TAG;
	m_data_ports.cb.master_datain				<= 128'b0;
	m_data_ports.cb.master_dataout_dst_rdy		<= 0;
	m_data_ports.cb.master_dataout_tag			<= `DEFAULT_TAG;
	
	m_slv_ports.cb.slave_address				<= 0;
	m_slv_ports.cb.slave_transaction_id			<= 0;
	m_slv_ports.cb.slave_address_valid			<= 0;
	m_slv_ports.cb.slave_wrreq					<= 0;
	m_slv_ports.cb.slave_be						<= 0;
	m_slv_ports.cb.slave_datain					<= 0;
	m_slv_ports.cb.slave_rdreq					<= 0;

	m_send_ports.cb.send_msg_ack				<= 0;
	m_send_ports.cb.send_msg_complete			<= 0;
	m_send_ports.cb.send_msg_error				<= 0;
	m_send_ports.cb.send_msg_dst_rdy			<= 0;

	m_recv_ports.cb.recv_msg_request			<= 0;
	m_recv_ports.cb.recv_msg_src_rdy			<= 0;
	m_recv_ports.cb.recv_msg_payload			<= 0;
	
	m_tag										= 4'b1000;
	m_sema										= new(1);
	
endfunction: new


task soc_it_driver::do_service();	

	sendMsgTransaction(64'h000001001F3074A0	, 80);	// sxv49 change

	while (TRUE) begin
		@(m_req_ports.cb);
		if(m_req_ports.cb.master_request) begin
			m_req_type 		= m_req_ports.cb.master_request_type;
			m_local_length 	= m_req_ports.cb.master_request_length;
			m_local_address = m_req_ports.cb.master_request_local_address;
			
			@(m_req_ports.cb);
			m_req_ports.cb.master_request_ack 		<= 1;
			m_desc_ports.cb.master_descriptor_tag	<= m_tag;
			m_req_ports.cb.master_request_tag 		<= m_tag;

			display_request();

			@(m_req_ports.cb);
			m_req_ports.cb.master_request_ack 	<= 0;
			m_req_ports.cb.master_request_tag 	<= `DEFAULT_TAG;

			accept_descriptor();

			case (m_req_type)
				`NIF_MASTER_CMD_WRREQ: begin
					fork
						automatic logic [3:0] tag 					= m_tag;
						automatic logic [3:0] descriptor_address	= m_descriptor_address;
						automatic logic [3:0] local_length			= m_local_length;
						accept_data_master(m_descriptor_address, m_local_length, tag);
					join_none
					
				end
				
				`NIF_MASTER_CMD_RDREQ: begin
					fork
						automatic logic [3:0] tag 					= m_tag;
						automatic logic [3:0] descriptor_address	= m_descriptor_address;
						automatic logic [3:0] local_length			= m_local_length;
						inject_data_master(m_descriptor_address, m_local_length, tag);
					join_none
				end
				
				`NIF_MASTER_CMD_WRREQ_DMA: begin
					$display("SLAVE FUNCTIONALITY NOT IMPLEMENTED!!");
				end
				
				`NIF_MASTER_CMD_RDREQ_DMA: begin
					$display("SLAVE FUNCTIONALITY NOT IMPLEMENTED!!");
				end
			endcase
			
			// TODO: make this cleaner
			m_tag++;
			if(m_tag == 4'b000) begin
				m_tag = 4'b1001;
			end

		end		
	end

endtask: do_service


task soc_it_driver::accept_descriptor();
	
	@(m_desc_ports.cb);
	m_desc_ports.cb.master_descriptor_dst_rdy <= 1;

	while (TRUE) begin	
		wait(m_desc_ports.cb.master_descriptor_src_rdy);
		display_descriptor(m_desc_ports.cb.master_descriptor);
		if (m_desc_ports.cb.master_descriptor[`NIF_DMA_DESCRIPTOR_LAST_TARGET_FLAG]) begin
			break;
		end	
	end
	
	@(m_desc_ports.cb);
	m_desc_ports.cb.master_descriptor_tag		<= `DEFAULT_TAG;
	m_desc_ports.cb.master_descriptor_dst_rdy	<= 0;
	m_descriptor_address = m_desc_ports.cb.master_descriptor[`NIF_DMA_DESCRIPTOR_ADDRESS_FIELD];

endtask: accept_descriptor


task soc_it_driver::display_request();
	$display("I @%t [0x%04x] REQUEST DRIVER: REQ ACKED (TAG = %d)", $time(), m_device_id, m_tag);

	case (m_req_type)
		`NIF_MASTER_CMD_WRREQ: begin
			$display(" - WRREQ CMD");
			$display(" - LOCAL LENGTH  = 0x%09x", m_local_length);
		end
		
		`NIF_MASTER_CMD_RDREQ: begin
			$display(" - RDREQ CMD");
			$display(" - LOCAL ADDRESS = 0x%09x", m_local_address);
			$display(" - LOCAL LENGTH  = 0x%09x", m_local_length);
		end
		
		`NIF_MASTER_CMD_WRREQ_DMA: begin
			$display(" - WRREQ_DMA CMD");
			$display(" - LOCAL ADDRESS = 0x%09x", m_local_address);
			$display(" - LOCAL LENGTH  = 0x%09x", m_local_length);
		end
		
		`NIF_MASTER_CMD_RDREQ_DMA: begin
			$display(" - RDREQ_DMA CMD");
			$display(" - LOCAL ADDRESS = 0x%09x", m_local_address);
			$display(" - LOCAL LENGTH  = 0x%09x", m_local_length);
		end
		
		`NIF_MASTER_CMD_WRREQ_SINGLE: begin
			$display(" - WRREQ_SINGLE CMD");
			$display(" - LOCAL LENGTH  = 0x%09x", m_local_length);
		end
		
		`NIF_MASTER_CMD_RDREQ_SINGLE: begin
			$display(" - RDREQ_SINGLE CMD");
			$display(" - LOCAL ADDRESS = 0x%09x", m_local_address);
			$display(" - LOCAL LENGTH  = 0x%09x", m_local_length);
		end
		
	endcase
	
endtask: display_request


task soc_it_driver::accept_data_master(bit[63:0] descriptor_address, bit[63:0] local_length, logic[3:0] tag);	

	integer	count = 0;
	
	m_sema.get(1);
	
	@(m_data_ports.cb);	
	m_data_ports.cb.master_dataout_tag		<= tag;
	m_data_ports.cb.master_dataout_dst_rdy 	<= 1;

	while(TRUE) begin	
		@(m_data_ports.cb);
		
		if (count == (local_length / 16)) begin	
		
			m_data_ports.cb.master_dataout_tag		<= `DEFAULT_TAG;
			m_data_ports.cb.master_dataout_dst_rdy 	<= 0;
			break;
			
		end else begin
		
			wait(m_data_ports.cb.master_dataout_src_rdy);
			count++;
			
		end		
	end
	
	@(m_req_ports.cb);
	m_req_ports.cb.master_request_complete 	<= 1;
	m_req_ports.cb.master_request_tag 		<= tag;

	
	@(m_req_ports.cb);
	m_req_ports.cb.master_request_complete 	<= 0;
	m_req_ports.cb.master_request_error 	<= `NIF_ERRCODE_NO_ERROR;
	m_req_ports.cb.master_request_tag 		<= `DEFAULT_TAG;
	
	m_sema.put(1);
	
endtask: accept_data_master


task soc_it_driver::inject_data_master(bit[63:0] descriptor_address, bit[63:0] local_length, logic[3:0] tag);
	bit [127:0]	mem_piece;

	mem_queue_t mem_fifo = readFromMem(descriptor_address, local_length);
	mem_piece = mem_fifo.pop_front();
	
	m_sema.get(1);
	$display("Transfer Started for transaction tag %d", tag);
	@(m_data_ports.cb);
	m_data_ports.cb.master_datain 			<= mem_piece;
	m_data_ports.cb.master_datain_tag 		<= tag;
	
	repeat (1) @(m_data_ports.cb)
	m_data_ports.cb.master_datain_src_rdy <= 1;
	
	while(TRUE) begin
		@(m_data_ports.cb);
		
		if (mem_fifo.size() == 0) begin
			
			m_data_ports.cb.master_datain_tag 		<= `DEFAULT_TAG;
			m_data_ports.cb.master_datain_src_rdy 	<= 0;
			m_data_ports.cb.master_datain 			<= 0;
			$display("Transfer Compelete for transaction tag %d", tag);
			break;
			
		end else begin
		
			wait(m_data_ports.cb.master_datain_dst_rdy);
			mem_piece = mem_fifo.pop_front();
			m_data_ports.cb.master_datain 		<= mem_piece;
		
		end
	end
	
	@(m_req_ports.cb);
	m_req_ports.cb.master_request_complete 	<= 1;
	m_req_ports.cb.master_request_tag 		<= tag;
	
	@(m_req_ports.cb);
	m_req_ports.cb.master_request_complete 	<= 0;
	m_req_ports.cb.master_request_error 	<= `NIF_ERRCODE_NO_ERROR;
	m_req_ports.cb.master_request_tag 		<= `DEFAULT_TAG;
	
	m_sema.put(1);
endtask: inject_data_master


task soc_it_driver::sendMsgTransaction(logic [63:0] memSpaceAddress, int length); 
	
	bit [127:0] payload_piece;
	mem_queue_t mem_fifo;
	
	mem_fifo = readFromMem(memSpaceAddress, length);
	
	wait(!m_recv_ports.cb.rst);	
	@(m_recv_ports.cb);
	m_recv_ports.cb.recv_msg_request <= 1;
	m_recv_ports.cb.recv_msg_src_rdy <= 1;
	m_recv_ports.cb.recv_msg_payload <= mem_fifo.pop_front();
	
	wait(m_recv_ports.cb.recv_msg_ack && m_recv_ports.cb.recv_msg_dst_rdy)
	m_recv_ports.cb.recv_msg_request <= 0;
	$display("Send Message Complete ********* index is %d", 0);
	
	for(int i = 1; i<(length/16); i++) begin
		m_recv_ports.cb.recv_msg_payload <= mem_fifo.pop_front();
		$display("Send Message Complete ********* index is %d", i);
		@(m_recv_ports.cb);
	end
	m_recv_ports.cb.recv_msg_src_rdy <= 0;
	
endtask: sendMsgTransaction


task soc_it_driver::delay(integer cycles);
	repeat (cycles) @(m_req_ports.cb);	
endtask: delay


function mem_queue_t soc_it_driver::readFromMem(bit [63:0] startAddress, bit[35:0] length);
	bit [127:0] mem_piece;
	bit [63:0] address = startAddress;
	mem_queue_t mem_queue;
	
	for(int length_count = 0; length_count < length; length_count = length_count + 16, address = address + 64'd16) begin
		if(!m_mainMemory.exists(address) || !m_mainMemory.exists(address + 64'd8)) begin
			$display("");
			$display("Invalid read address");
			$display("Address 0x%08X or Address 0x%08X is incorrect", address, address + 64'd8);
			$display("");
			$stop;
		end		
		
		mem_piece[63:0] 	= m_mainMemory[address];
		mem_piece[127:64] 	= m_mainMemory[address + 64'd8];
		mem_queue.push_back(mem_piece);
	end
	
	return mem_queue;

endfunction


function void soc_it_driver::writeToMem(bit [127:0] mem_piece, bit [63:0] startAddress, bit[35:0] length);
	bit [63:0] address = startAddress;
	
	for(int length_count = 0; length_count < length; length_count = length_count + 16, address = address + 64'd16) begin	
		m_mainMemory[address] 			= mem_piece[63:0];
		m_mainMemory[address + 64'd8]  = mem_piece[127:64];
	end
endfunction :writeToMem


task soc_it_driver::display_descriptor(bit [127:0] descriptor);
	$display("Descriptor Address: 	0x%016X"	, descriptor[127:64]);
	$display("Descriptor Length: 	%d bytes"	, descriptor[35:0]);
	$display("Descriptor Device ID: %d"			, descriptor[51:36]);
endtask: display_descriptor


task soc_it_driver::display_data(integer count, bit [127:0] data);
	$display("[%04d] 0x%032x", count, data);
endtask: display_data

`endif

