package apb_pkg;

parameter addrWidth = 'd12;
	`include "apb_transaction.svh"
	`include "driver.svh"
	`include "monitor.svh"
	`include "agent.svh"
	`include "scoreboard.svh"
	`include "env.svh"
	`include "seq.svh"
	`include "rst_seq.svh"
	`include "v_seq.svh"
	`include "test.svh"

endpackage : apb_pkg
