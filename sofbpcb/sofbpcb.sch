EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Scepter PCB"
Date "2021-07-14"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L teensy:Teensy4.1 U1
U 1 1 60ED74C3
P 3800 3550
F 0 "U1" H 3800 6115 50  0000 C CNN
F 1 "Teensy4.1" H 3800 6024 50  0000 C CNN
F 2 "" H 3400 3950 50  0001 C CNN
F 3 "" H 3400 3950 50  0001 C CNN
	1    3800 3550
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Small R1
U 1 1 60EECD11
P 7150 2400
F 0 "R1" H 7209 2446 50  0000 L CNN
F 1 "68" V 7150 2350 50  0000 L CNN
F 2 "" H 7150 2400 50  0001 C CNN
F 3 "~" H 7150 2400 50  0001 C CNN
	1    7150 2400
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R6
U 1 1 60EECF23
P 7350 2400
F 0 "R6" H 7409 2446 50  0000 L CNN
F 1 "68" V 7350 2350 50  0000 L CNN
F 2 "" H 7350 2400 50  0001 C CNN
F 3 "~" H 7350 2400 50  0001 C CNN
	1    7350 2400
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R7
U 1 1 60EED1C5
P 7550 2400
F 0 "R7" H 7609 2446 50  0000 L CNN
F 1 "68" V 7550 2350 50  0000 L CNN
F 2 "" H 7550 2400 50  0001 C CNN
F 3 "~" H 7550 2400 50  0001 C CNN
	1    7550 2400
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R2
U 1 1 60EED344
P 7200 3550
F 0 "R2" H 7259 3596 50  0000 L CNN
F 1 "68" V 7200 3500 50  0000 L CNN
F 2 "" H 7200 3550 50  0001 C CNN
F 3 "~" H 7200 3550 50  0001 C CNN
	1    7200 3550
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R3
U 1 1 60EED47F
P 7200 3850
F 0 "R3" H 7259 3896 50  0000 L CNN
F 1 "68" V 7200 3800 50  0000 L CNN
F 2 "" H 7200 3850 50  0001 C CNN
F 3 "~" H 7200 3850 50  0001 C CNN
	1    7200 3850
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R4
U 1 1 60EED6D8
P 7200 4150
F 0 "R4" H 7259 4196 50  0000 L CNN
F 1 "68" V 7200 4100 50  0000 L CNN
F 2 "" H 7200 4150 50  0001 C CNN
F 3 "~" H 7200 4150 50  0001 C CNN
	1    7200 4150
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R5
U 1 1 60EED832
P 7200 4600
F 0 "R5" H 7259 4646 50  0000 L CNN
F 1 "15" V 7200 4550 50  0000 L CNN
F 2 "" H 7200 4600 50  0001 C CNN
F 3 "~" H 7200 4600 50  0001 C CNN
	1    7200 4600
	0    1    1    0   
$EndComp
$Comp
L Transistor_Array:ULN2003 U2
U 1 1 60F04ADB
P 5950 3600
F 0 "U2" H 5950 4267 50  0000 C CNN
F 1 "ULN2003" H 5950 4176 50  0000 C CNN
F 2 "" H 6000 3050 50  0001 L CNN
F 3 "http://www.ti.com/lit/ds/symlink/uln2003a.pdf" H 6050 3400 50  0001 C CNN
	1    5950 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 3400 4900 3400
Wire Wire Line
	4900 3500 5550 3500
Wire Wire Line
	4900 3600 5550 3600
Wire Wire Line
	4900 3700 5550 3700
Wire Wire Line
	4900 3800 5550 3800
$Comp
L power:+5V #PWR04
U 1 1 60F0E30E
P 4750 6650
F 0 "#PWR04" H 4750 6500 50  0001 C CNN
F 1 "+5V" H 4765 6823 50  0000 C CNN
F 2 "" H 4750 6650 50  0001 C CNN
F 3 "" H 4750 6650 50  0001 C CNN
	1    4750 6650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 6650 5100 6650
Wire Wire Line
	5100 6650 5100 6450
$Comp
L power:GND #PWR06
U 1 1 60F1268D
P 6600 6600
F 0 "#PWR06" H 6600 6350 50  0001 C CNN
F 1 "GND" H 6605 6427 50  0000 C CNN
F 2 "" H 6600 6600 50  0001 C CNN
F 3 "" H 6600 6600 50  0001 C CNN
	1    6600 6600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 6600 6600 6450
Wire Wire Line
	5100 6450 5500 6450
$Comp
L Device:D_Schottky D1
U 1 1 60F14A12
P 2100 6050
F 0 "D1" V 2054 6130 50  0000 L CNN
F 1 "D_Schottky" V 2145 6130 50  0000 L CNN
F 2 "" H 2100 6050 50  0001 C CNN
F 3 "~" H 2100 6050 50  0001 C CNN
	1    2100 6050
	0    1    1    0   
$EndComp
Wire Wire Line
	2100 6000 2100 6200
Wire Wire Line
	5100 6300 5100 6450
Connection ~ 5100 6450
$Comp
L Connector:Conn_01x02_Male J3
U 1 1 60F0FC2F
P 5500 6650
F 0 "J3" V 5654 6462 50  0000 R CNN
F 1 "Conn_01x02_Male" V 5563 6462 50  0000 R CNN
F 2 "" H 5500 6650 50  0001 C CNN
F 3 "~" H 5500 6650 50  0001 C CNN
	1    5500 6650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6600 6450 5600 6450
$Comp
L power:GND #PWR02
U 1 1 60F1AFCF
P 1900 5600
F 0 "#PWR02" H 1900 5350 50  0001 C CNN
F 1 "GND" H 1905 5427 50  0000 C CNN
F 2 "" H 1900 5600 50  0001 C CNN
F 3 "" H 1900 5600 50  0001 C CNN
	1    1900 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 5600 2200 5600
Wire Wire Line
	1850 5150 2300 5150
Wire Wire Line
	2300 5150 2300 5500
Wire Wire Line
	2300 5500 2700 5500
Text Label 1950 5150 0    50   ~ 0
VCC
Wire Wire Line
	1850 5050 2200 5050
Wire Wire Line
	2200 5050 2200 5600
Connection ~ 2200 5600
Wire Wire Line
	2200 5600 2700 5600
Text Label 1950 5050 0    50   ~ 0
GND
$Comp
L Connector_Generic:Conn_01x08 J2
U 1 1 60F168A9
P 1650 4850
F 0 "J2" H 1568 4225 50  0000 C CNN
F 1 "MPU6050_hdr" H 1568 4316 50  0000 C CNN
F 2 "" H 1650 4850 50  0001 C CNN
F 3 "~" H 1650 4850 50  0001 C CNN
	1    1650 4850
	-1   0    0    1   
$EndComp
Wire Wire Line
	1850 4950 2450 4950
Wire Wire Line
	2450 4950 2450 5000
Wire Wire Line
	2450 5000 2700 5000
Text Label 1950 4950 0    50   ~ 0
SCL
Wire Wire Line
	1850 4850 2550 4850
Wire Wire Line
	2550 4850 2550 4900
Wire Wire Line
	2550 4900 2700 4900
Text Label 1950 4850 0    50   ~ 0
SDA
$Comp
L Connector_Generic:Conn_01x07 J1
U 1 1 60F2257F
P 1500 3500
F 0 "J1" H 1418 2975 50  0000 C CNN
F 1 "MAX98357A_hdr" H 1418 3066 50  0000 C CNN
F 2 "" H 1500 3500 50  0001 C CNN
F 3 "~" H 1500 3500 50  0001 C CNN
	1    1500 3500
	-1   0    0    1   
$EndComp
Wire Wire Line
	1700 3800 2350 3800
Wire Wire Line
	2350 3800 2350 5100
Wire Wire Line
	2350 5100 2700 5100
Text Label 1750 3800 0    50   ~ 0
LRC
Wire Wire Line
	1700 3700 2400 3700
Wire Wire Line
	2400 3700 2400 5200
Wire Wire Line
	2400 5200 2700 5200
Text Label 1750 3700 0    50   ~ 0
BCLK
Wire Wire Line
	1700 3600 2350 3600
Wire Wire Line
	2350 3600 2350 1900
Wire Wire Line
	2350 1900 5250 1900
Wire Wire Line
	5250 1900 5250 4900
Wire Wire Line
	5250 4900 4900 4900
Text Label 1750 3600 0    50   ~ 0
DIN
$Comp
L power:GND #PWR03
U 1 1 60F2895D
P 2100 3200
F 0 "#PWR03" H 2100 2950 50  0001 C CNN
F 1 "GND" H 2105 3027 50  0000 C CNN
F 2 "" H 2100 3200 50  0001 C CNN
F 3 "" H 2100 3200 50  0001 C CNN
	1    2100 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 3500 1850 3500
Wire Wire Line
	1850 3500 1850 3200
Wire Wire Line
	1850 3200 1700 3200
$Comp
L power:+5V #PWR01
U 1 1 60F2A5B9
P 1850 2750
F 0 "#PWR01" H 1850 2600 50  0001 C CNN
F 1 "+5V" H 1865 2923 50  0000 C CNN
F 2 "" H 1850 2750 50  0001 C CNN
F 3 "" H 1850 2750 50  0001 C CNN
	1    1850 2750
	1    0    0    -1  
$EndComp
Text Label 1750 3500 0    50   ~ 0
GAIN
NoConn ~ 1700 3400
Wire Wire Line
	1700 3300 1950 3300
Wire Wire Line
	1950 3300 1950 3200
Wire Wire Line
	1950 3200 2100 3200
Wire Wire Line
	1850 3200 1850 2750
Connection ~ 1850 3200
Text Label 1750 3200 0    50   ~ 0
VIN
Text Label 1750 3300 0    50   ~ 0
GND
$Comp
L Connector_Generic:Conn_01x04 J4
U 1 1 60F2FA30
P 7150 1550
F 0 "J4" V 7114 1262 50  0000 R CNN
F 1 "LEDStalk_hdr" V 7023 1262 50  0000 R CNN
F 2 "" H 7150 1550 50  0001 C CNN
F 3 "~" H 7150 1550 50  0001 C CNN
	1    7150 1550
	0    -1   -1   0   
$EndComp
NoConn ~ 1850 4450
NoConn ~ 1850 4550
NoConn ~ 1850 4650
NoConn ~ 1850 4750
Wire Wire Line
	7150 2750 7350 2750
Wire Wire Line
	7350 2750 7350 3400
Wire Wire Line
	7350 3400 6350 3400
Connection ~ 7350 2750
Wire Wire Line
	7550 2750 7350 2750
$Comp
L power:+5V #PWR07
U 1 1 60F12646
P 6650 2850
F 0 "#PWR07" H 6650 2700 50  0001 C CNN
F 1 "+5V" H 6665 3023 50  0000 C CNN
F 2 "" H 6650 2850 50  0001 C CNN
F 3 "" H 6650 2850 50  0001 C CNN
	1    6650 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	7050 1750 7050 3200
Wire Wire Line
	7050 3200 6650 3200
Wire Wire Line
	6650 2850 6650 3200
Connection ~ 6650 3200
Wire Wire Line
	6650 3200 6350 3200
$Comp
L Device:LED D2
U 1 1 60F192C6
P 7750 3550
F 0 "D2" H 7743 3767 50  0000 C CNN
F 1 "LED" H 7743 3676 50  0000 C CNN
F 2 "" H 7750 3550 50  0001 C CNN
F 3 "~" H 7750 3550 50  0001 C CNN
	1    7750 3550
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D3
U 1 1 60F19C5F
P 7750 3850
F 0 "D3" H 7743 4067 50  0000 C CNN
F 1 "LED" H 7743 3976 50  0000 C CNN
F 2 "" H 7750 3850 50  0001 C CNN
F 3 "~" H 7750 3850 50  0001 C CNN
	1    7750 3850
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D4
U 1 1 60F1A0E4
P 7750 4150
F 0 "D4" H 7743 4367 50  0000 C CNN
F 1 "LED" H 7743 4276 50  0000 C CNN
F 2 "" H 7750 4150 50  0001 C CNN
F 3 "~" H 7750 4150 50  0001 C CNN
	1    7750 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	7050 3200 7900 3200
Wire Wire Line
	7900 3200 7900 3550
Connection ~ 7050 3200
Connection ~ 7900 3550
Wire Wire Line
	7900 3550 7900 3850
Connection ~ 7900 3850
Wire Wire Line
	7900 3850 7900 4150
Wire Wire Line
	7600 3550 7300 3550
Wire Wire Line
	7600 3850 7300 3850
Wire Wire Line
	7600 4150 7300 4150
Wire Wire Line
	7100 3550 6850 3550
Wire Wire Line
	6850 3550 6850 3500
Wire Wire Line
	6850 3500 6350 3500
Wire Wire Line
	7100 3850 6750 3850
Wire Wire Line
	6750 3850 6750 3600
Wire Wire Line
	6750 3600 6350 3600
Wire Wire Line
	7100 4150 6650 4150
Wire Wire Line
	6650 4150 6650 3700
Wire Wire Line
	6650 3700 6350 3700
$Comp
L power:GND #PWR05
U 1 1 60F2644B
P 5950 4350
F 0 "#PWR05" H 5950 4100 50  0001 C CNN
F 1 "GND" H 5955 4177 50  0000 C CNN
F 2 "" H 5950 4350 50  0001 C CNN
F 3 "" H 5950 4350 50  0001 C CNN
	1    5950 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 4200 5950 4350
$Comp
L Connector_Generic:Conn_01x02 J5
U 1 1 60F29411
P 7900 4800
F 0 "J5" V 7772 4880 50  0000 L CNN
F 1 "VibrationMotor_hdr" V 7863 4880 50  0000 L CNN
F 2 "" H 7900 4800 50  0001 C CNN
F 3 "~" H 7900 4800 50  0001 C CNN
	1    7900 4800
	0    1    1    0   
$EndComp
Wire Wire Line
	7900 4150 7900 4600
Connection ~ 7900 4150
Wire Wire Line
	7300 4600 7800 4600
Wire Wire Line
	7100 4600 6550 4600
Wire Wire Line
	6550 4600 6550 3800
Wire Wire Line
	6550 3800 6350 3800
Text Label 7050 2050 1    50   ~ 0
ANODES
Wire Wire Line
	7150 2500 7150 2750
Wire Wire Line
	7150 1750 7150 2300
Text Label 7150 2100 1    50   ~ 0
Led1_Cthd
Wire Wire Line
	7350 2500 7350 2750
Wire Wire Line
	7550 2500 7550 2750
Wire Wire Line
	7250 1750 7250 2200
Wire Wire Line
	7250 2200 7350 2200
Wire Wire Line
	7350 2200 7350 2300
Text Label 7250 2100 1    50   ~ 0
Led2_Cthd
Wire Wire Line
	7350 1750 7350 2150
Wire Wire Line
	7350 2150 7550 2150
Wire Wire Line
	7550 2150 7550 2300
Text Label 7350 2100 1    50   ~ 0
Led3_Cthd
Text Label 7900 4650 0    50   ~ 0
+
Text Label 7750 4650 0    50   ~ 0
-
Text Label 6350 3400 0    50   ~ 0
LEDstalk
Text Label 6350 3500 0    50   ~ 0
GemLed1
Text Label 6350 3600 0    50   ~ 0
GemLed2
Text Label 6350 3700 0    50   ~ 0
GemLed3
Text Label 6350 3800 0    50   ~ 0
VibMtr
NoConn ~ 5550 3900
NoConn ~ 5550 4000
NoConn ~ 6350 3900
NoConn ~ 6350 4000
NoConn ~ 2700 5850
NoConn ~ 2700 5400
NoConn ~ 2700 5300
NoConn ~ 4900 5700
NoConn ~ 4900 5600
NoConn ~ 4900 5500
NoConn ~ 4900 5400
NoConn ~ 4900 5300
NoConn ~ 4900 5200
NoConn ~ 4900 5100
NoConn ~ 4900 5000
NoConn ~ 4900 4800
NoConn ~ 4900 4700
NoConn ~ 4900 4600
NoConn ~ 4900 4500
NoConn ~ 4900 4400
NoConn ~ 4900 4300
NoConn ~ 4900 4200
NoConn ~ 4900 4100
NoConn ~ 4900 4000
NoConn ~ 4900 3900
NoConn ~ 2700 4800
NoConn ~ 2700 4700
NoConn ~ 2700 4600
NoConn ~ 2700 4500
NoConn ~ 2700 4400
NoConn ~ 2700 4300
NoConn ~ 2700 4200
NoConn ~ 2700 4100
NoConn ~ 2700 4000
NoConn ~ 2700 3900
NoConn ~ 2700 3800
NoConn ~ 2700 3700
NoConn ~ 2700 3600
NoConn ~ 2700 3500
NoConn ~ 2700 3400
NoConn ~ 2700 3150
NoConn ~ 2700 3050
NoConn ~ 2700 2950
NoConn ~ 2700 2850
NoConn ~ 2700 2750
NoConn ~ 2700 2650
NoConn ~ 4900 3200
NoConn ~ 4900 3100
NoConn ~ 4900 2950
NoConn ~ 4900 2850
NoConn ~ 4900 2750
NoConn ~ 4900 2650
NoConn ~ 4900 2550
NoConn ~ 3500 2250
NoConn ~ 3650 2250
NoConn ~ 3800 2250
NoConn ~ 3950 2250
NoConn ~ 4100 2250
Wire Wire Line
	2100 5900 2100 5700
Wire Wire Line
	2100 5700 2700 5700
Wire Wire Line
	5100 6300 2100 6300
Wire Wire Line
	2100 6300 2100 6200
Connection ~ 2100 6200
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 60FD14CB
P 5500 6450
F 0 "#FLG0101" H 5500 6525 50  0001 C CNN
F 1 "PWR_FLAG" H 5500 6623 50  0000 C CNN
F 2 "" H 5500 6450 50  0001 C CNN
F 3 "~" H 5500 6450 50  0001 C CNN
	1    5500 6450
	1    0    0    -1  
$EndComp
Connection ~ 5500 6450
Wire Wire Line
	4900 3400 5550 3400
Connection ~ 4900 3400
$EndSCHEMATC
