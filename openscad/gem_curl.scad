use <common.scad>
use <gem.scad>

/****************************************************
* Scepter of Light Gem Curl design
* Phil McCarthy, 2021
* 
* Distributed under the terms of the GPLv3 license:
* https://www.gnu.org/licenses/gpl-3.0.en.html
****************************************************/

// thistle and gem outline - used for positioning and sizing of curl
/*
rotate_extrude(angle=360, convexity=10) import("assets/SOL_thistle_profile.svg");
translate([17,0,29]) rotate([0,38,0]) curve_fastener();
rotate([0,0,180]) translate([17,0,29]) rotate([0,38,0]) curve_fastener();
facets = brilliant_facets();
translate([0,0,(95-21.5)+(37-20)]) scale([6.5,6.5,9.5]) gem(facets,len(facets));
translate([17,0,29]) rotate([0,38,0]) gem_curl();
*/


rotate([-90,0,-38]) gem_curl($fn=250);

module gem_curl() {
    difference() {
        union() {
            rotate([0,-38,0]) translate([4.5,12/2,-5]) rotate([90,0,0]) linear_extrude(12) offset(delta=1.6) import("assets/SOL_thistle_curl_plan.svg");
            translate([0,-12/2,0]) translate([0.25,0,0]) cube([3.25,12,10]);
        }
        scale([1.02,1.03,1]) curve_fastener();
        translate([0,0,-1]) scale([1.02,1.03,1]) curve_fastener();
    }
}