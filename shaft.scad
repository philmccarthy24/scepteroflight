use <common.scad>
use <BOSL/constants.scad>
include <BOSL/threading.scad>

$fn = 250; 
//$fn = 50; //replace with line above for high quality render

batteryModuleLength = 80;
batteryModuleHeight = 23;
batteryModuleWidth = 22;
shaftLength = 135;
shaftDiameter = 36;
threadLength = 10;

// hilt connection shaft, with wire run and battery compartment
difference() {
    threadedShaftSection(2, 32, 3.5, 30);
    
    // the battery compartment
    translate([0,0,(shaftLength+threadLength-batteryModuleLength)]) centred_xy_cube([batteryModuleWidth,batteryModuleHeight,batteryModuleLength+1]);
    // some additional cylindrical room top/bottom
    translate([0,5,(shaftLength+threadLength-batteryModuleLength)]) cylinder(h=batteryModuleLength+1, d=18.5);
    translate([0,-5,(shaftLength+threadLength-batteryModuleLength)]) cylinder(h=batteryModuleLength+1, d=19);
    
    // thread cut-out for micro usb connector
    translate([-batteryModuleWidth/2, -(batteryModuleHeight/2)-10, (shaftLength+threadLength)-10]) cube([batteryModuleWidth,10,11]);
    
    // conical cable run
    translate([0,0,40]) scale([1,1.35,1]) cylinder(h=(shaftLength+threadLength-batteryModuleLength)-40, r1=7.5, r2=11);
    translate([0,0,-1]) cylinder(h=40+1, d=15);
}

// two upper shaft sections, with wire run
for (i = [40 : 40 : 80]) {
    translate([i,0,0]) {
        difference() {
            threadedShaftSection(3.5, 30, 3.5, 30);
            translate([0,0,-1]) cylinder(h=147, d=15);
        }
    }
}

module threadedShaftSection(topScrewThreadPitch, topScrewThreadDiameter, bottomBoreThreadPitch, bottomBoreThreadDiameter) {
    boreHoleAdjustment = 0.35; // for thread wiggle room
    
    difference() {
        // shaft and top screw
        union() {
            cylinder(d = shaftDiameter, h = shaftLength);
            translate([0, 0, shaftLength - 0.01]) threaded_rod(d = topScrewThreadDiameter, l = threadLength-1, pitch = topScrewThreadPitch, slop=0, orient=ORIENT_Z, align=V_UP);
        };
        // bottom bore
        translate([0, 0, -1]) threaded_rod(d = bottomBoreThreadDiameter, l = threadLength+1, pitch = bottomBoreThreadPitch, internal = true, slop = boreHoleAdjustment, orient=ORIENT_Z, align=V_UP);
    };

}