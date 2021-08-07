use <common.scad>

$fn=250;

/****************************************************
* Scepter of Light Wing design
* Phil McCarthy, 2021
* 
* Distributed under the terms of the GPLv3 license:
* https://www.gnu.org/licenses/gpl-3.0.en.html
****************************************************/

rotate([0,-90,0]) wing();


module wingbody() {
    translate([0,0,2]) linear_extrude(4) hull() {
            import("assets/SOL_tip_wings_plan.svg", convexity=10);
        }
    linear_extrude(8) import("assets/SOL_tip_wings_plan.svg", convexity=10);
}

module wingjoin() {
    intersection() {
        linear_extrude(12) hull() {
            import("assets/SOL_tip_wings_plan.svg", convexity=10);
        }
        minkowski(convexity=10){
            translate([-2,0,2]) cube([4.5,80,8]);
            sphere(d=4);
        }
    }
}

module wing() {
    difference() {
        union() {
            translate([0,0,2]) wingbody();
            // remove lower part of join
            difference() {
                wingjoin();
                translate([10,14.3,5]) rotate([0,0,32]) translate([-20,-15,-10]) cube([40,30,20]);
           }
        }
        translate([-2.6,29.5,2]) cube([5,18,8]);
        translate([-3.3,73,(8/2)+2]) rotate([90,90,0]) wing_fastener_circular_cut_end();
        // slit and groove cutout to give fastener clip some mechanical flexibility
        translate([3.75,-10,6]) rotate([-90,0,0]) cylinder(h=100,d=2.5);
        translate([-1,-10,5.75]) cube([5,100,0.5]);
        
    }
}

module wing_fastener_circular_cut_end() {
    intersection() {
        scale([1.1,1.1,2]) wing_fastener();
        hull() {
            translate([0,6,4.4]) rotate([90,0,0]) cylinder(d=8.8,h=8);
            translate([0,6,50]) rotate([90,0,0]) cylinder(d=8.8,h=8);
        }
    }
}

