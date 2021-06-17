use <common.scad>
use <BOSL/constants.scad>
include <BOSL/threading.scad>

//$fn = 250; replace with line below for high quality render
$fn = 50;

threadDiameter = 32;
shaftDiameter = 32 + 4;
threadHoleAdjustment = 0.35; 
threadLength = 10;
threadPitch = 2;

difference() {
    hilt();
    translate([0,0,30]) make_ring(20, 3) rotate([7,0,0]) rotate([0,-90,-90]) tear_gem_seat_outline(6,12,4);
}
translate([0,0,71]) make_ring(20, 7) sphere(r=2);
translate([0,0,30]) make_ring(20, 3) rotate([7,0,0]) rotate([0,-90,-90]) tear_gem_seat(6,12,4);


module hilt() {
    profile="assets/SOFB_hilt_profile.svg";
    render() {
        difference() {       
            translate([0,0,100]) rotate([180,0,0]) rotate_extrude(angle=360, convexity=3) import(profile);
            translate([0, 0, -1]) threaded_rod(d = threadDiameter, l = threadLength+1, pitch = threadPitch, internal = true, slop = threadHoleAdjustment, orient=ORIENT_Z, align=V_UP);
        }
    }
}