//----------------------------------------------------------------------
//   Copyright 2013 Mentor Graphics Corporation
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                   Mentor Graphics Inc
//----------------------------------------------------------------------
// Project         : AHB interface agent
// Unit            : Sequence library
// File            : ahb_sequence_base.svh
//----------------------------------------------------------------------
// Creation Date   : 05.12.2011
//----------------------------------------------------------------------
// Description: This file contains the base sequence for all ahb
//    sequences.
//
//----------------------------------------------------------------------
class ahb_sequence_base extends uvmf_sequence_base #(ahb_transaction, ahb_transaction);

  `uvm_object_utils( ahb_sequence_base )

  function new( string name ="");
    super.new( name );
  endfunction

endclass

