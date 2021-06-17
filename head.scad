use <common.scad>
use <BOSL/constants.scad>
include <BOSL/threading.scad>

$fn = 100;

// TODO: attempt to put bore holes in head, and see how they interact
// with interior PCB volume

difference() {
    translate([40,80,0]) rotate([90,90,0]) left_head();
    translate([20,-95,-1]) cube([40,115,11]); // don't know. measure circuit board
}
difference() {
    translate([-40,80,0]) rotate([90,-90,0]) right_head();
    translate([-60,-95,-1]) cube([40,115,11]);
}


module left_head() {
    difference() {
        head_full_body();
        union() {
            translate([0,0,-10]) cylinder(h=220, d=15);
            translate([0,-30,-10]) cube([60,60,220]);
        }
    }
}

module right_head() {
    difference() {
        head_full_body();
        union() {
            translate([0,0,-10]) cylinder(h=220, d=15);
            translate([-60,-30,-10]) cube([60,60,220]);
        }
    }
}

module head_full_body() {
    // bottom screw
translate([0, 0, -9]) threaded_rod(d = 30, l = 9, pitch = 3.5, slop=0, orient=ORIENT_Z, align=V_UP);

    // shaft join
    import("assets/scepterheadjoin.stl", convexity=3);

    // head lower
    difference() {
        translate([0,0,25]) rotate_extrude(angle=360, convexity=2) import("assets/SOFB_head_lower_profile.svg");
        translate([0,0,75]) make_ring(24, 3) rotate([-7,0,0]) rotate([0,90,90]) tear_gem_seat_outline(10,20,4);
    }
    translate([0,0,75]) make_ring(24, 3) rotate([-7,0,0]) rotate([0,90,90]) tear_gem_seat(10,20,4);

    // head upper
    rotate([0,0,75])
    translate([0,0,100])
    import("assets/scepterheadwrap.stl", convexity=3);

    // thistle tip joiner
    difference() {
        translate([0,0,175]) cylinder(h=5, r=25.5);
        translate([0,0,178]) cylinder(h=3, r=24);
    }
    translate([0,0,178]) cylinder(h=5, r1=24, r2=15);

    // top screw
    translate([0, 0, 183 - 0.01]) threaded_rod(d = 25, l = 9, pitch = 3.5, slop=0, orient=ORIENT_Z, align=V_UP);
}