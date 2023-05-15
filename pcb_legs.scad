// translate([0,0,-10])
// 	cube([30,10,10]);

screwhole_length = 7;
leg_radius = 5;

module leg(x,y){
	translate([x,y,-20])
		difference() {
			cylinder(20, leg_radius, leg_radius, $fn=20);
			translate([0,0,20- screwhole_length + 1]) // holes for screws
				cylinder(screwhole_length, 2, 2, $fn=20);
		}
}

difference() {
translate([0,0,8]) {
	rotate([4,0,0]){
			// cube([320,100,10]); // top plate, used mainly for debugging

		leg(37,9);
		leg(320-23,9);
		leg(18,100-9);
		leg(18,100-9);
		leg(320-117,100-9);
		leg(320-127,100-47);
		leg(320-24,100-27);
	};
};
translate([0,0,-20])
		cube([320,100,20]); // ground for difference
};
