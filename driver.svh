`ifndef DRIVER_SVH
`define DRIVER_SVH

import uvm_pkg::*;
import apb_pkg::*;
`include "uvm_macros.svh"

class driver extends uvm_driver #(apb_transaction);
	`uvm_component_utils(driver)
	virtual apb_interface vif;

	function new (string name = "driver", uvm_component parent=null);
		super.new(name,parent);
	endfunction:new

	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db #(virtual apb_interface) :: get (this,"*","apb_interface",vif)) begin
			`uvm_fatal(get_type_name(),"Virtual interface not found")
		end
	endfunction:build_phase

	virtual task run_phase( uvm_phase phase); 
		apb_transaction m_trans;
		forever begin
			seq_item_port.get_next_item(m_trans);
		/*	if (~m_trans.presetn) begin
				vif.cb_driver.presetn <= m_trans.presetn;
				vif.cb_driver.penable <= 1'b0;
				vif.cb_driver.paddr <= m_trans.paddr;
				vif.cb_driver.pwrite <= m_trans.pwrite;
				vif.cb_driver.psel <= m_trans.psel;
			end
			else begin*/ 
		       	vif.cb_driver.presetn <= m_trans.presetn;
			@(vif.cb_driver)
				vif.cb_driver.psel <= m_trans.psel;
				if (m_trans.psel && vif.psel) begin
					vif.cb_driver.penable <= 1'b1;
				end 
				else if (~m_trans.psel) begin
					vif.cb_driver.penable <= 1'b0;
					vif.cb_driver.paddr <= m_trans.paddr;
					vif.cb_driver.pwrite <= m_trans.pwrite;
					if (m_trans.pwrite) begin
						vif.cb_driver.pwdata <= m_trans.pwdata;
					end
				end
				else if (m_trans.psel && ~vif.psel) begin 
					vif.cb_driver.penable <= 1'b0;
				end	
			//end	
			seq_item_port.item_done();
		end
	endtask : run_phase

endclass : driver	


`endif
