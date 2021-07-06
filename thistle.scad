use <common.scad>
use <BOSL/constants.scad>
include <BOSL/threading.scad>

$fn=250;
//$fn=50; // uncomment the line above for high quality render

difference() {
    union() {
        thistle();
        translate([0, 0, 12]) threaded_rod(d = 20, l = 4, pitch = 1.5, slop=0, orient=ORIENT_Z, align=V_UP);
    }
    
    // triangular ring cut-outs
    translate([0,0,32.5]) {
        make_ring(23, 5) rotate([-15,0,0]) rotate([90,0,0]) rotate([0,0,150]) cylinder(h=20, d=8, $fn=3);
        rotate([0,0,36]) make_ring(23, 5) rotate([-15,0,0]) translate([0,-15,-2]) rotate([270,0,0]) rotate([0,0,150]) cylinder(h=20, d=8, $fn=3);
    }
    
    // central hole for led stalk to poke through
    cylinder(h=40, d=15);
}
// fill in cut-outs near clips
intersection() {
    thistle();
    translate([-30,-5,0]) cube([60,10,40]);
}
// curl fastening clips
translate([17,0,29]) rotate([0,38,0]) curve_fastener();
rotate([0,0,180]) translate([17,0,29]) rotate([0,38,0]) curve_fastener();

module thistle() {
    difference() {
        union() {
            rotate_extrude(angle=360, convexity=10) import("assets/SOL_thistle_profile.svg");
            translate([0,0,19.5]) make_ring(23, 10) sphere(d=6);
        };
        
        // bayonet fitting
        translate([0,0,12]) cylinder(h=17, d=26);
        translate([0,0,28]) cylinder(h=10, d1=25, d2=35.5);
        
        translate([0,0,23.25]) rotate_extrude(angle=360) translate([25/2,0,0]) circle(d=6.3);
        // bayonet access tubes
        translate([0,0,22.5]) make_ring(12.5, 4) cylinder(h=20, d=7);
        
        // central hole for led stalk to poke through
        cylinder(h=40, d=15);
        
        // bottom bore/tap
    translate([0,0,-0.1]) threaded_rod(d=25, l=10, pitch=2.5, internal = true, slop = 0.25, orient=ORIENT_Z, align=V_UP);
    }
}

