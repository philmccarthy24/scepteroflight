use <BOSL/constants.scad>
include <BOSL/threading.scad>

$fn=200;

threadDiameter = 10;
threadHoleAdjustment = 0.35; 
threadLength = 10;
threadPitch = 2.5;

difference() {       
    union() {
        difference() {
            wing();
            translate([-24,100,8]) rotate([90,0,0]) cylinder(h=100,r=25);
        }
        translate([0,40,8]) rotate([0,90,0]) cylinder(h=10, r=6);
    }
    translate([-0.5,40,8]) rotate([0,90,0]) threaded_rod(d = threadDiameter, l = threadLength+1, pitch = threadPitch, internal = true, slop = threadHoleAdjustment, orient=ORIENT_Z, align=V_UP);
}

module wing() {
    translate([0,0,2]) linear_extrude(12) hull() {
            import("assets/SOFB_tip_wings_plan.svg", convexity=10);
        }
    linear_extrude(16) import("assets/SOFB_tip_wings_plan.svg", convexity=10);
}