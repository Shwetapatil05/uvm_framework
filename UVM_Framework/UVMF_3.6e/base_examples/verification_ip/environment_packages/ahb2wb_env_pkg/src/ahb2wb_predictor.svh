//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : boden
// Creation Date   : 2016 Sep 06
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : ahb2wb_predictor 
// Unit            : ahb2wb_predictor 
// File            : ahb2wb_predictor.svh
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
//
// DESCRIPTION: This analysis component contains analysis_exports for receiving
//   data and analysis_ports for sending data.
// 
//   This analysis component has the following analysis_exports that receive the 
//   listed transaction type.
//   
//   ahb_ae receives transactions of type  ahb_transaction  
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  wb_ap broadcasts transactions of type wb_transaction 
//  ahb_ap broadcasts transactions of type ahb_transaction 
//

class ahb2wb_predictor extends uvm_component;

  // Factory registration of this class
  `uvm_component_utils( ahb2wb_predictor );

  // Instantiate the analysis exports
  uvm_analysis_imp_ahb_ae #(ahb_transaction, ahb2wb_predictor ) ahb_ae;

  // Instantiate the analysis ports
  uvm_analysis_port #(wb_transaction) wb_ap;
  uvm_analysis_port #(ahb_transaction) ahb_ap;

  // Transaction variable for predicted values to be sent out wb_ap
  wb_transaction wb_ap_output_transaction;
  // Code for sending output transaction out through wb_ap
  // wb_ap.write(wb_ap_output_transaction);

  // Transaction variable for predicted values to be sent out ahb_ap
  ahb_transaction ahb_ap_output_transaction;
  // Code for sending output transaction out through ahb_ap
  // ahb_ap.write(ahb_ap_output_transaction);


  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
  endfunction

  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);

    ahb_ae = new("ahb_ae", this);

    wb_ap =new("wb_ap", this );
    ahb_ap =new("ahb_ap", this );

  endfunction

  // FUNCTION: write_ahb_ae
  // Transactions received through ahb_ae initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_ahb_ae(ahb_transaction t);
    `uvm_info("ahb2wb_predictor", "Transaction Recievied through ahb_ae", UVM_MEDIUM)
    if (t.op == AHB_WRITE ) begin  // AHB_WRITE
        // Create transaction for sending to scoreboard
        wb_ap_output_transaction = wb_transaction::type_id::create("wb_ap_output_transaction");
        // Populate predicted fieldss
        wb_ap_output_transaction.op   = WB_WRITE;
        wb_ap_output_transaction.addr = t.addr;
        wb_ap_output_transaction.data = t.data;
        // Send transaction to expected side of scoreboard
        wb_ap.write(wb_ap_output_transaction);
        `uvm_info("PREDICT",{"WB Write Predicted: ",wb_ap_output_transaction.convert2string()},UVM_MEDIUM);
    end else if (t.op == AHB_READ) begin // AHB_READ
        // Send DUT output directly to actual side of scoreboard for comparison with expected
        ahb_ap.write(t);
        `uvm_info("PREDICT",{"AHB Read Actual: ",t.convert2string()},UVM_MEDIUM);
    end
    
  endfunction

endclass 
