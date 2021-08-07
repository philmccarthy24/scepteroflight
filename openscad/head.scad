use <common.scad>
use <BOSL/constants.scad>
include <BOSL/threading.scad>

/****************************************************
* Scepter of Light Head design
* Phil McCarthy, 2021
* 
* Distributed under the terms of the GPLv3 license:
* https://www.gnu.org/licenses/gpl-3.0.en.html
****************************************************/

//$fn = 250;
$fn=25; // uncomment line above for high detail

translate([-70,0,0]) left_head();
right_head();


//head_full_body();


module right_head() {
    difference() {
        translate([50,0,0]) rotate([0,180,0]) halve_and_align(left=false, xoffset=25) head_with_external_inserts();
        translate([25,120+65,0]) rotate([90,0,0]) cylinder(h=120,d=40);
        
        // voltage regulator bay
        translate([50,0,0]) mirror([1,0,0]) common_cutouts();
        
        // pcb bay top - note this give 6mm more clearance than bottom,
        // giving a total of 16mm for pcb height
        translate([5,65,-10]) cube([40,120,15]);
        
        //speaker grille
        translate([25,120+40,-30]) circular_grille(height=20, diameter=25);
        
        // holes for lugs
        translate([50,0,0]) rotate([0,180,0]) lugs(clearance=0.5, depthOffset=1);
        
        // top part of vibration motor bay
        translate([25-4-(35.5-25),59,5.5]) vibration_motor_bay();
        
        // staggered M2 bolt holes
        // bottom
        translate([25+15, 60, -25])cylinder(h=30,d=2.4); // bore
        translate([25+15, 60, -25])cylinder(h=16,d=4); // screw head boss
        // top
        translate([2.5, 180, -25])cylinder(h=30,d=2.4); // bore
        translate([2.5, 180, -25])cylinder(h=18,d=4); // screw head boss
    }
};

// this is the "bottom", ie base of pcb
module left_head() {
    difference() {
        halve_and_align(left=true, xoffset=25) head_with_external_inserts();
        
        // 5mm depth standoff floor for pcb bay
        translate([25,65,0]) rotate([-90,0,0]) intersection()
        {
            cylinder(h=120, d=40);
            translate([-30,0,0]) cube([60,6+5,120]); // 9mm pcb bay depth, 5mm M3 screw depth clearance (standoffs will come up from notional pcb bay "floor" by 1mm, to give clearance for poking LEDs through
        }
        
        // hole for vibration motor, oriented on side
        translate([35.5,59,-5.5]) vibration_motor_bay();
        
        // pcb bay bottom
        translate([5,65,-6]) cube([40,120,11]);
        
        common_cutouts();
        
        // holes for m2 brass screw inserts
        // bottom: 13.15mm long M2 bolt will protrudes 3mm, ideal for 4mm depth insert
        translate([25-15, 60, -6]) m2_insert_cutout();
        
        // top: 11.35mm long M2 bolt including head will protrudes 3mm to fit smallest M2x4x3.5 brass insert.
        translate([50-2.5, 180, -6]) m2_insert_cutout();
    }
    
    lugs();
    
    // standoffs for main pcb
    translate([15,65+10,-6-5]) m3_standoff(); // bottom left
    translate([5+12,65+120-20,-6-5]) m3_standoff(); // top left
    translate([50-5-12,65+120-20,-6-5]) m3_standoff(); // top right
}

module vibration_motor_bay() {
    rotate([0,90,0]) 
    hull() {
        cylinder(h=5, d=12);
        translate([0,4,0]) cylinder(h=5, d=12);
    }
}

module common_cutouts() {
    // XL6009E1 voltage regulator bay. clearance is too
    // tight for standoffs and screw holes, so will just need to be glued in
    translate([25-(22/2), 18, -7.5]) cube([22,48,11]); 
}

module lugs(clearance=0, depthOffset=0) {
    // lugs - bottom
    translate([(25-10)-0.5,11,0])
    minkowski() {
        cube([1,4,2+depthOffset]);
        sphere(d=2+clearance);
    };
    translate([(25+10)-0.5,11,0])
    minkowski() {
        cube([1,4,2+depthOffset]);
        sphere(d=2+clearance);
    };
    // lugs - middle
    translate([25-23,85,0])
    minkowski() {
        cube([1,10,2+depthOffset]);
        sphere(d=2+clearance);
    }
    translate([25+23-1,85,0])
    minkowski() {
        cube([1,10,2+depthOffset]);
        sphere(d=2+clearance);
    }
    // lugs - top
    translate([25-10,187,0])
    rotate([0,0,90])
    minkowski() {
        cube([1,5,2+depthOffset]);
        sphere(d=2+clearance);
    }
    translate([25+15,187,0])
    rotate([0,0,90])
    minkowski() {
        cube([1,5,2+depthOffset]);
        sphere(d=2+clearance);
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
        head_full_body();
        // holes for tear gem LEDs
        translate([0,0,85]) make_ring(30, 3) rotate([90,0,0]) cylinder(h=25, d=6);
        
        // hole from end screw to voltage regulator bay
        translate([0,0,-1]) cylinder(h=20, d=15);
        
        // hole from pcb bay to thistle
        translate([0,0,65+120-1]) cylinder(h=20, d=15);
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
            translate([0,0,75]) make_ring(24, 3) rotate([-8,0,0]) rotate([0,90,90]) tear_gem_seat_outline(10,20,4);
        }
        translate([0,0,75]) make_ring(24, 3) rotate([-8,0,0]) rotate([0,90,90]) tear_gem_seat(10,20,4);

        // head upper
        rotate([0,0,75])
        translate([0,0,100])
        import("assets/scepterheadwrap.stl", convexity=3);
        // fasteners for wings
        translate([0,0,150]) rotate([0,0,60]) make_ring(23, 3) wing_fastener();
        
        // m2 screw housing (ensures there is enough material around screw and insert hole, as
        // head texture juts into bolt shaft)
        translate([0,0,168.5]) rotate([0,0,-90]) intersection() {
            cylinder(d=50,h=5);
            union() {
                translate([2.5-25, -25, 2.5]) rotate([-90,0,0]) cylinder(h=50,d=5);
            }
        }

        // thistle tip joiner
        translate([0,0,175])
        difference() {
            cylinder(h=5, r=25.5);
            translate([0,0,3]) cylinder(h=3, r=24);
        }
        translate([0,0,178]) cylinder(h=5, r1=24, r2=15);

        // top screw
        translate([0, 0, 183 - 0.01]) threaded_rod(d = 25, l = 2.5, pitch = 2.5, slop=0, orient=ORIENT_Z, align=V_UP);
    }
}

module circular_grille(height, diameter) {
    intersection() {
        cylinder(h=height, d=diameter);

        rotate([0,0,45]) {
            for (x = [0:2:diameter]) {
                translate([x-diameter/2, -diameter/2, -1]) cube([0.75, diameter, height]);
            }
        }
    }
}

module m2_insert_cutout() {
    cylinder(h=1, d1=3.5,d2=3);
    translate([0,0,1]) cylinder(h=3, d=3.1);
    translate([0,0,4]) cylinder(h=1.5, d1=3.1,d2=3.75);
    translate([0,0,5.5]) cylinder(h=0.5, d=3.75);
}

module m3_insert_cutout() {
    cylinder(h=1, d1=5,d2=4.5);
    translate([0,0,1]) cylinder(h=2.5, d=4.5);
    translate([0,0,3.5]) cylinder(h=1.5, d1=4.5,d2=5.25);
    translate([0,0,5]) cylinder(h=0.5, d=5.25);
}

// for pcb thickness of 1.6mm and screw length of 6mm.
// actual height of standoff is 5.5mm
module m3_standoff() {
    difference() {
        union() {
            cylinder(h=4.5, d1=12, d2=8);
            translate([0,0,4.5]) cylinder(h=1, d=8);
        };
        m3_insert_cutout();
    };
}