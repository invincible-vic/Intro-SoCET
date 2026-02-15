
module tb_eight_bit_adder();
    
    localparam DELAY = 10;

    // TB <-> DUT connections
    logic [7:0] a;
    logic [7:0] b;
    logic [8:0] c;

    // TB signals
    int num_passed;
    int num_tests;

    // DUT instance
    // Automatic connections of a, b, c
    eight_bit_adder DUT(.*);

    // input & checking task
    task apply_inputs(
        input [7:0] in_a,
        input [7:0] in_b,
        input [8:0] expected
    );
        // TODO: Fill in the task by:
        // 1. Applying the inputs to the DUT
        // 2. #(DELAY)
        // 3. Check that the DUT output is equal to the expected value
        // 4. Print a message if it is wrong
        // 5. Increment "num_passed" if it is right

        // YOUR CODE HERE
        num_tests += 1;
        a = in_a;
        b = in_b;
        #(DELAY);
        if(expected != c) begin
            $display("[Time %0t]: Expected %2b, got %2b\n", $time, expected, c);
        end else begin
            num_passed += 1;
        end

    endtask

    initial begin
        $dumpfile("waveform.fst");
        $dumpvars;
        a = 0;
        b = 0;
        num_passed = 0;
        num_tests = 0;

        // Running *every* test case for this would not scale well!
        // 2^16 input combinations for an 8-bit adder! (now recall your 64b computer)
        // We have to run subsets of the entire test that *cover* what we're interested in.
        
        // TODO: Pick out some interesting test cases and run them here. What are
        // some corner cases?
        apply_inputs(8'b00000000, 8'b00000000, 9'b000000000);
        apply_inputs(8'b11111111, 8'b00000000, 9'b011111111);
        apply_inputs(8'b11111111, 8'b00000001, 9'b100000000);
        apply_inputs(8'b11111111, 8'b11111111, 9'b111111110);

        // Run 1000 random test cases
        for(int i = 0; i < 1000; i++) begin
            bit [31:0] in_a = $urandom_range(255);
            bit [31:0] in_b = $urandom_range(255);
            bit [31:0] expected = in_a + in_b;
            apply_inputs(in_a[7:0], in_b[7:0], expected[8:0]);
        end

        $display("Passed %0d/%0d tests.", num_passed, num_tests);
        $finish();
    end
endmodule