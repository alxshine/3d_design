$fa = 1;
$fs = 0.4;

// general config
thickness = 3;
overlap = .01;

// cutout module
switch_size = 14;
module cutout(offset_x = 0, offset_y = 0, offset_z = 0)
{
    translate([ offset_x, offset_y, offset_z ])
        cube([ switch_size, switch_size, height + overlap ]);
}

module column(left_x)
{
    cutout(left_x, bottom_sep);
    cutout(left_x, bottom_sep + switch_size + inner_sep);

    cutout(left_x, 2 * bottom_sep + 2 * switch_size + inner_sep);
    cutout(left_x, 2 * bottom_sep + 3 * switch_size + 2 * inner_sep);
}

module edge_fillet(length, rotate, shift, radius=1){
    translate(shift)
        rotate(rotate)
        difference(){
            cube([length, radius, radius], center=true);
            translate([0,-radius/2,-radius/2])
                rotate([0,90,0])
                    cylinder(r=radius/2, h=2*length, center=true);
        }
}

// main tester
height = 20;

inner_sep = 5;
lr_sep = 6;
bottom_sep = 10;

// cube([ width, length, height ]);
num_columns = 10;
total_width = lr_sep + num_columns * (lr_sep + switch_size);
total_length = 2 * bottom_sep + 2 * inner_sep + 4 * switch_size + bottom_sep;


difference()
{
    union(){
        cube([ total_width, total_length, height ]);
        translate([ total_width / 2, total_length / 2, height / 2 ])
            cube([ total_width, thickness, height ], center = true);
    }

    for (i = [0:num_columns - 1])
        column(lr_sep + i * (lr_sep + switch_size));
    translate([ thickness, thickness, -overlap ]) cube([
        total_width - 2 * thickness,
        total_length - 2 * thickness,
        height + overlap -
        thickness
    ]);

    // fillets on top edges
    edge_fillet(total_width, [0,0,0], [total_width/2,total_length, height]);
    edge_fillet(total_width, [0,0,180], [total_width/2,0, height]);
    edge_fillet(total_length,[0,0,90],[0,total_length/2,height]);
    edge_fillet(total_length,[0,0,-90],[total_width,total_length/2,height]);

    // fillets on the sides
    edge_fillet(height, [180,90,0], [0,0,height/2]);
    edge_fillet(height, [0,90,0], [total_width,total_length,height/2]);
    edge_fillet(height, [90,90,0], [total_width,0,height/2]);
    edge_fillet(height, [-90,90,0], [0,total_length,height/2]);
}