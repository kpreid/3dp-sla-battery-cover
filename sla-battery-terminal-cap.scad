// Size of the battery in the direction parallel to the pair of terminals, in millimeters. Usually the smallest dimension.
inside_width = 65;

// Size of the cover in the direction the wires will come out (towards the middle of the battery), in millimeters. Non-critical.
inside_length = 50;

// Size of the cover vertically (should be less than the height of the battery), in millimeters.
inside_height = 30;

// Amount of vertical space to allow for the wires and terminals, in millimeters.
wiring_height = 10;

cover_thickness = 1.29;

/* [Hidden] */

// Closest approach of any terminal (with fastened connector) to the edges of the top of the battery. Used to set the lip around the top of the cap.
terminal_edge = 4;

epsilon = 0.01;


main();


module main() {
    difference() {
        intersection() {
            translate([-inside_width / 2, 0, 0])
            hull() {
                // Main cap box
                translate([-cover_thickness, -cover_thickness, -inside_height])
                cube([inside_width + cover_thickness * 2, inside_length + cover_thickness * 2, inside_height +
     cover_thickness]);
                
                // Cover above terminals
                translate([terminal_edge, terminal_edge, wiring_height])
                cube([inside_width - terminal_edge * 2, inside_length - terminal_edge * 2, cover_thickness]);
            }
            
            // Corner rounding
            scale([1, inside_length, inside_height])
            rotate([0, 90, 0])
            cylinder(r=1, h=10000, center=true, $fn = 20);

        }
        
        battery_model();
    }
    
    %battery_model();
}

module battery_model() {
    translate([-inside_width / 2, 0, -inside_height * 2])
    cube([inside_width, inside_length * 2, inside_height * 2]);
}