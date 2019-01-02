
`timescale 1ns / 1ps
module CU(
            Busy,
            clk, reset,
            CO, Z, 
            CUconst,
            InMuxAdd,
            InsSel,
            OutMuxAdd, RegAdd,
            Start,
            WE
        );
        input clk, reset, CO, Z, Start; 
        (* DONT_TOUCH = "TRUE" *) output reg [1:0] InsSel;
        (* DONT_TOUCH = "TRUE" *) output reg [2:0] InMuxAdd;
        (* DONT_TOUCH = "TRUE" *) output reg [3:0] OutMuxAdd, RegAdd;
        (* DONT_TOUCH = "TRUE" *) output reg [7:0] CUconst;
        (* DONT_TOUCH = "TRUE" *) output reg Busy;
        (* DONT_TOUCH = "TRUE" *) output reg WE;
        reg [3:0] state;
        wire [3:0] next_state;
        assign next_state = state + 1;
        //state logic
        always @(posedge clk or posedge reset) begin
            if ( reset ) begin
                state <= 0;
            end else begin
                case(state)
                    4'h0:      state <= Start ? next_state : state;
                    4'h8:      state <= Z ? 4'hA: next_state; //jump if zero
                    4'h9:      state <= CO ? next_state : 4'hE; //jump if not carry
                    4'hE,4'hF: state <= 0;
                    default:   state <= next_state;
                endcase
            end
        end
        //output logic
        always @(posedge clk or posedge reset) begin
            if ( reset ) begin
                {Busy,WE} = 0;
                {InsSel,CUconst,InMuxAdd,OutMuxAdd,RegAdd} = 0;
            end else begin
                case(state)
                    4'h0: {Busy,WE} = 0; //idle
                    4'h1: Busy = 1; //start           
                    4'h2: begin //input A
                        InMuxAdd    <= 3'h0; //InA
                        RegAdd      <= 4'h3;
                        WE          <= 1;
                    end
                    4'h3: begin //input B
                        InMuxAdd    <= 3'h1; //InB
                        RegAdd      <= 4'h1; //ALUinA
                    end
                    4'h4: begin //complement B
                        InMuxAdd    <= 3'h2; //CUconst
                        RegAdd      <= 4'h1; //ALUinA
                        CUconst     <= 8'hFF;
                        InsSel      <= 2'h1; //XOR 
                    end
                    4'h5: begin //write complement
                        InMuxAdd    <= 3'h3; //ALUout
                        RegAdd      <= 4'h1; //ALUinA
                    end
                    4'h6: begin //increment
                        InMuxAdd    <= 3'h2; //CUconst
                        RegAdd      <= 4'h2; //ALUinB
                        CUconst     <= 8'h01;           
                        InsSel      <= 2'h2; //ADD
                    end
                    4'h7: begin //write increment 
                        InMuxAdd    <= 3'h3; //ALUout
                        RegAdd      <= 4'h1; //ALUinA 
                    end
                    4'h8: begin //add 
                        InMuxAdd    <= 3'h4; //RegOut 
                        RegAdd      <= 4'h2; //ALUinB
                        OutMuxAdd   <= 4'h3; //InA
                        InsSel      <= 2'h2; //ADD
                    end
                    4'h9: begin end //jump if not carry
                    4'hA: begin //write result
                        InMuxAdd    <= 3'h3; //ALUout
                        RegAdd      <= 4'h1; //ALUinA
                    end
                    4'hB: begin //complement result 
                        InMuxAdd    <= 3'h2; //CUconst
                        RegAdd      <= 4'h2; //ALUinB
                        CUconst     <= 8'hFF; 
                        InsSel      <= 2'h1; //XOR  
                    end
                    4'hC: begin //write complemnt result
                        InMuxAdd    <= 3'h3; //ALUout
                        RegAdd      <= 4'h1; //ALUinB
                    end
                    4'hD: begin //increment result
                        InMuxAdd    <= 3'h2; //CUconst
                        RegAdd      <= 4'h2; //ALUinB
                        CUconst     <= 8'h01;
                        InsSel      <= 2'h2; //ADD
                    end
                    4'hE: begin //out 
                        InMuxAdd    <= 3'h3; //ALUout
                        RegAdd      <= 4'h0; //Out
                    end
                    4'hF: begin end//empty state
                endcase
            end
        end
endmodule

    