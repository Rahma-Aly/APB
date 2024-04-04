`ifndef MONITOR_SVH
`define MONITOR_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
import apb_pkg::*;

class monitor extends uvm_monitor;
	`uvm_component_utils(monitor)
	virtual apb_interface vif;
	apb_transaction m_trans;
	uvm_analysis_port #(apb_transaction) m_ap;

	function new (string name = "monitor" , uvm_component parent=null);
		super.new(name,parent);
	endfunction: new

	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db #(virtual apb_interface)::get(this,"*","apb_interface",vif)) begin
			`uvm_fatal(get_type_name(),"couldn't get interface")
		end
		m_ap = new("m_ap",this);
	endfunction: build_phase

	virtual task run_phase (uvm_phase phase);
		forever begin
			@(vif.cb_monitor); 
			if (vif.cb_monitor.presetn) begin
				m_trans = apb_transaction::type_id::create("m_trans",this);
				m_trans.psel = vif.cb_monitor.psel;
				m_trans.penable = vif.cb_monitor.penable;
				m_trans.pwrite = vif.cb_monitor.pwrite;
				m_trans.paddr = vif.cb_monitor.paddr;
				m_trans.pwdata = vif.cb_monitor.pwdata;
				m_trans.prdata = vif.cb_monitor.prdata;
				m_trans.pready = vif.cb_monitor.pready;

				m_ap.write(m_trans);
			//	`uvm_info(get_type_name(),$sformatf("Transaction : ", m_trans.convert2string()),UVM_MEDIUM)
			end
		end
	endtask : run_phase

endclass : monitor	


`endif
