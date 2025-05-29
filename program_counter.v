module program_counter(
    input CLK,
    input reset,
    input control,
    output reg [7:0] PC
);
    always @(posedge CLK) begin
        if (reset) begin
            PC <= 8'b0;
        end else if (control) begin
            PC <= PC + 1;
        end
    end
endmodule