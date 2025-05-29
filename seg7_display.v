module seg7_display(
    input CLK,
    input [31:0] data,
    output reg [6:0] seg,
    output reg [7:0] an
);
    reg [3:0] digit;
    reg [19:0] counter;
    reg [2:0] digit_sel;
    
    always @(posedge CLK) begin
        counter <= counter + 1;
        if (counter == 20'hFFFFF) begin
            digit_sel <= digit_sel + 1;
            counter <= 0;
        end
    end
    
    always @(*) begin
        an = 8'b11111111;
        an[digit_sel] = 1'b0;
        
        case (digit_sel)
            3'd0: digit = data[3:0];
            3'd1: digit = data[7:4];
            3'd2: digit = data[11:8];
            3'd3: digit = data[15:12];
            3'd4: digit = data[19:16];
            3'd5: digit = data[23:20];
            3'd6: digit = data[27:24];
            3'd7: digit = data[31:28];
            default: digit = 4'b0;
        endcase
        
        case (digit)
            4'h0: seg = 7'b1000000;
            4'h1: seg = 7'b1111001;
            4'h2: seg = 7'b0100100;
            4'h3: seg = 7'b0110000;
            4'h4: seg = 7'b0011001;
            4'h5: seg = 7'b0010010;
            4'h6: seg = 7'b0000010;
            4'h7: seg = 7'b1111000;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0010000;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b0000011;
            4'hC: seg = 7'b1000110;
            4'hD: seg = 7'b0100001;
            4'hE: seg = 7'b0000110;
            4'hF: seg = 7'b0001110;
            default: seg = 7'b1111111;
        endcase
    end
endmodule