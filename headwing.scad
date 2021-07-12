use <common.scad>

$fn=200;
    
difference() {
    union() {
        translate([0,0,1]) wing();
        wingjoin(); 
    }
    translate([-2.5,38,(8/2)+1]) rotate([90,90,0]) scale([1.03,1.04,1]) wing_fastener();
    translate([-2.5,37,0.5]) cube([5,37,9]);
}

module wing() {
    translate([0,0,2]) linear_extrude(4) hull() {
            import("assets/SOL_tip_wings_plan.svg", convexity=10);
        }
    linear_extrude(8) import("assets/SOL_tip_wings_plan.svg", convexity=10);
}

module wingjoin() {
    intersection() {
        linear_extrude(10) hull() {
            import("assets/SOL_tip_wings_plan.svg", convexity=10);
        }
        minkowski(convexity=10){
            translate([-2,0,2]) cube([4,80,6]);
            sphere(d=4);
        }
    }
}