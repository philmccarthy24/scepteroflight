use <common.scad>
use <BOSL/constants.scad>
include <BOSL/threading.scad>

$fn = 250;

/****************************************************************
* Battery module MK3
* ------------------
* 
* MK2's battery compartment wire egress is through center of battery 
* terminals.
* This is flawed due to terminal plug screw rotation moving 
* terminal spring in way of wires. 
* MK3 improves on this design by running wires through terminal
* plug screw turns, with access port on far side of terminal plug
* wall. This is tricky to align, but provides much improved access
* to power module wiring.
*
* MK1 design had too brittle joints, and snapped easily.
* Diameter of shaft also too big. MK2 solves these issues,
* by placing 18650 battery directly in printed cylindrical housing,
* with embedded wire runs to access ports just before terminals.
*
* Battery terminals transplanted from bought battery holders 
* to screw-on ends.
* TP4056 recharge module held beyond (not underneath) battery
* compartment, in support structure also glued in place.
* Joints to be superglued and use 100% infill.
*
*
****************************************************************/

shaftDiameter = 28;
batteryDiameter = 19;
batteryLength = 65 - 2; // 1mm less on each side for tension on spring terminals
batteryConnectorSpace = 6;
batteryCompartmentScrewLength = 5;
wireDiameter = 3;
screwThreadPitch = 2.5;


// Main 18650 battery compartment, with 3mm diameter wire runs going down the side
translate([-40,0,0])
batteryCompartment(length=batteryLength + (batteryConnectorSpace * 2) + (batteryCompartmentScrewLength * 2), outerDiameter=shaftDiameter, innerDiameter=batteryDiameter, terminalScrewTapLength=batteryCompartmentScrewLength, terminalScrewTapDiameter=shaftDiameter-5, terminalScrewPitch=screwThreadPitch);

// Positive terminal screw-on adaptor, bolt to bore/tap. This
// has the JST SM connector sticking out, for connection to
// PCB
translate([-40,-40,0])
positiveTerminalAdaptor();

// Negative terminal screw-on adaptor, bolt to bolt with space
// for on/off slide switch and TO4056 support housing.
translate([0,-40,0])
negativeTerminalAdaptor();

// TO4056 support
TP4056holder();


// this is the battery terminal plug, with a shaft screw added to connect
// to upper shaft sections
module positiveTerminalAdaptor() {
    
    difference() {
        union() {
            batteryTerminalPlug(length=12.5, outerDiameter=shaftDiameter, innerDiameter=batteryDiameter, terminalScrewLength=5, terminalScrewDiameter=shaftDiameter-5, terminalScrewPitch=screwThreadPitch, terminalPlateDepth=2);
            translate([0,0,12.5]) cylinder(h=10, d=shaftDiameter);
        }
        // hollow widening to upper shaft screw tap
        translate([0,0,5]) cylinder(h=5+screwThreadPitch, d1=(shaftDiameter-5)-screwThreadPitch*2,d2=shaftDiameter-5);
        // connection screw tap
        translate([0, 0, 12.5]) threaded_rod(d = shaftDiameter - 5, l = 11, pitch = screwThreadPitch, internal = true, slop = 0.25, orient=ORIENT_Z, align=V_UP);
    };
}

// this is the battery terminal plug, with housing inside a plug added for
// on off switch and TP4056 module
module negativeTerminalAdaptor() {
    
    accessPortRadius = ((batteryDiameter + 4) / 2) + 1.5;
    
    difference() {
        union() {
            // plug with terminal glued on outside
            batteryTerminalPlug(length=12.5, outerDiameter=shaftDiameter, innerDiameter=batteryDiameter, terminalScrewLength=5, terminalScrewDiameter=shaftDiameter-5, terminalScrewPitch=screwThreadPitch, terminalPlateDepth=2);
            // body of adaptor
            translate([0,0,12.5]) cylinder(h=30, d=shaftDiameter);
            // hollow plug to connect to hilt, which will contain TO4056 housing
            translate([0, 0, 40]) threaded_rod(d = shaftDiameter - 5, l = 10, pitch = screwThreadPitch, slop=0, orient=ORIENT_Z, align=V_UP);
        }
        // hollow of adaptor
        translate([0,0,5+screwThreadPitch]) cylinder(h=46, d=batteryDiameter);
        
        // hole for on/off switch
        rotate([0,0,120])
        translate([7/2,-shaftDiameter/2,30])
        rotate([90,90,180]) {
            cube([20, 7, 1]);
            translate([(20-13.5)/2, 0,1]) cube([13.5, 7, 6]);
        };
        
        // ramp to facilitate pushing wires through
        translate([0,0,12.5])
        intersection() {
            cylinder(h=10, r1=accessPortRadius, r2=batteryDiameter/2);
            rotate([0,0,170]) pie(angle=80, radius=accessPortRadius, depth=10);
        }
    };
}

module TP4056holder() {
    coverPlateDepth=1;
    to4056Width=16.5;
    holderLength = 30;
    holderDiameter = shaftDiameter - 9.35;
    
    difference() {
        // main volume
        cylinder(h=holderLength, d=holderDiameter);
        // hollow
        translate([0,0,coverPlateDepth]) cylinder(h=holderLength, d=to4056Width);
        // trailing housing
        translate([-holderDiameter/2,0,10]) cube([holderDiameter,holderDiameter/2,holderLength]);
        // grooves for 4056
        translate([-17.3/2, -1.5/2, coverPlateDepth]) cube([17.3, 1.5, holderLength]);
        // microusb opening
        translate([-8.5/2,-4,-1]) cube([8.5,3.5,3]);
        // grille
        intersection() {
            difference() {
                translate([0,0,-1]) cylinder(h=3, d=to4056Width);
                translate([-11/2,-5,-1]) cube([11,6,3]);
            }
            rotate([0,0,45]) {
                for (x = [0:2:holderDiameter]) {
                    translate([x-holderDiameter/2, -holderDiameter/2, -1]) cube([0.75, holderDiameter, 3]);
                }
            }
        }
    }
}

module batteryTerminalPlug(length, outerDiameter, innerDiameter, terminalScrewLength, terminalScrewDiameter, terminalScrewPitch, terminalPlateDepth) {
    difference() {
        union() {
            // screw with terminal seated on outer face.
            threaded_rod(d = terminalScrewDiameter, l = terminalScrewLength, pitch = terminalScrewPitch, slop=0, orient=ORIENT_Z, align=V_UP);
            // body of adaptor
            translate([0,0,terminalScrewLength]) cylinder(h=length-terminalScrewLength, d=outerDiameter);
        }
        // hollow part of screw
        translate([0,0,terminalPlateDepth]) cylinder(h=terminalScrewLength-terminalPlateDepth, d=terminalScrewDiameter-(terminalScrewPitch*2));
        // widening to main hollow area
        translate([0,0,terminalScrewLength]) cylinder(h=terminalScrewPitch, d1=terminalScrewDiameter-(terminalScrewPitch*2), d2=innerDiameter);
        // main hollow area
        translate([0,0,terminalScrewLength+terminalScrewPitch]) cylinder(h=length-(terminalScrewLength+terminalScrewPitch)+1, d=innerDiameter);
        // hole for terminal prong
        translate([0,7.5,-1]) scale([3,2,1]) cylinder(h=4, d=1);
        // wire runs to access port
        wireDiameter=3;
        wireRunRadius=(innerDiameter + wireDiameter + 1) / 2;
        rotate([0,0,180])
        translate([0,0,-1]) wireRuns(numWires=3, wireRunRadius=wireRunRadius, wireDiameter=wireDiameter, runOffsetAngle=30, runLength=terminalScrewLength+5+1);
        // access port
        translate([0,0,terminalScrewLength+terminalScrewPitch]) rotate([0,0,170]) pie(angle=80, radius=wireRunRadius+(wireDiameter/2), depth=length-(terminalScrewLength+terminalScrewPitch));
    };
}

module batteryCompartment(length, outerDiameter, innerDiameter, terminalScrewTapLength, terminalScrewTapDiameter, terminalScrewPitch) {
    difference() {
        // main volume
        cylinder(h=length, d=outerDiameter);
        // hollow interior
        translate([0,0,-1]) cylinder(h=length+2, d=innerDiameter);
        // bottom screw runs up in z counter-clockwise, with part oriented
        // z up.
        // bottom screw tap, with rotation compensation from trial and error
        // rotate([0,0,240]) - old value
        rotate([0,0,150]) translate([0,0,-terminalScrewPitch]) threaded_rod(d=terminalScrewTapDiameter, l = terminalScrewTapLength+terminalScrewPitch, pitch = terminalScrewPitch, internal = true, slop = 0.25, orient=ORIENT_Z, align=V_UP);
        // top screw tap, with rotation compensation from trial and error
        //rotate([0,0,150]) - old value
        rotate([0,0,180]) translate([0,0,length-terminalScrewTapLength]) threaded_rod(d=terminalScrewTapDiameter, l = terminalScrewTapLength+1, pitch = terminalScrewPitch, internal = true, slop = 0.25, orient=ORIENT_Z, align=V_UP);
        // runs
        wireDiameter=3;
        rotate([0,0,180]) translate([0,0,-1]) wireRuns(numWires=3, wireRunRadius=(innerDiameter + wireDiameter + 1) / 2, wireDiameter=wireDiameter, runOffsetAngle=30, runLength=length+2); 
    }
}

// creates geometry for differencing
module wireRuns(numWires, wireRunRadius, wireDiameter, runOffsetAngle, runLength) {
    for (wireNum = [0:numWires-1]) {
        wireRunAngle = wireNum*runOffsetAngle;
        translate([wireRunRadius * cos(wireRunAngle), wireRunRadius * sin(wireRunAngle),0]) cylinder(h = runLength, d = wireDiameter);
    }
}