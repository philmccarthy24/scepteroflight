use <BOSL/constants.scad>
include <BOSL/threading.scad>
use <common.scad>

/****************************************************
* Scepter of Light LED Stalk design
* Phil McCarthy, 2021
* 
* Distributed under the terms of the GPLv3 license:
* https://www.gnu.org/licenses/gpl-3.0.en.html
****************************************************/

$fn=250;

difference() {
    stalk();
    translate([0,0,-1]) make_ring(4, 3) cylinder(h=52, d=2);
    translate([0,0,-1]) cylinder(h=52, d=4);
    rotate([0,0,60]) translate([0,0,20]) make_ring(8.5, 3) cylinder(h=20, d=10);
}

module stalk() {
    translate([0,0,10])
    difference() {
        cylinder(h=5,d=24);
        translate([0,0,-0.1]) threaded_rod(d=20, l=5, pitch=1.5, internal = true, slop = 0.25, orient=ORIENT_Z, align=V_UP);
    }
    cylinder(h=15, d=14);
    translate([0,0,15]) cylinder(h=5, d1=24, d2=15);
    translate([0,0,20]) cylinder(h=15,d=15);
}