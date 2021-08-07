# Scepter of Light
## 3D printable prop

*Phil McCarthy, August 2021*


### Assembly instructions
Get the PCB fabricated from a board house (I used [PCBWay](https://www.pcbway.com), they seemed good - YMMV), and wait two weeks for them to arrive. There's typically a 5 board minimum order.

Print the STL files. See the OpenSCAD files for printing tips. I used [gold filament](https://shop.prusa3d.com/en/prusament/958-prusament-petg-yellow-gold-transparent-1kg.html) for the scepter body parts, and [transparent blue](https://www.amazon.co.uk/gp/product/B07T7MBGVL/ref=ppx_yo_dt_b_search_asin_title?ie=UTF8&psc=1) for the gems. You should have the following printed parts:
- A: LED stalk (blue)
- B: Thistle
- C: Left head
- D: Right head
- E: 3 wings
- F: Top gem curls (gold)
- G: Top gem
- H: 18650 battery case
- I: TP4056 sleeve
- J: Neg terminal screw with switch mount
- K: Pos terminal screw
- L: 2 shaft sections
- M: Hilt
- N: 3 hilt gems
- O: 3 head gems

First, build the LED stalk (A). Take 3 of the LEDs, twist the short leads (cathodes) together, and solder on a black wire (long enough to reach the PCB bay below). Solder 3 wires to each of the anodes. Thread the LED wires through the holes at the top of the LED stalk, until the LEDs sit flush with the top. At the base of the stalk, cut, bare and twist the three anode wires together, and solder to them a single positive wire. Put a JST-XH plug on the end of the two stalk wires (note polarity of pcb header).
Screw the stalk into the interior of the Thistle (B). 

Next the scepter head. Use a soldering iron set at 300 degrees C to heat the brass inserts into the corresponding holes in the left head part (C); M2 inserts in top right and bottom left holes, M3 inserts in each PCB standoff hole. Use a small piece of flat metal to push the inserts in the last mm or so, so they sit flush.

Take a PCB and thread the resistors and shottky diode (cathode on "K" label) through the corresponding holes (see ohm numbers on board for where resistors go). Turn over and solder (at 350 degrees C) to the board. Trim the leads with wire cutters.
Solder on the ULN2003 chip, and all the pin headers. Use a **vertical** instead of right angle 2 pin JST header for the vibration motor connector, due to lack of space in the enclosure. Put a 2 pin vertical JST header on the center LED footprint, facing up, so a cable can connect it the the LED hole on the right part (D).
Thread 2 LEDs through the underside of the PCB at the corresponding LED footprints at the bottom of the board - long anode lead towards the PCB bottom (where the power connector is). Place the PCB in the enclosure bay, so that the 2 LEDs just poke out of the bottom gem seat holes. Solder them in position. Screw M3 nylon screws into the standoffs to secure the PCB in place.

Solder male pin headers onto the Teensy MCU, MAX98357A amplifier module (also solder included terminal block) and GY-521 gyro module. Solder the header onto the GY-521 **front** rather than back (the PCB design has a mistake where the GY-521 needs to be mounted upside-down).

