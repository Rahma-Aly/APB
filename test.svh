`ifndef TEST_SVH
`define TEST_SVH
 import uvm_pkg::*;
 `include"uvm_macros.svh"
 import apb_pkg::*;

 class test extends uvm_test;
	 `uvm_component_utils(test)
	 virtual apb_interface vif;
	 v_seq mv_seq;
	 env m_env;

	 function new (string name = "test", uvm_component parent = null);
	 	super.new(name,parent);
	 endfunction : new

	 virtual function void build_phase (uvm_phase phase);
	 	super.build_phase(phase);
	 	if (!uvm_config_db#(virtual apb_interface)::get(this,"","apb_interface",vif)) begin
			 `uvm_fatal(get_type_name(),"Couldn't find virtual interface")
	 	end
	 	uvm_config_db#(virtual apb_interface)::set(this,"m_env.m_agent.*","apb_interface",vif);
		m_env = env::type_id::create("m_env",this);
		mv_seq =v_seq::type_id::create("mv_seq");
	endfunction : build_phase

	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		mv_seq.m_sequencer = m_env.m_agent.m_sequencer;	
		mv_seq.start(null);
		#100;
		phase.drop_objection(this);
	endtask : run_phase

	 endclass : test

`endif
