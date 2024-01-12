// __ _ ___ ____ _______ ___________ __________________ ___________ _______ //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
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
float n_off, n_incr;
int window_w, window_h;
int num_rows, num_cols;
int num_rows_fact, num_cols_fact;
int rot_fact;
color clr_1, clr_2;
int cell_w, cell_h;
int clr_pal;
int[] fact_opts = {4, 7, 11, 18, 29, 47, 76, 123, 199};
//String export_fn;
String fn_params; 

int mov_len_ms;
int frame_rate;

color[][] clrs = new color[7][2];
boolean movie_capture = false;

void settings() {
  int target_window_w=1080;
  int target_window_h=1920;
  r_seed = int(random(2147483647));
  // r_seed = 1590494208;
  //r_seed = 1431188480;
  //r_seed =   1017447296;


  randomSeed(r_seed);
  noiseSeed(r_seed);

  num_cols_fact = fact_opts[int(random(fact_opts.length))];
  num_rows_fact = fact_opts[int(random(fact_opts.length))];
  rot_fact = fact_opts[int(random(fact_opts.length))];
  num_rows = int(target_window_w/num_rows_fact);
  num_cols = int(target_window_h/num_cols_fact);
  //num_rows = int(target_window_w*pow(i_PHI, 7));
  //num_cols = int(target_window_h*pow(i_PHI, 7));

  cell_w = int(target_window_w/num_cols);
  cell_h = int(target_window_h/num_rows);
  window_w = cell_w*num_cols;
  window_h = cell_h*num_rows;
  size(window_w, window_h);
}

void setup() {
  //mov_len_ms = 9*1000;
  //frameRate(frame_rate);
  // clrs[#] palette
  // clrs[#][0] background
  // clrs[#][1] foreground
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

  n_off = 0;
  n_incr = -0.005;

 fn_params = "r_seed_"+r_seed+"-clr_pal_"+clr_pal+"-row_f_"+num_rows_fact+"-col_f_"+num_cols_fact+"-rot_f_"+rot_fact+"";



  noStroke();
  println("Movie Capture is: " + movie_capture);
  println("r_seed: "+r_seed);
  println("clr_pal: "+clr_pal);
  println("num_cols_fact: "+num_cols_fact);
  println("num_rows_fact: "+num_rows_fact);
  println("rot_fact: "+rot_fact);
}

void draw() {
  background(clr_1);
  fill(clr_2);

  int c_pos_x, c_pos_y;
  for (int c_idx=0; c_idx<num_rows*num_cols; c_idx++) {
    c_pos_x = c_idx%num_cols*cell_w;
    c_pos_y = int(c_idx/num_cols)*cell_h;
    push();
    translate(c_pos_x+cell_w/2, c_pos_y+cell_h/2);
    int rot_pos = int(noise(n_off+c_pos_x/123.0, n_off+c_pos_y/123.0)*rot_fact);
    //int rot_pos = int(noise(n_off+c_pos_x/47.0,n_off+c_pos_y/47.0)*4);
    float rot = (TWO_PI/rot_fact)*rot_pos;
    rotate(rot);
    translate(-cell_w/2, -cell_h/2);
    triangle(0, 0, cell_w, 0, 0, cell_h);
    pop();
  }
  n_off += n_incr;

  if (movie_capture) {
    String saveFrame_fn ="frames_"+r_seed+"/genuary2024_day11_2-"+fn_params+"-#####.png";
    saveFrame(saveFrame_fn);
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
    movie_capture=(movie_capture)?false:true;
    println("Saving Frames: "+movie_capture);
  }
}
