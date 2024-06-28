$fs = 0.1;
$fa = 1;

include <../../../lib/BOSL2/std.scad>
include <../../../lib/BOSL2/hinges.scad>

wallThickness = 2;
bodyHeight = 60;
camBodyDiameter = 81;
camBodyDepth = 25;
camClearance = 30;
hingeLength = 24;

union() {
	difference() {
		tube(h=camBodyDepth+camClearance, id=camBodyDiameter, od=camBodyDiameter+wallThickness*2, anchor=BOTTOM);
		up(camClearance)
			cube([camBodyDiameter*2, bodyHeight, camBodyDepth*2], anchor=BOTTOM);
	}

	fwd(camBodyDiameter/2+wallThickness) {
		cube([hingeLength, wallThickness, 4], anchor=BOTTOM+FRONT);
		knuckle_hinge(length=hingeLength, offset=5, segs=3, arm_angle=90, inner=false, teardrop=true, orient=FRONT, anchor=BOTTOM+FRONT);
	}
}

down(wallThickness+0.5)
union() {
	cyl(h=wallThickness, d=camBodyDiameter+wallThickness*2, anchor=BOTTOM);

	fwd(camBodyDiameter/2+wallThickness+5) {
		cuboid([hingeLength/3, wallThickness+10, wallThickness], rounding=wallThickness/2, edges=FRONT+DOWN, anchor=BOTTOM+FRONT);
		up(wallThickness)
			knuckle_hinge(length=hingeLength, offset=2.5, segs=3, inner=true, teardrop=true, orient=UP, spin=180);
	}

	back(camBodyDiameter/2+wallThickness+5)
		cuboid([hingeLength/3, wallThickness+10, wallThickness], rounding=wallThickness/2, anchor=BOTTOM+BACK);
}
