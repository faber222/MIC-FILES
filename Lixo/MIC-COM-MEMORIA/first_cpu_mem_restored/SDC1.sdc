create_clock -name clk -period 50MHz [get_ports {clk}]
derive_pll_clocks
derive_clock_uncertainty