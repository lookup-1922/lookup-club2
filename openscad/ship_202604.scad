$fn = 40;

// 寸法
L = 160;
B = 20;
H = 12;

// 船首長さ
bow_len = 40;

// 船底幅倍率
bottom_scale = 0.4;


// 船首
module bow() {
  hull() {
    // 上面
    linear_extrude(height = 0.1)
      polygon([
        [0, B / 2], 
        [bow_len, B], 
        [bow_len, 0]
      ]);

    // 底面
    translate([0, B * (1 - bottom_scale) / 2, -H])
      linear_extrude(height = 0.1)
        scale([1, bottom_scale])
          polygon([
            [0, B / 2], 
            [bow_len, B], 
            [bow_len, 0]
          ]);
  }
}


// 船体中央
module mid_body() {
  hull() {
    // 上面
    translate([bow_len, 0, 0])
      linear_extrude(height = 0.1)
        square([L - bow_len, B]);

    // 底面
    translate([bow_len, B * (1 - bottom_scale) / 2, -H])
      linear_extrude(height = 0.1)
        scale([1, bottom_scale])
          square([L - bow_len, B]);
  }
}

// 艦橋
module bridge() {
  translate([L * 0.32, B * 0.2, 0])
    union() {

      cube([10, B * 0.6, 8]);

      translate([-2, B * -0.1, 8])
        cube([12, B * 0.8, 6]);
    }
}

// 主砲
module main_gun() {
  translate([bow_len * 0.9, B / 2, 0])
    union() {
      cylinder(h = 5, r = 5.6);

      translate([0, 0, 3])
        rotate([180, 90, 0])
          cylinder(h = 20, r = 1);

    }
  translate([bow_len * 3.5, B / 2, 0])
    union() {
      cylinder(h = 5, r = 5.6);

      translate([0, 0, 3])
        rotate([180, 90, 0])
          cylinder(h = 20, r = 1);

    }
}

// 煙突
module funnel() {
  translate([L * 0.52, B / 2, -2])
    rotate([0, 10, 0])
      union() {
        cylinder(h = 21, r = 6);

        translate([20, 0, 2])
          cylinder(h = 18, r = 4);
      }
}

// 組み立て
union() {
  bow();
  mid_body();
  bridge();
  main_gun();
  funnel();
}