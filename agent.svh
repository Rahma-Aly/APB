`ifndef AGENT_SVH
`define AGENT_SVH
import uvm_pkg::*;
`include "uvm_macros.svh"
import apb_pkg::*;

class agent extends uvm_agent;
	`uvm_component_utils(agent)
	driver m_driver;
	monitor m_monitor;
//	uvm_analysis_port #(apb_transaction) m_ap;
	uvm_sequencer #(apb_transaction) m_sequencer;

	function new (string name = "agent", uvm_component parent = null);
		super.new(name,parent);
	endfunction :new

	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		m_driver = driver ::type_id::create("m_driver",this);
		m_monitor = monitor ::type_id::create("m_monitor",this);
		m_sequencer= uvm_sequencer#(apb_transaction)::type_id::create("m_sequencer",this);
	endfunction : build_phase

	virtual function void connect_phase(uvm_phase phase);
		m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
	//	m_monitor.m_ap.connect(m_ap);		
	endfunction : connect_phase

endclass :agent

`endif
