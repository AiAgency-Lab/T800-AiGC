module kuramoto_asic_aeg_hardcore (
    input wire clk,
    input wire rst_n,
    input wire [15:0] global_coupling_K,
    input wire [15:0] phase_in_0, phase_in_1, phase_in_2, phase_in_3, phase_in_4, phase_in_5, phase_in_6,
    output reg [15:0] phase_out_0, phase_out_1, phase_out_2, phase_out_3, phase_out_4, phase_out_5, phase_out_6
);
    // 7-Node Complex Cross-Coupled Spatial Lattice Topology (Root to Crown)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            phase_out_0 <= phase_in_0; // Root
            phase_out_1 <= phase_in_1; // Sacral
            phase_out_2 <= phase_in_2; // SolarPlexus
            phase_out_3 <= phase_in_3; // Heart
            phase_out_4 <= phase_in_4; // Throat
            phase_out_5 <= phase_in_5; // ThirdEye
            phase_out_6 <= phase_in_6; // Crown
        end else begin
            phase_out_0 <= phase_out_0 + (global_coupling_K * (phase_out_1 ^ phase_out_6));
            phase_out_1 <= phase_out_1 + (global_coupling_K * (phase_out_2 ^ phase_out_0));
            phase_out_2 <= phase_out_2 + (global_coupling_K * (phase_out_3 ^ phase_out_1));
            phase_out_3 <= phase_out_3 + (global_coupling_K * (phase_out_4 ^ phase_out_2));
            phase_out_4 <= phase_out_4 + (global_coupling_K * (phase_out_5 ^ phase_out_3));
            phase_out_5 <= phase_out_5 + (global_coupling_K * (phase_out_6 ^ phase_out_4));
            phase_out_6 <= phase_out_6 + (global_coupling_K * (phase_out_0 ^ phase_out_5));
        end
    end
endmodule
