//
//
//

module tb_fsm
  import fsm_ref_pkg::*;
();


logic clk;
logic [3:0] dut_in;
logic [3:0] dut_out;

logic [3:0] NOW_RANDOM_IN;

fsm dut (
  .clk  (clk),
  .y_in (dut_in ),
  .y_out(dut_out)
);

always #10 clk <= ~clk;

//------------------------------------------------------------
// Test signals

typedef struct packed {
  logic [15:0] was; // was or wasn't for every y_in
} cover_comb;

// For every Y_out we check that all possible inputs are covered
cover_comb [15:0] track;
// "expecting transition"
logic       expect_trans;
logic [3:0] trans_to;

//---------------------
// AUX test tasks

// --- [not used]
// Task to find input value that wasn't tried yet
// may be not_found
task find_first(
  input  logic [15:0] line,
  output logic [3 :0] first_idx
  );

  logic [3:0] temp_var;
  temp_var = 4'hF;

  // from last to first
  for (int unsigned i = 15; i>=0 ; i=i-1 ) begin
    if (~line[i]) begin
      temp_var = i[3:0];
    end
  end

  first_idx = temp_var;
endtask // find_first
//
//
task first_found(
  input  logic [15:0] line,
  output logic        first_found
);
  first_found = 1'b0;
  // from last to first
  for (int i = 15; i>=0 ; i=i-1 ) begin
    if (~line[i]) begin
      first_found = 1'b1;
    end
  end
endtask

// ---
// Task to track tried combinations
//
task write_down(input logic[3:0] y_in,y_out);
  track[y_out].was[y_in] = 1'b1;
endtask

// ---
// Task to check if state transition is expected
//
task is_trans_expect(
  input logic [3:0] in, cur
);
  expect_trans = 1'b0;
  trans_to = cur;
  for (int i = 0; i<TRANS_NUM ; i=i+1 ) begin
    if ({cur , in} == TRANS_ARR[i][11:4]) begin
      expect_trans = 1'b1;
      trans_to = TRANS_ARR[i][3:0];
    end
  end
endtask


//---------------------
// Main test tasks

// ---
// initial setting of inputs
// and coverage log
task setup ();

  clk = 1'b0;

  for (int i = 0; i<16; i++)
    track[i].was = '0;

  NOW_RANDOM_IN = 4'h0;
  expect_trans = 1'b0;
endtask //

// ---
// Send N random stimulus
// (this is probably the only way to cover the whole graph..)
task rand_stimul(input int N);
  int         rand_int;
  logic [3:0] temp_in;
  logic       found;

  for (int i = 0; i<N; i=i+1) begin

    first_found(track[dut_out].was, found);

    if ( found ) begin
      NOW_RANDOM_IN = 4'h0;
      find_first( track[dut_out].was ,temp_in );
      dut_in = temp_in;
    end else begin
      NOW_RANDOM_IN = 4'h1;
      rand_int = $urandom();
      //$display("rand %d", rand_int);
      dut_in = rand_int[3:0];
    end

    write_down(dut_in , dut_out);

    // -- CHECKING PART
    is_trans_expect(dut_in , dut_out);

    //! if (expect_trans)
    //!   $display("[%t] Expect trans to %h", $time, trans_to);
    //! else
    //!   $display("[%t] No trans expected", $time);

    @(posedge clk);
    @(negedge clk);
    if (dut_out != trans_to) begin
      $display("Error, wrong state");
      $stop;
    end

  end

endtask //

// ---
// Check covered combinations

task statistic();
  int yes;
  int no;
  yes = 0;
  no  = 16*16;
  for (int i = 0; i<16; i++) begin
    yes = yes + $countones(track[i]);
    no  = no  - $countones(track[i]);
  end

  $display("~------Coverage------~");
  $display("COVERED: %d"    , yes);
  $display("NOT COVERED: %d", no );
endtask //

//===============================
//      INITIAL BEGIN
//===============================

int N;

initial begin

  setup();
  @(posedge clk);

  N = 0;

  // -- Generate test inputs
  while ($countones(track) < 256) begin
    rand_stimul(1);
    N=N+1;
  end

  // -- Measure coverage
  statistic();
  $display("%d iterations made", N);

  $finish;

end

endmodule
