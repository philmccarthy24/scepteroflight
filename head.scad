use <common.scad>
use <BOSL/constants.scad>
include <BOSL/threading.scad>

$fn = 100;

// TODO: attempt to put bore holes in head, and see how they interact
// with interior PCB volume

/*
difference() {
    translate([40,80,0]) rotate([90,90,0]) left_head();
    translate([20,-95,-1]) cube([40,115,11]); // don't know. measure circuit board
}
difference() {
    translate([-40,80,0]) rotate([90,-90,0]) right_head();
    translate([-60,-95,-1]) cube([40,115,11]);
}
*/

//left_head();

head_full_body();

// TODO: define right_head with lug holes, and speaker hollow.
// a lot of positioning will be determined by layout of PCB

module left_head() {
    difference() {
        halve_and_align(left=true, xoffset=25) head_with_external_inserts();
        translate([5,65,-10]) cube([40,120,11]); // don't know. measure circuit board
        // central cable run
        translate([25,-1,0]) rotate([-90,0,0]) cylinder(h=220, d=6);
        // hole for vib motor
        translate([36,56,-5]) cylinder(h=6, d=12);
        // cable run for vib motor
        translate([36,56,-2]) rotate([-90,0,0])
        hull() {
            cylinder(h=10, d=6);
            translate([0,-5,0]) cylinder(h=10, d=6);
        };
        
    }
    
    // lugs - bottom
    translate([25-10,12,0])
    minkowski() {
        cube([1,10,2]);
        sphere(d=2);
    }
    translate([25+10-1,12,0])
    minkowski() {
        cube([1,10,2]);
        sphere(d=2);
    }
    // lugs - middle
    translate([25-23,85,0])
    minkowski() {
        cube([1,10,2]);
        sphere(d=2);
    }
    translate([25+23-1,85,0])
    minkowski() {
        cube([1,10,2]);
        sphere(d=2);
    }
    // lugs - top
    translate([25-10,187,0])
    rotate([0,0,90])
    minkowski() {
        cube([1,5,2]);
        sphere(d=2);
    }
    translate([25+15,187,0])
    rotate([0,0,90])
    minkowski() {
        cube([1,5,2]);
        sphere(d=2);
    }
}

// halves objects centered around 0,0, in positive z direction,
// and rotates the half to be interior-up oriented in x/y
module halve_and_align(left, xoffset, maskx=60, masky=60, maskz=220) {
    offset=left ? 0 : -maskx;
    translate([xoffset,0,0]) {
        rotate([180,-90,90])
        difference() {
            children();
            translate([offset,-(masky/2),-1]) cube([maskx,masky,maskz]);
        }
    }
}

module head_with_external_inserts() {
    difference() {
        union() {
            head_full_body();
            // boss for wing screw hole
            translate([0,0,9+100+40]) rotate([0,0,60]) make_ring(25, 3) rotate([90,0,0]) cylinder(h=6, d=12);
        }
        // holes for tear gem LEDs
        translate([0,0,85]) make_ring(30, 3) rotate([90,0,0]) cylinder(h=25, d=6);
        // bore/tap for wing bolts
        translate([0,0,9+100+40]) rotate([0,0,60]) make_ring(27.5, 3) rotate([90,0,0]) threaded_rod(d=10, l=7.5, pitch=2.5, internal = true, slop = 0.25, orient=ORIENT_Z, align=V_UP);
    }
}

module head_full_body() {
    translate([0,0,9]) {
        // bottom screw
    translate([0, 0, -9]) threaded_rod(d = 28-5, l = 9, pitch = 2.5, slop=0, orient=ORIENT_Z, align=V_UP);

        // shaft join
        import("assets/scepterheadjoin.stl", convexity=3);

        // head lower
        difference() {
            translate([0,0,25]) rotate_extrude(angle=360, convexity=10) import("assets/SOL_head_lower_profile.svg");
            translate([0,0,75]) make_ring(25, 3) rotate([-8,0,0]) rotate([0,90,90]) tear_gem_seat_outline(10,20,4);
        }
        translate([0,0,75]) make_ring(25, 3) rotate([-8,0,0]) rotate([0,90,90]) tear_gem_seat(10,20,4);

        // head upper
        rotate([0,0,75])
        translate([0,0,100])
        import("assets/scepterheadwrap.stl", convexity=3);

        // thistle tip joiner
        translate([0,0,175])
        difference() {
            cylinder(h=5, r=25.5);
            translate([0,0,3]) cylinder(h=3, r=24);
        }
        translate([0,0,178]) cylinder(h=5, r1=24, r2=15);

        // top screw
        translate([0, 0, 183 - 0.01]) threaded_rod(d = 25, l = 9, pitch = 3.5, slop=0, orient=ORIENT_Z, align=V_UP);
    }
}