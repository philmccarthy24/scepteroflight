use <BOSL/constants.scad>
include <BOSL/threading.scad>

$fn = 250;
//$fn = 100;

threadDiameter = 32;
shaftDiameter = 32 + 4;
threadHoleAdjustment = 0.35; 
threadLength = 10;
threadPitch = 2;

difference() {
    hilt();
    translate([0,0,30]) make_ring(20, 3) rotate([7,0,0]) rotate([0,-90,-90]) tear_gem_seat_outline(5,11,4);
}
translate([0,0,71]) make_ring(20, 7) sphere(r=2);
translate([0,0,30]) make_ring(20, 3) rotate([7,0,0]) rotate([0,-90,-90]) tear_gem_seat(5,11,4);


module tear_gem_seat(radius, tip_offset, height) {
    render() {
        difference() {
            tear_gem_seat_outline(radius, tip_offset, height);
            translate([0,0,1]) linear_extrude(height) {
                gem_2d(radius+1, tip_offset+1);
            };
        }
    }
}

module tear_gem_seat_outline(radius, tip_offset, height) {
    render() {
        difference() {
            minkowski(convexity=3) {
                sphere(r=height/2);
                linear_extrude(1) {
                    gem_2d(radius, tip_offset, 50);
                }
            };
            translate([-radius*2, -radius*2, -height]) cube([(radius+tip_offset)*2, radius*4, height]);
        }
    }
}

module gem_2d(radius, tip_offset, numsides=14) {
    hull($fn=numsides) {
        circle(r=radius);
        translate([tip_offset-((radius/10)/2), 0, 0]) circle(r=radius/10, $fn=3);
    }
}

module threadTest() {
    //Screw
    difference() {
        union() {
            cylinder(d = shaftDiameter, h=10);
            translate([0, 0, 10 - 0.01]) threaded_rod(d = threadDiameter, l = threadLength - 2, pitch = threadPitch, slop=0, orient=ORIENT_Z, align=V_UP);
        };
        centred_xy_cube([21,23,10+threadLength]);
        translate([0,-((23/2)+(3/2)),10+threadLength - 10]) centred_xy_cube([10,3,10]);
    }
}

//Nut -- adjust threadHoleAdjustment in parameters section until the nut screws freely but doesn't wiggle 
    //on the screw, test print takes ~10 mins and 3g of filament
module hilt() {
    profile="assets/SOFB_hilt_profile.svg";
    render() {
        difference() {       
            translate([0,0,100]) rotate([180,0,0]) rotate_extrude(angle=360, convexity=3) import(profile);
            translate([0, 0, -1]) threaded_rod(d = threadDiameter, l = threadLength+1, pitch = threadPitch, internal = true, slop = threadHoleAdjustment, orient=ORIENT_Z, align=V_UP);
        }
    }
}

module ring_of_beads(ringrad, beadrad, beadcount) {
    beadangle = 360/beadcount;
    for(beadnum = [0 : beadcount]) {
        a = beadangle * beadnum;
        translate([ringrad * cos(a), ringrad * sin(a)]) sphere(r=beadrad);
    }
}

module centred_xy_cube(dims) {
    translate([-(dims.x/2), -(dims.y/2), 0]) cube(dims);
}

module make_ring(ringradius, count)
{ 
    drawangle = 360/count;
    for(item = [0 : count]) {
        a = drawangle * item;
        translate([ringradius * cos(a), ringradius * sin(a)]) rotate([0,0,270+a]) children();
    }
}

module tear_gem(radius, tip_offset, height) {
    hull($fn=14) {
        difference() {
            union() {
                sphere(r=radius);
                cylinder(h=tip_offset, r1=radius/2, r2=0);
            }
            translate([-radius,-radius,-radius]) cube([radius*2, radius, radius+tip_offset]);
            rotate([4,0,0]) translate([-radius,height,-radius]) cube([radius*2, radius-height, radius+tip_offset]);
        };
    };
}
