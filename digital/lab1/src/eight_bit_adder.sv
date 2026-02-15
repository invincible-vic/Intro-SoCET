
module eight_bit_adder(
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [8:0] c
);
    logic [6:0] carries;
    // TODO: Implement logic for an eight-bit full adder
    // *by instantiating 'full_adder' modules!*
    // Note: One solution to this would be simply:
    // assign c = a + b;
    // HINT: For ease of implementation, you can use
    // a "generate" loop: https://www.systemverilog.io/verification/generate/
    
    logic [8:0] car;
    assign car[0] = 1'b0;
    
    genvar i; 
    generate
        for (i = 0; i < 8; i++) begin
            full_adder(
                .a(a[i]),
                .b(b[i]),
                .cin(car[i]),
                .s(c[i]),
                .cout(car[i + 1])
            )
        end
    endgenerate

    assign c[8] = car[8];
        
endmodule