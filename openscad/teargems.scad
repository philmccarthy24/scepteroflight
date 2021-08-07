use <common.scad>

/****************************************************
* Scepter of Light Tear Gems design
* Phil McCarthy, 2021
* 
* Distributed under the terms of the GPLv3 license:
* https://www.gnu.org/licenses/gpl-3.0.en.html
****************************************************/

// gems for hilt - recommend 100% infill
rotate([90,0,0]) tear_gem(5,10,2.5);
translate([20,0,0]) rotate([90,0,0]) tear_gem(5,10,2.5);
translate([-20,0,0]) rotate([90,0,0]) tear_gem(5,10,2.5);

// gems for head - recommend printing hollow with 0.2mm layer height,
// 1 perimeter and 1 bottom/top layer, 0% infill, and then drilling hole into back for LED once finished.
translate([0,25,10]) rotate([0,0,90]) tear_gem(10,20,4);
translate([20,25,10]) rotate([0,0,90]) tear_gem(10,20,4);
translate([-20,25,10]) rotate([0,0,90]) tear_gem(10,20,4);