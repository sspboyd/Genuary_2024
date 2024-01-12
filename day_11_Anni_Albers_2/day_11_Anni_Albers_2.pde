// __ _ ___ ____ _______ ___________ __________________ ___________ _______ //<>// //<>//
//
//    GENUARY 2024, Day 7 #2, "Loading Animation"
//      @sspboyd sspboyd.ca   Stephen Boyd
//          https://www.sspboyd.ca/projects/genuary-2024
//               https://github.com/sspboyd/Genuary_2024
//                       https://www.instagram.com/sspboyd/
//
//      DM me with any questions or comments.
//
// __ _ ___ ____ _______ ___________ __________________ ___________ _______

float PHI = 1.61803399;
float i_PHI = 0.61803399;
int r_seed;
int n_seed;
float n_off, n_incr;
int window_w, window_h;
int num_rows, num_cols;
color clr_1, clr_2;
int cell_w, cell_h;

color[][] clrs = new color[5][2];
boolean movie_capture = false;

void settings() {
  int target_window_h=1920;
  int target_window_w=1080;

  num_rows = int(target_window_w/4);
  num_cols = int(target_window_h/47);
  //num_rows = int(target_window_w*pow(i_PHI, 7));
  //num_cols = int(target_window_h*pow(i_PHI, 7));

  cell_w = int(target_window_w/num_cols);
  cell_h = int(target_window_h/num_rows);
  window_w = cell_w*num_cols;
  window_h = cell_h*num_rows;
  size(window_w, window_h);
}

void setup() {

  background(#F8F0D6);
  r_seed = int(random(2147483647));
  n_seed = int(random(2147483647));
  randomSeed(r_seed);
  noiseSeed(n_seed);
  println("r_seed: "+r_seed);
  println("n_seed: "+n_seed);

  // clrs[#] palette
  // clrs[#][0] background
  // clrs[#][1] foreground
  clrs[0][0]=color(#F8F0D6);
  clrs[0][1]=color(#283040);
  clrs[1][0]=color(#F8F0D6);
  clrs[1][1]=color(#C85423);
  clrs[2][0]=color(#E0DCC0);
  clrs[2][1]=color(#007CB9);
  clrs[3][0]=color(#E3DFB3);
  clrs[3][1]=color(#E3C833);
  clrs[4][0]=color(#9A2624);
  clrs[4][1]=color(#7A1C19);




  int clr_idx = int(random(clrs.length));
  clr_1=color(clrs[clr_idx][0]);
  clr_2=color(clrs[clr_idx][1]);
  int base_th_width=18;
  n_off = 0;
  n_incr = -0.005;
  println("Movie Capture is: " + movie_capture);
}

void draw() {

  background(clr_1);
  fill(clr_2);
  noStroke();
  //stroke(clr_1);
  int c_pos_x, c_pos_y;
  for (int c_idx=0; c_idx<num_rows*num_cols; c_idx++) {
    c_pos_x = c_idx%num_cols*cell_w;
    c_pos_y = int(c_idx/num_cols)*cell_h;
    push();
    translate(c_pos_x+cell_w/2, c_pos_y+cell_h/2);
    int rot_pos = int(noise(n_off+c_pos_x/123.0, n_off+c_pos_y/123.0)*29);
    //int rot_pos = int(noise(n_off+c_pos_x/47.0,n_off+c_pos_y/47.0)*4);
    float rot = (TWO_PI/29)*rot_pos;
    rotate(rot);
    translate(-cell_w/2, -cell_h/2);
    triangle(0, 0, cell_w, 0, 0, cell_h);
    pop();
  }
  n_off += n_incr;

  if (movie_capture) {
    String saveFrame_fn ="frames_"+n_seed+"/genuary2024_day11_2-#####.tif";
    saveFrame(saveFrame_fn);
  }
}



// Keyboard input
void keyPressed() {
  if (key == 's' || key == 'S') {
    String export_filename ="genuary2024_day11_2-n_seed_"+n_seed+"-t_"+millis()/1000+".png";
    save(export_filename);
    println("saved to: "+export_filename);
  }
}
