module tb();

reg clk = 0;
reg reset;
reg vai_manual;
reg vai_auto;
reg ligar_caldeira;
wire caldeira;

reg [2:0] file_data [0:19];

sistema s(
    .clk(clk),
    .reset(reset),
    .vai_manual(vai_manual),
    .vai_auto(vai_auto),
    .ligar_caldeira(ligar_caldeira),
    .caldeira(caldeira)
);

always #1 clk = ~clk;

integer i;
initial begin
    // Teste 1: Modo Manual
    $dumpfile("saida.vcd");
    $dumpvars(0, tb);
    $readmemb("teste.txt", file_data);
    $monitor("vai_manual=%b vai_auto=%b ligar_caldeira=%b caldeira=%b", vai_manual, vai_auto, ligar_caldeira, caldeira);

    reset = 1;
    vai_manual = 0;
    vai_auto = 0;
    ligar_caldeira = 0;
    #2;

    reset = 0;
    #2;

    for (i=0; i<20; i=i+1) begin
        vai_manual = file_data[i][2];
        vai_auto = file_data[i][1];
        ligar_caldeira = file_data[i][0];
        #2;
    end

    $finish;
end

endmodule