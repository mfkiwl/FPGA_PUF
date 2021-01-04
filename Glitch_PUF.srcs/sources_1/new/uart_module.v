

module uart_module(
input                           sys_clk,
input                           rst_n,
input                           uart_rx,
output                          uart_tx,
input       [127:0]            response,
input                           enable

);

parameter                        SEND_TIMES = 15;//Mhz

parameter                        CLK_FRE = 50;//Mhz
localparam                       IDLE =  0;
localparam                       SEND =  1;   //send HELLO ALINX\r\n
localparam                       WAIT =  2;   //wait 1 second and send uart received data
reg[7:0]                         tx_data;
reg[7:0]                         tx_str;
reg                              tx_data_valid;
wire                             tx_data_ready;
reg[7:0]                         tx_cnt;
wire[7:0]                        rx_data;
wire                             rx_data_valid;
wire                             rx_data_ready;
reg[3:0]                         state;

assign rx_data_ready = 1'b1;//always can receive data,
							//if HELLO ALINX\r\n is being sent, the received data is discarded

always@(posedge sys_clk or negedge rst_n)
begin
	if(rst_n == 1'b0)
	begin
		tx_data <= 8'd0;
		state <= IDLE;
		tx_cnt <= 8'd0;
		tx_data_valid <= 1'b0;
	end
	else
	case(state)
		IDLE:
		begin
            if(enable == 1'b1)
                state <= SEND;
            else
                state <= IDLE;    
        end        
		SEND:
		begin
			tx_data <= tx_str;

			if(tx_data_valid == 1'b1 && tx_data_ready == 1'b1 && tx_cnt < SEND_TIMES)//Send 12 bytes data
			begin
				tx_cnt <= tx_cnt + 8'd1; //Send data counter
			end
			else if(tx_data_valid && tx_data_ready)//last byte sent is complete
			begin
				tx_cnt <= 8'd0;
				tx_data_valid <= 1'b0;
				state <= WAIT;
			end
			else if(~tx_data_valid)
			begin
				tx_data_valid <= 1'b1;
			end
		end
		WAIT:
		begin
		    state <= IDLE;
		end
		default:
			state <= IDLE;
	endcase
end

//combinational logic
//Send "HELLO ALINX\r\n"
always@(*)
begin
    tx_str[7] = response[(tx_cnt<<3)+7];
    tx_str[6] = response[(tx_cnt<<3)+6];
    tx_str[5] = response[(tx_cnt<<3)+5];
    tx_str[4] = response[(tx_cnt<<3)+4];
    tx_str[3] = response[(tx_cnt<<3)+3];
    tx_str[2] = response[(tx_cnt<<3)+2];
    tx_str[1] = response[(tx_cnt<<3)+1];
    tx_str[0] = response[tx_cnt<<3];
end

(* DONT_TOUCH= "TRUE" *)
uart_rx#
(
	.CLK_FRE(CLK_FRE),
	.BAUD_RATE(115200)
) uart_rx_inst
(
	.clk                        (sys_clk        ),
	.rst_n                      (rst_n          ),
	.rx_data                    (rx_data        ),
	.rx_data_valid              (rx_data_valid  ),
	.rx_data_ready              (rx_data_ready  ),
	.rx_pin                     (uart_rx        )
);

(* DONT_TOUCH= "TRUE" *)
uart_tx#
(
	.CLK_FRE(CLK_FRE),
	.BAUD_RATE(115200)
) uart_tx_inst
(
	.clk                        (sys_clk        ),
	.rst_n                      (rst_n          ),
	.tx_data                    (tx_data        ),
	.tx_data_valid              (tx_data_valid  ),
	.tx_data_ready              (tx_data_ready  ),
	.tx_pin                     (uart_tx        )
);
endmodule