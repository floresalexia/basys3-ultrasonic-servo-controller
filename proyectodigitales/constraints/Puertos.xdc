## Clock 100 MHz de Basys 3
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} [get_ports clk]

## Switches
## SW0 como reset
set_property PACKAGE_PIN V17 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## SW1 como selector del display
set_property PACKAGE_PIN V16 [get_ports sw_display]
set_property IOSTANDARD LVCMOS33 [get_ports sw_display]

## LEDs
## LED0, medición en proceso
set_property PACKAGE_PIN U16 [get_ports led_medicion]
set_property IOSTANDARD LVCMOS33 [get_ports led_medicion]

## LED1, medición lista
set_property PACKAGE_PIN E19 [get_ports led_done]
set_property IOSTANDARD LVCMOS33 [get_ports led_done]

## PMOD JA
## JA1, salida trigger hacia HC-SR04
set_property PACKAGE_PIN J1 [get_ports trigger]
set_property IOSTANDARD LVCMOS33 [get_ports trigger]

## JA2, entrada echo desde HC-SR04 mediante divisor de voltaje
set_property PACKAGE_PIN L2 [get_ports echo]
set_property IOSTANDARD LVCMOS33 [get_ports echo]

## JA3, salida pwm hacia servo
set_property PACKAGE_PIN J2 [get_ports servo_pwm_out]
set_property IOSTANDARD LVCMOS33 [get_ports servo_pwm_out]

## Display de 7 segmentos
## seg(6 downto 0) = g f e d c b a
## Por eso:
## seg[0] = a, seg[1] = b, ..., seg[6] = g

set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]

set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]

set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]

set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]

set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]

set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]

set_property PACKAGE_PIN U7 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

## Ánodos del display
set_property PACKAGE_PIN U2 [get_ports {an[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]

set_property PACKAGE_PIN U4 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]

set_property PACKAGE_PIN V4 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]

set_property PACKAGE_PIN W4 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]