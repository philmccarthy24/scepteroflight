use <common.scad>
use <BOSL/constants.scad>
include <BOSL/threading.scad>

$fn = 250; 
//$fn = 50; // replace with the line above for high quality render

shaftDiameter = 28;
threadDiameter = shaftDiameter - 5;
threadHoleAdjustment = 0.35; 
threadLength = 10;
threadPitch = 2.5;

difference() {
    hilt();
    translate([0,0,37]) make_ring(17, 3) rotate([4,0,0]) rotate([0,-90,-90]) tear_gem_seat_outline(5,10,4);
}
translate([0,0,81]) make_ring(18, 7) sphere(r=2);
translate([0,0,37]) make_ring(17, 3) rotate([4,0,0]) rotate([0,-90,-90]) tear_gem_seat(5,10,4);


module hilt() {
    profile="assets/SOL_hilt_profile.svg";
    render() {
        difference() {       
            translate([0,0,110]) rotate([180,0,0]) rotate_extrude(angle=360, convexity=3) import(profile);
            translate([0, 0, -1]) threaded_rod(d = threadDiameter, l = threadLength+1, pitch = threadPitch, internal = true, slop = threadHoleAdjustment, orient=ORIENT_Z, align=V_UP);
        }
    }
}