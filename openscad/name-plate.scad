cube([50, 25, 5]);
translate([3, 6, 5]) {
  linear_extrude(height = 1) {
    text("lookup", font = "Noto Serif JP");
  }
}

translate([-10, -10, 0]) {
  difference () {
    cube([10, 5, 5]);
    translate([0, 1.25, 1.25]) {
      cube([11, 2.5, 2.5]);
    }
  }
}
