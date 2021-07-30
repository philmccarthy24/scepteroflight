use <common.scad>

$fn=250;

rotate([0,-90,0])
difference() {
    union() {
        translate([0,0,2]) wing();
        // remove lower part of join
        difference() {
            wingjoin();
            translate([10,14.3,5]) rotate([0,0,32]) translate([-20,-15,-10]) cube([40,30,20]);
       }
    }
    translate([-2.5,29.5,1.5]) cube([5,18,9]);
    translate([-2.5,73,(8/2)+2]) rotate([90,90,0]) scale([1.03,1.04,2]) wing_fastener();
    
}
 

module wing() {
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