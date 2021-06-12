$fn=100;

import("assets/scepterheadjoin.stl", convexity=3);

translate([0,0,25]) rotate_extrude(angle=360, convexity=2) import("assets/SOFB_head_lower_profile.svg");

translate([0,0,100])
import("assets/scepterheadwrap.stl", convexity=3);


