\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
   m4_include_lib(['https://raw.githubusercontent.com/stevehoover/LF-Building-a-RISC-V-CPU-Core/main/lib/calc_viz.tlv'])
/* verilator lint_on WIDTH */
\TLV
   $reset = *reset;
   //$val1_literal[25:0] = 26'b00000000000000000000000000; // Zeroes to combine with val1_rand (Not used in sequential mode)
   $val2_literal[27:0] = 28'b0000000000000000000000000000; // Zeroes to combine with val2_rand
   $val1[31:0] = >>1$out; // Reset output to $out
   $val2[31:0] = { $val2_literal , $val2_rand[3:0] }; // Combine values to create the added value
   $sum[31:0] = $val1 + $val2; // Operation defintions
   $diff[31:0] = $val1 - $val2;
   $prod[31:0] = $val1 * $val2;
   $quot[31:0] = $val1 / $val2;
   $out[31:0] = $reset ? 32'b0 : // Output multiplexer
      $op[1:0] == 2'b11 ? $quot :
      $op == 2'b10 ? $prod :
      $op == 2'b01 ? $diff :
       $sum;


   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
   m4+calc_viz()
\SV
   endmodule
