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

// main tester
height = 20;

inner_sep = 5;
lr_sep = 6;
bottom_sep = 10;

// cube([ width, length, height ]);
num_columns = 10;
total_width = lr_sep + num_columns * (lr_sep + switch_size);
total_length = 2 * bottom_sep + 2 * inner_sep + 4 * switch_size + bottom_sep;


union(){
difference()
{

    cube([ total_width, total_length, height ]);

    union()
    {
        for (i = [0:num_columns - 1])
            column(lr_sep + i * (lr_sep + switch_size));
        translate([ thickness, thickness, -overlap ]) cube([
            total_width - 2 * thickness,
            total_length - 2 * thickness,
            height + overlap -
            thickness
        ]);
    }
}

translate([ total_width / 2, total_length / 2, height / 2 ])
    cube([ total_width, thickness, height ], center = true);
}