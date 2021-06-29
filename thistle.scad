use <common.scad>
use <BOSL/constants.scad>
include <BOSL/threading.scad>

//$fn=250;
$fn=50; // uncomment the line above for high quality render

difference() {
    union() {
        rotate_extrude(angle=360, convexity=10) import("assets/SOL_thistle_profile.svg");
        translate([0,0,19.5]) make_ring(23, 10) sphere(d=6);
    };
    // triangular ring cut-outs
    translate([0,0,32.5]) {
        make_ring(21, 5) rotate([-35,0,0]) rotate([90,0,0]) rotate([0,0,150]) cylinder(h=5, d=10, $fn=3);
        rotate([0,0,36]) make_ring(21, 5) rotate([-35,0,0]) translate([0,-5,-2]) rotate([270,0,0]) rotate([0,0,150]) cylinder(h=5, d=10, $fn=3);
    }
    // cone shaped cut-out top
    //translate([0,0,28]) cylinder(h=10, d1=27,d2=49);
    // 45 degree cone around bolt
    translate([0,0,28]) cylinder(h=10, d1=25,d2=45, $fn=250);
    
    // bottom bore/tap
    translate([0,0,-0.1]) threaded_rod(d=25, l=10, pitch=3.5, internal = true, slop = 0.25, orient=ORIENT_Z, align=V_UP);
    
    // top bore/tap for gem to screw into
    translate([0,0,(28-10)+0.1]) threaded_rod(d=25, l=10, pitch=3.5, internal = true, slop = 0.25, orient=ORIENT_Z, align=V_UP);
    
    // cylindrical hollow
    cylinder(h=37, d=22);
}