use <common.scad>
use <BOSL/constants.scad>
include <BOSL/threading.scad>

//$fn = 250;
$fn=50; // uncomment line above for high detail

translate([-60,0,0]) left_head();
right_head();

//head_full_body();




// A lot of positioning will be determined by layout of PCB
module right_head() {
    difference() {
        translate([50,0,0]) rotate([0,180,0]) halve_and_align(left=false, xoffset=25) head_with_external_inserts();
        translate([25,120+65,0]) rotate([90,0,0]) cylinder(h=120,d=40);
        
        // voltage regulator bay and bolt holes
        translate([50,0,0]) mirror([1,0,0]) common_cutouts();
        
        //speaker grille
        translate([25,120+40,-30]) circular_grille(height=20, diameter=25);
        
        // holes for lugs
        translate([50,0,0]) rotate([0,180,0]) lugs(clearance=0.5);
        
        // top part of vibration motor bay
        translate([25-4-(35.5-25),59,5.5]) vibration_motor_bay();
        
        // TODO: REMOVE - JUST FOR PROTOTYPING TO SEE WHAT BOSSED SCREW HOLE
        // WITH NUT INSERT LOOKS LIKE. RIGHT SIDE OF RIGHT SIDE WILL NOT HAVE SCREW HOLES
        // TODO: ALSO REMOVE TEMP CYLINDER BOSS IN FULL BODY MODULE
        // top m2 bolt hole
        translate([50-2.5, 180, -6])cylinder(h=7,d=2.4); // bore
        //translate([50-2.5, 180, -25])cylinder(h=18,d=4); // screw head boss
        translate([50-2.5-m2nutradius, 180-m2nutradius, -6]) cube([m2nutradius*2, m2nutradius*2, 2]);
        //////// END REMOVE
        
        // m2 bolt holes
        // 16mm shaft bottom screw protrudes 6mm
        translate([25+16, 60, -7])cylinder(h=8,d=2.4); // bore
        // top 12mm shaft screw protrudes 5mm
        translate([2.5, 180, -6])cylinder(h=7,d=2.4); // bore
        // m2 nut holder - nuts are 1.47mm high and 4mm across flat edge
        // to flat edge.
        m2nutradius = 2.25;
        // bottom nut holder - from center line
        translate([25, 60-m2nutradius, -6]) cube([16+m2nutradius, m2nutradius*2, 2]);
        // top nut holder has to be external - leave 4mm material
        translate([2.5-m2nutradius, 180-m2nutradius, -6]) cube([m2nutradius*2, m2nutradius*2, 2]);
    }
};

module left_head() {
    difference() {
        halve_and_align(left=true, xoffset=25) head_with_external_inserts();
        translate([5,65,-9]) cube([40,120,11]); // don't know. measure circuit board. looks like we'll be able to have 18mm clearance at this length.
        // might be able to get more if make pcb less long.
        // could add in standoffs too (see module func below)
        
        // hole for vibration motor, oriented on side
        translate([35.5,59,-5.5]) vibration_motor_bay();
        
        common_cutouts();
        
        // staggered M2 bolt holes
        // bottom
        translate([25-16, 60, -25])cylinder(h=30,d=2.4); // bore
        translate([25-16, 60, -25])cylinder(h=15,d=4); // screw head boss
        // middle - taken out
        //translate([50-2.5, 150, -25])cylinder(h=30,d=2.4); // bore
        //translate([50-2.5, 150, -25])cylinder(h=18,d=4); // screw head boss
        // top
        translate([50-2.5, 180, -25])cylinder(h=30,d=2.4); // bore
        translate([50-2.5, 180, -25])cylinder(h=18,d=4); // screw head boss
    }
    
    lugs();
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

module lugs(clearance=0) {
    // lugs - bottom
    translate([(25-10)-0.5,11,0])
    minkowski() {
        cube([1,4,2]);
        sphere(d=2+clearance);
    }
    translate([(25+10)-0.5,11,0])
    minkowski() {
        cube([1,4,2]);
        sphere(d=2+clearance);
    }
    // lugs - middle
    translate([25-23,85,0])
    minkowski() {
        cube([1,10,2]);
        sphere(d=2+clearance);
    }
    translate([25+23-1,85,0])
    minkowski() {
        cube([1,10,2]);
        sphere(d=2+clearance);
    }
    // lugs - top
    translate([25-10,187,0])
    rotate([0,0,90])
    minkowski() {
        cube([1,5,2]);
        sphere(d=2+clearance);
    }
    translate([25+15,187,0])
    rotate([0,0,90])
    minkowski() {
        cube([1,5,2]);
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
        translate([0,0,100]) rotate([0,0,60]) make_ring(24, 3) wing_fastener();
        
        // m2 screw housing (ensures there is enough material around screw, as
        // head texture juts into bolt shaft)
        translate([0,0,168.5]) rotate([0,0,-90]) intersection() {
            cylinder(d=50,h=5);
            union() {
                translate([2.5-25, -25, 2.5]) rotate([-90,0,0]) cylinder(h=50,d=5);
                
                // TODO: REMOVE THIS, JUST FOR PROTOTYPING TO SEE WHAT BOSS LOOKS LIKE
                translate([25-2.5, -25, 2.5]) rotate([-90,0,0]) cylinder(h=50,d=5);
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
        translate([0, 0, 183 - 0.01]) threaded_rod(d = 25, l = 9, pitch = 2.5, slop=0, orient=ORIENT_Z, align=V_UP);
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

// for pcb thickness of 1.6mm and screw length of 6mm.
// this might be useful in main pcb bay
module m3_standoff() {
    difference() {
    cylinder(h=5, d1=15, d2=6);
    translate([0, 0, 0.5]) threaded_rod(d = 3, l = 5, pitch = 0.5, internal = true, slop = 0.25, orient=ORIENT_Z, align=V_UP);
    }
}