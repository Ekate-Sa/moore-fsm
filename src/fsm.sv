`timescale 1ns / 1ps
// Variant - 3
//

module fsm (
  input   logic           clk ,
  input   logic [3:0]     y_in,
  output  logic [3:0]     y_out
);

logic [3:0] state_ff;
logic [3:0] state_next;

always_comb begin
  case (state_ff)
    4'h0 : begin
      state_next = (y_in == 4'b0000) ? 4'h 3
                 : (y_in == 4'b1000) ? 4'h 6 // 10x0
                 : (y_in == 4'b1010) ? 4'h 6 //
                 : (y_in == 4'b1001) ? 4'h A // 1x01
                 : (y_in == 4'b1101) ? 4'h A //
                 : (y_in == 4'b1111) ? 4'h D : state_ff;
    end
    4'h1 : begin
      state_next = (y_in == 4'b0100) ? 4'h 0 // 10xx
                 : (y_in == 4'b0101) ? 4'h 0 //
                 : (y_in == 4'b0110) ? 4'h 0 //
                 : (y_in == 4'b0111) ? 4'h 0 //
                 : (y_in == 4'b1011) ? 4'h 3
                 : (y_in == 4'b1110) ? 4'h 6
                 : (y_in == 4'b1100) ? 4'h 8
                 : (y_in == 4'b0010) ? 4'h B : state_ff;
    end
    4'h2 : begin
      state_next = (y_in == 4'b1011) ? 4'h 1
                 : (y_in == 4'b1111) ? 4'h 6
                 : (y_in == 4'b0000) ? 4'h 9 // 00xx
                 : (y_in == 4'b0001) ? 4'h 9 //
                 : (y_in == 4'b0010) ? 4'h 9 //
                 : (y_in == 4'b0011) ? 4'h 9 //
                 : (y_in == 4'b1100) ? 4'h E : state_ff;
    end
    4'h3 : begin
      state_next = (y_in == 4'b1010) ? 4'h 4
                 : (y_in == 4'b0110) ? 4'h F : state_ff;
    end
    4'h4 : begin
      state_next = (y_in == 4'b1111) ? 4'h 1
                 : (y_in == 4'b0001) ? 4'h 7
                 : (y_in == 4'b1110) ? 4'h 9
                 : (y_in == 4'b0101) ? 4'h C // 01x1
                 : (y_in == 4'b0111) ? 4'h C : state_ff; //
    end
    4'h5 : begin
      state_next = (y_in == 4'b1100) ? 4'h 0
                 : (y_in == 4'b0011) ? 4'h 2
                 : (y_in == 4'b1111) ? 4'h 4
                 : (y_in == 4'b0010) ? 4'h 8 : state_ff;
    end
    4'h6 : begin
      state_next = (y_in == 4'b0001) ? 4'h 1
                 : (y_in == 4'b0010) ? 4'h 5
                 : (y_in == 4'b0011) ? 4'h 8
                 : (y_in == 4'b1001) ? 4'h B
                 : (y_in == 4'b1111) ? 4'h C : state_ff;
    end
    4'h7 : begin
      state_next = (y_in == 4'b0000) ? 4'h 0
                 : (y_in == 4'b1100) ? 4'h 2 // 11x0
                 : (y_in == 4'b1110) ? 4'h 2 //
                 : (y_in == 4'b0101) ? 4'h 5
                 : (y_in == 4'b0011) ? 4'h A
                 : (y_in == 4'b1101) ? 4'h E // 11x1
                 : (y_in == 4'b1111) ? 4'h E : state_ff; //
    end
    4'h8 : begin
      state_next = (y_in == 4'b1010) ? 4'h 1
                 : (y_in == 4'b1101) ? 4'h 3
                 : (y_in == 4'b0011) ? 4'h 6
                 : (y_in == 4'b1011) ? 4'h B
                 : (y_in == 4'b0010) ? 4'h D : state_ff;
    end
    4'h9 : begin
      state_next = (y_in == 4'b0000) ? 4'h 4
                 : (y_in == 4'b0001) ? 4'h 6
                 : (y_in == 4'b1110) ? 4'h C
                 : (y_in == 4'b1010) ? 4'h E : state_ff;
    end
    4'hA : begin
      state_next = (y_in == 4'b0011) ? 4'h 2
                 : (y_in == 4'b1111) ? 4'h 5
                 : (y_in == 4'b1010) ? 4'h 8
                 : (y_in == 4'b0001) ? 4'h D : state_ff;
    end
    4'hB : begin
      state_next = (y_in == 4'b1010) ? 4'h 1
                 : (y_in == 4'b0101) ? 4'h 4
                 : (y_in == 4'b1101) ? 4'h 8
                 : (y_in == 4'b1111) ? 4'h D
                 : (y_in == 4'b1001) ? 4'h E : state_ff;
    end
    4'hC : begin
      state_next = (y_in == 4'b1110) ? 4'h 3
                 : (y_in == 4'b1001) ? 4'h 6
                 : (y_in == 4'b1010) ? 4'h 9 //
                 : (y_in == 4'b1011) ? 4'h 9 //
                 : (y_in == 4'b0000) ? 4'h E : state_ff;
    end
    4'hD : begin
      state_next = (y_in == 4'b0010) ? 4'h 0
                 : (y_in == 4'b0101) ? 4'h 2
                 : (y_in == 4'b1001) ? 4'h 3
                 : (y_in == 4'b1110) ? 4'h 5
                 : (y_in == 4'b1111) ? 4'h A : state_ff;
    end
    4'hE : begin
      state_next = (y_in == 4'b1111) ? 4'h 1
                 : (y_in == 4'b1101) ? 4'h 4
                 : (y_in == 4'b1100) ? 4'h 7 //
                 : (y_in == 4'b1110) ? 4'h 7 : state_ff; //
    end
    4'hF : begin
      state_next = (y_in == 4'b1100) ? 4'h 3
                 : (y_in == 4'b1010) ? 4'h 6
                 : (y_in == 4'b0000) ? 4'h A
                 : (y_in == 4'b0100) ? 4'h C //
                 : (y_in == 4'b0101) ? 4'h C //
                 : (y_in == 4'b0110) ? 4'h C //
                 : (y_in == 4'b0111) ? 4'h C : state_ff; //
    end
    // a-la reset
    default : state_next = 4'b 0000;
  endcase
end


always_ff @( posedge clk ) begin
  state_ff <= state_next;
end

assign y_out = state_ff;

endmodule
