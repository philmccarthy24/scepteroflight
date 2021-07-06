/*********************************************
* Common modules for Scepter of Light
*********************************************/

// render a tear shaped gem
module tear_gem(radius, tip_offset, height) {
    hull($fn=14) {
        difference() {
            union() {
                sphere(r=radius);
                cylinder(h=tip_offset, r1=radius/2, r2=0);
            }
            translate([-radius,-radius,-radius]) cube([radius*2, radius, radius+tip_offset]);
            rotate([4.5,0,0]) translate([-radius,height,-radius]) cube([radius*2, radius-height, radius+tip_offset]);
        };
    };
}

// render a seat for a tear gem
module tear_gem_seat(radius, tip_offset, height) {
    render() {
        difference() {
            tear_gem_seat_outline(radius, tip_offset, height);
            translate([0,0,1]) linear_extrude(height) {
                gem_2d(radius+0.25, tip_offset+0.25);
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

// center a cube in the xy plane
module centred_xy_cube(dims) {
    translate([-(dims.x/2), -(dims.y/2), 0]) cube(dims);
}

// put child objects in a ring - quite proud of this one :)
module make_ring(ringradius, count) {
    drawangle = 360/count;
    for(item = [0 : count]) {
        a = drawangle * item;
        translate([ringradius * cos(a), ringradius * sin(a)]) rotate([0,0,270+a]) children();
    }
}

// yum
module pie(angle, radius, depth) {
    rotate_extrude(angle = angle, convexity = 10) square([radius,depth]);
}

module pill(xlen, ylen, depth) {
    translate([(ylen/2)-(xlen/2),0,0])
    linear_extrude(depth, true)
    hull() {
        circle(d=ylen);
        translate([xlen-ylen,0,0]) circle(d=ylen);
    }
}

module curve_fastener() {
    scale([1,2,1]){
        translate([0,-2,0]) cube([1,4,10]);
        translate([2,0,0]) rotate([0,0,60]) cylinder(h=10,d=4, $fn=3);
    }
}