module NewtonRaphsonTB();

     reg clk, rst, start;
    reg [15:0] dividend;
    reg [7:0] divisor;
    wire [15:0] quotient;
    wire done;

    NewtonRaphson D1 (clk,rst,start,dividend,divisor,quotient,done);

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; start = 0;
        #20 rst = 0;

        dividend = 16'd10000; divisor = 8'd2;
        #10 start = 1; #10 start = 0;
        wait(done);


        #30 dividend = 16'd65535; divisor = 8'd200;
        #10 start = 1; #10 start = 0;
        wait(done);


        #30 dividend = 16'd38400; divisor = 8'd128;
        #10 start = 1; #10 start = 0;
        wait(done);


        #50 $stop;
    end
endmodule
