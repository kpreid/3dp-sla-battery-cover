// Size of the battery in the direction parallel to the pair of terminals, in millimeters. Usually the smallest dimension.
inside_width = 65;

// Size of the cover in the direction the wires will come out (towards the middle of the battery), in millimeters. Non-critical.
inside_length = 45;

// Size of the cover vertically (should be less than the height of the battery), in millimeters.
inside_height = 20;

// Amount of vertical space to allow for the wires and terminals, in millimeters.
wiring_height = 10;

// Closest approach of any terminal (with fastened connector) to the edges of the top of the battery, in millimeters. Used to set the lip around the top of the cap.
terminal_edge = 4;

// Distance from the terminal end of the battery to the inside edge of the terminals, in millimeters. Used to set the position of the strap slot.
terminal_inner = 15;

cover_thickness = 1.29;

strap_slot_width = 23;

strap_slot_height = 4;

/* [Hidden] */

epsilon = 0.01;
outer_width = inside_width + cover_thickness * 2;


main();


module main() {
    difference() {
        intersection() {
            translate([-inside_width / 2, 0, 0])
            hull() {
                // Main cap box
                translate([-cover_thickness, -cover_thickness, -inside_height])
                cube([outer_width, inside_length + cover_thickness, inside_height +
     cover_thickness]);
                
                // Cover above terminals
                translate([terminal_edge - cover_thickness, terminal_edge - cover_thickness, wiring_height])
                cube([inside_width - terminal_edge * 2 + cover_thickness * 2, inside_length - terminal_edge * 2 + cover_thickness, cover_thickness]);
            }
            
            // Corner rounding
            union() {
                scale([1, inside_length, inside_height])
                rotate([0, 90, 0])
                cylinder(r=1, h=outer_width, center=true, $fn = 20);
                
                translate([-outer_width / 2, 0, 0]) 
                cube([outer_width, inside_length, inside_height]);
            }
        }
        
        battery_model();
        
        // Interior space for terminals/wiring
        translate([-inside_width / 2 + terminal_edge, terminal_edge, -epsilon])
        cube([inside_width - terminal_edge * 2, inside_length + epsilon, wiring_height + epsilon]);
        
        // Tie-down strap
        translate([-(outer_width + epsilon * 2) / 2, terminal_inner, 0])
        cube([outer_width + epsilon * 2, strap_slot_width, strap_slot_height]);
    }
    
    %battery_model();
}

module battery_model() {
    translate([-inside_width / 2, 0, -inside_height * 4])
    cube([inside_width, inside_length * 3, inside_height * 4]);
}