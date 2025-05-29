module register_file(
    input CLK,
    input WE3,
    input [4:0] A1, A2, A3,
    input [31:0] WD3,
    output [31:0] RD1, RD2
);
    // 32 registers x 32 bits each
    reg [31:0] registers [31:0];
    
    // Initialize all registers to 0
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;
        end
    end
    
    // Read operations (asynchronous)
    assign RD1 = registers[A1];
    assign RD2 = registers[A2];
    
    // Write operation (synchronous)
    always @(posedge CLK) begin
        if (WE3) begin
            registers[A3] <= WD3;
        end
    end
endmodule