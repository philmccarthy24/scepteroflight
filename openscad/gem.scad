/****************************************************
* Scepter of Light Top Gem design
*
* Adapted from a design by Kit Wallace, original at:
* https://github.com/KitWallace/openscad/blob/master/gem.scad
*
* Phil McCarthy, 2021
* 
* Distributed under the terms of the GPLv3 license:
* https://www.gnu.org/licenses/gpl-3.0.en.html
****************************************************/

use <common.scad>

function make_facets(start,increment,limit,axial_angle,height) =
    start <= limit
      ? concat([[start/limit*360, axial_angle, height]] ,
               make_facets(start+increment,increment,limit,axial_angle,height))
      : [] ;

module body(Size=100) {
    cube(Size,center=true);
}

module cut_facet_data(index_angle,axial_angle,height,Width=200,Depth=50) {
     rotate([0,0,index_angle])
        rotate([0,axial_angle,0])
           translate([0,0,Depth/2 + height])
              cube([Width,Width,Depth],center=true);
}

module cut_facets(facets, n) {
   for (i =[0:n-1]) 
       cut_facet(facets[i]);
}

module cut_facet(facet) {
   cut_facet_data(facet[0],facet[1],facet[2]);
}

module gem(facets,n) {
   difference() {
      if (n==1) body(); else gem(facets,n-1);
      cut_facet(facets[n-1]);
   }
}

function brilliant_facets() =
 concat( 
   make_facets(1,1,1,0,2.28),      // table
   make_facets(1,1,1,180,7.8),     // culet
   make_facets(1,2,32,35,5),       // B
   make_facets(4,4,32,30,4.46),    // M
   make_facets(2,4,32,16,3.46),    // S
   make_facets(2,2,32,90,8.5),     // girdle
   make_facets(1,2,32,42+180,6)    // C
 ); 

facets = brilliant_facets();
// echo (len(facets), facets);

difference() {
    translate([0,0,21.5]) rotate([180,0,0]) scale([6.5,6.5,9.5]) gem(facets,len(facets));
    translate([0,0,75]) cylinder(h=25,d=100);
    //translate([0,0,-1]) cylinder(h=74, d=160); // debug
}

// 45 degree cone around bayonet
translate([0,0,75]) cylinder(h=10, d1=35.5,d2=25, $fn=250);
translate([0,0,85]) cylinder(h=10, d=25, $fn=250);
translate([0,0,90]) make_ring(25/2, 4) sphere(d=6, $fn=100); 

