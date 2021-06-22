use <BOSL/constants.scad>
include <BOSL/threading.scad>

$fn = 200;

/****************************************************************
* Battery module MK2
* ------------------
* Original design had too brittle joints, and snapped easily.
* Diameter of shaft was also too big. To solve these issues,
* placing 18650 battery directly in printed cylinder.
*
* Battery terminals transplanted from bought battery holders 
* to screw-on ends.
* TP4056 recharge module to be held beyond (not underneath) battery
* compartment, in support structure also glued in place.
* Joints will be superglued and use 100% infill.
*
****************************************************************/

shaftDiameter = 28;
batteryDiameter = 19;
batteryLength = 65 - 1; // 0.5mm less on each side for tension on spring terminals
batteryConnectorSpace = 6;
wireDiameter = 3;
screwThreadPitch = 2.5;

batteryModuleLength =  batteryLength + (batteryConnectorSpace * 2);
echo(batteryModuleLength+10)

// Main 18650 battery compartment, with 3mm diameter wire runs going down the side
translate([-40,0,0]) {
batteryTerminalScrew(5);
translate([0,0,5]) compartment();
translate([0,0,5+batteryModuleLength]) batteryTerminalScrew(5);
}

// Positive terminal screw-on adaptor, bolt to bore/tap. This
// has the JST SM connector sticking out, for connection to
// PCB

translate([-40,-40,0])
positiveTerminalAdaptor(plugLength=5);


// Negative terminal screw-on adaptor, bolt to bolt with space
// for on/off slide switch and TO4056 support housing.
translate([0,-40,0])
negativeTerminalAdaptor(plugLength=5);

// TO4056 support
TP4056holder();


module positiveTerminalAdaptor(plugLength) {
    terminalPlateDepth=2;
    difference() {
        union() {
            // plug with terminal glued on outside
            threaded_rod(d = batteryDiameter+4, l = plugLength, pitch = screwThreadPitch, slop=0, orient=ORIENT_Z, align=V_UP);
            // body of adaptor
            translate([0,0,plugLength]) cylinder(h=20, d=shaftDiameter);
        }
        // hollow of adaptor
        translate([0,0,terminalPlateDepth]) cylinder(h=plugLength-terminalPlateDepth, d=batteryDiameter-4);
        translate([0,0,plugLength]) cylinder(h=10, d1=batteryDiameter-4, d2=shaftDiameter - 6);
        // connection screw bore
        translate([0, 0, plugLength+10]) threaded_rod(d = shaftDiameter - 5, l = 20, pitch = screwThreadPitch, internal = true, slop = 0.35, orient=ORIENT_Z, align=V_UP);
        // hole for wires
        translate([0,0,-1]) pill(xlen=10, ylen=4, depth=4);
        // hole for positive terminal prong
        translate([0,1.5+5,-1]) pill(xlen=3, ylen=2, depth=4);
    };
}

module pill(xlen, ylen, depth) {
    translate([(ylen/2)-(xlen/2),0,0])
    linear_extrude(depth, true)
    hull() {
        circle(d=ylen);
        translate([xlen-ylen,0,0]) circle(d=ylen);
    }
}

module negativeTerminalAdaptor(plugLength) {
    terminalPlateDepth=2;
    housingLength = 35;
    hiltPlugLength=10;
    difference() {
        union() {
            // plug with terminal glued on outside
            threaded_rod(d = batteryDiameter+4, l = plugLength, pitch = screwThreadPitch, slop=0, orient=ORIENT_Z, align=V_UP);
            // body of adaptor
            translate([0,0,plugLength]) cylinder(h=housingLength, d=shaftDiameter);
            // hollow plug to connect to hilt, which will contain TO4056 housing
            translate([0, 0, plugLength+housingLength]) threaded_rod(d = shaftDiameter - 5, l = hiltPlugLength, pitch = screwThreadPitch, slop=0, orient=ORIENT_Z, align=V_UP);
        }
        // hollow of adaptor
        translate([0,0,terminalPlateDepth]) cylinder(h=plugLength-terminalPlateDepth, d=batteryDiameter-4);
        translate([0,0,plugLength]) cylinder(h=10, d1=batteryDiameter-4, d2=shaftDiameter - 9);
        translate([0,0,plugLength+10]) cylinder(h=(housingLength+hiltPlugLength-10)+1, d=shaftDiameter - 9);
        // hole for wires
        translate([0,0,-1]) pill(xlen=10, ylen=4, depth=4);
        // hole for negative terminal prong
        translate([0,1.5+5,-1]) pill(xlen=3, ylen=2, depth=4);
        
        // hole for on/off switch
        translate([7/2,-shaftDiameter/2,35])
        rotate([90,90,180]) {
            cube([20, 7, 1]);
            translate([(20-13.5)/2, 0,1]) cube([13.5, 7, 6]);
        };
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
        translate([-8.5/2,-3.5-(1.5/2),-1]) cube([8.5,3.5,3]);
        // grille
        intersection() {
            difference() {
                translate([0,0,-1]) cylinder(h=3, d=to4056Width);
                translate([-11/2,-6,-1]) cube([11,6,3]);
            }
            for (x = [0 : 1.5: holderDiameter]) {
                for (y = [0 : 1.5 : holderDiameter]) {
                    translate([-(holderDiameter/2)+x, -(holderDiameter/2) + y, -1]) cylinder(h=3,d=0.6); 
                }
            }
        }
    }
}


module compartment() {
    
    difference() {
        cylinder(h = batteryModuleLength, d = shaftDiameter);
        cylinder(h = batteryModuleLength, d = batteryDiameter);
        wireRunRadius = (batteryDiameter + wireDiameter + 1) / 2;
        for (wireRunAngle = [0:30:60]) {
            translate([wireRunRadius * cos(wireRunAngle), wireRunRadius * sin(wireRunAngle), batteryConnectorSpace]) cylinder(h = batteryLength, d = wireDiameter);
        }
        rotate([0,0,-10]) pie(angle=80, radius=wireRunRadius+(wireDiameter/2), depth=batteryConnectorSpace);
        translate([0,0,batteryConnectorSpace+batteryLength]) rotate([0,0,-10]) pie(angle=80, radius=wireRunRadius+(wireDiameter/2), depth=batteryConnectorSpace);
    }
}

module batteryTerminalScrew(length) {
    difference() {
        cylinder(h=length, d=shaftDiameter);
        // bottom bore
        translate([0, 0, -1]) threaded_rod(d = batteryDiameter+4, l = length+2, pitch = screwThreadPitch, internal = true, slop = 0.35, orient=ORIENT_Z, align=V_UP);
    }
}

// yum
module pie(angle, radius, depth) {
    rotate_extrude(angle = angle, convexity = 10) square([radius,depth]);
}