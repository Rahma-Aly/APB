`ifndef ENV_SVH
`define ENV_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
import apb_pkg::*;

class env extends uvm_env;
	`uvm_component_utils(env)
	agent m_agent;
	scoreboard m_scrbrd;

	function new (string name ="env" , uvm_component parent = null);
	       super.new(name,parent);
        endfunction: new	

	virtual function void build_phase  (uvm_phase phase);
		super.build_phase(phase);
		m_agent = agent ::type_id::create("m_agent",this);
		m_scrbrd = scoreboard::type_id::create("m_scrbrd",this);
	endfunction: build_phase	

	virtual function void connect_phase(uvm_phase phase);
		m_agent.m_monitor.m_ap.connect(m_scrbrd.analysis_export);
	endfunction :connect_phase
endclass : env

`endif
