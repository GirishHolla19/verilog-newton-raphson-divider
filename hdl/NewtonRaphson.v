module NewtonRaphson(input  wire clk, rst, start, input  wire [15:0] dividend, input  wire [7:0]  divisor,output reg  [15:0] quotient, output reg done);

    integer i;

    reg [15:0] N;
    reg [15:0] D;
    reg signed [31:0] x, temp3;
    reg signed [63:0] temp, temp2;

    localparam SCALE = 32'sd16384;   // Scaling as per Q2.14

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            quotient <= 0;
            done <= 0;
        end else begin
            done <= 0;

            if (start) begin
                N = dividend;
                D = divisor;


                if (D >= 8'd128)      x = 32'sd128;    // 1/128
                else if (D >= 8'd64)  x = 32'sd256;    // 1/64
                else if (D >= 8'd32)  x = 32'sd512;    // 1/32
                else if (D >= 8'd16)  x = 32'sd1024;   // 1/16
                else if (D >= 8'd8)   x = 32'sd2048;   // 1/8
                else if (D >= 8'd4)   x = 32'sd4096;   // 1/4
                else if (D >= 8'd2)   x = 32'sd8192;   // 1/2
                else                  x = 32'sd16384;  // 1


                for (i = 0; i < 5; i = i + 1) begin
                    temp2 = D*x;
                    temp = x * (32'sd32768 - temp2);
                    x = temp >>> 14;
                end
                temp3 = N*x;
                quotient <= (temp3) >>> 14;
                done <= 1;#2;
            end
        end
    end
endmodule
