// __ _ ___ ____ _______ ___________ __________________ ___________ _______
//
//    GENUARY 2024, Day 11 #2, Inspired by Anni Albers
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

int window_w, window_h;
int r_seed; // using the same number for both random and noise seeds

// variables for noise offsets, origin and radius
// radius is needed since we're using polar coordinates and sampling
// in a circle around an origin point.
float n_off_orig_x, n_off_orig_y, n_off_radius;
float n_off_x, n_off_y;

int num_rows, num_cols;
int num_rows_fact, num_cols_fact;
int rot_fact;

color clr_1, clr_2;
int cell_w, cell_h;
int clr_pal;
int[] fact_opts = {4, 7, 11, 18, 29, 47, 76, 123, 199};

// this is used in the save and saveFrame functions
String fn_params;

// int mov_len;
int frame_rate = 9;
int max_frames, curr_frame;
boolean movie_capture = false;

void settings() {
  // This is the target we're aiming for. The actual window size will be
  // dependent on the width/height of the rows and columns
  int target_window_w=1080;
  int target_window_h=1080;


  r_seed = int(random(2147483647));
  // r_seed = 137617152;
  // r_seed = 1590494208;
  //r_seed = 1431188480;
  //r_seed =   1017447296;

  // Declaring theses here since we need it to figure out window sizing
  randomSeed(r_seed);
  noiseSeed(r_seed);

  num_cols_fact = fact_opts[int(random(fact_opts.length))];
  num_rows_fact = fact_opts[int(random(fact_opts.length))];
  // num_cols_fact = 47;
  // num_rows_fact = 4;

  num_rows = int(target_window_w/num_rows_fact);
  num_cols = int(target_window_h/num_cols_fact);

  cell_w = int(target_window_w/num_cols);
  cell_h = int(target_window_h/num_rows);
  window_w = cell_w*num_cols;
  window_h = cell_h*num_rows;
  size(window_w, window_h);
}

void setup() {
  frameRate(frame_rate);
  noStroke();

  rot_fact = fact_opts[int(random(fact_opts.length))];

  n_off_x=0;
  n_off_y=0;
  n_off_orig_x=0;
  n_off_orig_y=0;
  n_off_radius=i_PHI*11;

  // These variables control how many frames are captured for a movie
  int mov_len = 30; // in seconds
  max_frames = mov_len*frame_rate;


  // Colours sampled from Anni Albers prints and woven works.
  // clrs[#] palette
  // clrs[#][0] background
  // clrs[#][1] foreground
  color[][] clrs = new color[7][2];
  clrs[0][0]=color(#F8F0D6);
  clrs[0][1]=color(#283040);

  clrs[1][0]=color(#F8F0D6);
  clrs[1][1]=color(#C85423);// //

  clrs[2][0]=color(#E0DCC0);
  clrs[2][1]=color(#007CB9);// //

  clrs[3][0]=color(#E3DFB3);
  clrs[3][1]=color(#E3C833);//

  clrs[4][0]=color(#9A2624);
  clrs[4][1]=color(#7A1C19);// //

  clrs[5][0]=color(#D4C66C);
  clrs[5][1]=color(#898794);// //

  clrs[6][0]=color(#9590A5);
  clrs[6][1]=color(#635E7F);// //

  clr_pal = int(random(clrs.length));
  clr_1=color(clrs[clr_pal][0]);
  clr_2=color(clrs[clr_pal][1]);

  fn_params = "r_seed_"+r_seed+"-clr_pal_"+clr_pal+"-row_f_"+num_rows_fact+"-col_f_"+num_cols_fact+"-rot_f_"+rot_fact+"";

  println("r_seed: "+r_seed);
  println("clr_pal: "+clr_pal);
  println("num_cols_fact: "+num_cols_fact);
  println("num_rows_fact: "+num_rows_fact);
  println("rot_fact: "+rot_fact);
}

void draw() {
  background(clr_1);
  fill(clr_2);

  // Update the x/y locations for sampling perlin noise
  float curr_radius = 1.0*(curr_frame%max_frames)/(1.0*max_frames)*TWO_PI;
  n_off_x = n_off_orig_x + (cos(curr_radius))*n_off_radius/2;
  n_off_y = n_off_orig_y + (sin(curr_radius))*n_off_radius/2;
  curr_frame++;

  int c_pos_x, c_pos_y; // declaring the var that will hold x/y position of
  // each triangle being draw below
  for (int c_idx=0; c_idx<num_rows*num_cols; c_idx++) { // iterate through cells
    c_pos_x = c_idx%num_cols*cell_w;
    c_pos_y = int(1.0*c_idx/num_cols)*cell_h;

    push();
    // go to the middle of each cell
    translate(c_pos_x+cell_w/2, c_pos_y+cell_h/2); 
    // get the rotation position
    int rot_pos = int(noise(n_off_x+c_pos_x/123.0, n_off_y+c_pos_y/123.0)*rot_fact);
    // int rot_pos = int(noise(n_off+c_pos_x/123.0, n_off+c_pos_y/123.0)*rot_fact);
    //int rot_pos = int(noise(n_off+c_pos_x/47.0,n_off+c_pos_y/47.0)*4);
    
    // get the rotation position in radians
    float rot = (TWO_PI/rot_fact)*rot_pos;
    rotate(rot);
    // move back to the upper left corner of the cell
    // translate(-cell_w/2, -cell_h/2); 
    // triangle(0, 0, cell_w, 0, 0, cell_h);
    triangle(-cell_w/2, -cell_h/2, cell_w/2, -cell_h/2, -cell_w/2, cell_h/2);
    pop();
  }

  if (movie_capture) {
    if (curr_frame<max_frames) {
      String saveFrame_fn ="frames/"+r_seed+"/genuary2024_day11_2-"+fn_params+"-#####.png";
      saveFrame(saveFrame_fn);
    } else {
      movie_capture=false;
      println("Saving Frames: "+movie_capture);
      println(curr_frame);
    }
  }
}



// Keyboard input
void keyPressed() {
  if (key == 's' || key == 'S') {
    String export_filename ="genuary2024_day11_2-"+fn_params+"-t_"+millis()/1000+".png";
    save(export_filename);
    println("saved to: "+export_filename);
  }

  if (key == 'f' || key == 'F') {
    if (movie_capture) {
      movie_capture=false;
      // curr_frame=0;
    } else {
      movie_capture=true;
      curr_frame=0;
    }
    println("Saving Frames: "+movie_capture);
    println("curr_frame: "+curr_frame);
  }
}
