use <common.scad>
use <BOSL/constants.scad>
include <BOSL/threading.scad>

$fn = 250; 
//$fn = 50; //replace with line above for high quality render

shaftLength = 135;
shaftDiameter = 28;
threadLength = 10;
threadPitch = 2.5;

// two upper shaft sections, with wire run
for (i = [0 : 40 : 40]) {
    translate([i,0,0]) {
        difference() {
            threadedShaftSection(threadPitch, shaftDiameter-5, threadPitch, shaftDiameter-5);
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