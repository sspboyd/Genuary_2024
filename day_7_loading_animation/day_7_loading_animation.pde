//
//
//                        sspboyd.ca Stephen Boyd
//                        @sspboyd on Instagram/Threads/GitHub/YouTube/Vimeo......
//                        DM me with any question!





float PHI = 1.61803399;
float i_PHI = 0.61803399;

int window_w, window_h;

int rseed = int(random(100000000));
// int[] fib_seq = {2, 1, 3, 4, 7, 11, 18, 29, 47, 76, 123, 199, 322, 521, 843};
int[] fib_seq = {7,18};

// PGraphics c; // canvas
PGraphics curr_pct_pg;
PFont rockwell_bold;
float max_txt_w, max_txt_h;


int num_sections = 2700;
ImageSection[] img_sections = new ImageSection[num_sections];
int loading_duration_ms = 9*1000;
int curr_time;
int start_time;
PVector animation_loc = new PVector();
PVector animation_dims = new PVector();
// float curr_rot=0;

void settings() {

  window_h=540;
  // window_w=int((window_h/1920.0)*1080);
  window_w=window_h;
  // window_w=canv_w;
  // window_h=canv_h;

  size(window_w, window_h);

  println("rseed: "+rseed);
}


void setup() {
  rockwell_bold = createFont("Rockwell-Bold", 140);
  rectMode(CENTER);
  imageMode(CENTER);
  animation_loc.x = width/2;
  animation_loc.y = height/2;
  animation_dims.x = window_w;
  animation_dims.y = window_w;
  curr_pct_pg = createGraphics((int)animation_dims.x, (int)animation_dims.y);
  curr_pct_pg.beginDraw();
  curr_pct_pg.rectMode(CENTER);
  curr_pct_pg.textFont(rockwell_bold);
  curr_pct_pg.textAlign(RIGHT);
  curr_pct_pg.endDraw();
  max_txt_w = curr_pct_pg.textWidth("100%")*.97;
  max_txt_h = curr_pct_pg.textAscent()*1.15;

init();
}
void init(){
    for (int i = 0; i < img_sections.length; ++i) {
    int img_section_sz = fib_seq[(int)random(fib_seq.length)];
    // int img_section_sz = 47;
    int img_sec_x = (int)(random(max_txt_w)+((curr_pct_pg.width-max_txt_w)/2.0));
    int img_sec_y = (int)(random(max_txt_h)+((curr_pct_pg.height-max_txt_h)/2.0));
    // int img_sec_x = (int)(random(curr_pct_pg.width-img_section_sz)+((img_section_sz)/2.0));
    // int img_sec_x = (int)(random(curr_pct_pg.width-img_section_sz)+(img_section_sz/2.0));
    // int img_sec_y = (int)(random(curr_pct_pg.height-img_section_sz)+(img_section_sz/2.0));
    img_sections[i]=new ImageSection(img_section_sz, img_section_sz, img_sec_x, img_sec_y, random(-TWO_PI*0.15,TWO_PI*.05));
  }
  // println(img_sections[0]);
  start_time=millis();
  curr_time=start_time;
}
void draw() {
      background(0);
    curr_time=millis();
    float pct_done = float(curr_time-start_time)/loading_duration_ms;
    String curr_pct_str = str(floor(100*pct_done))+"%";
    curr_pct_pg.beginDraw(); 
    curr_pct_pg.background(0);
    curr_pct_pg.fill(255);
    curr_pct_pg.text(curr_pct_str, animation_dims.x/2+max_txt_w/2, animation_dims.y/2+max_txt_h/2);
    curr_pct_pg.endDraw();
  if (curr_time-start_time<loading_duration_ms) {
    for (ImageSection is : img_sections) {
      is.update(pct_done);
      is.render(curr_pct_pg);
    }
  } else {
        // image(curr_pct_pg,width/2,height/2);
   curr_pct_pg.beginDraw(); 
    curr_pct_pg.background(0);
    curr_pct_pg.fill(255);
    curr_pct_pg.text("100%", animation_dims.x/2+max_txt_w/2, animation_dims.y/2+max_txt_h/2);
    curr_pct_pg.endDraw();
 
    image(curr_pct_pg, animation_loc.x,animation_loc.y);
    // noLoop();
  }
  saveFrame("frames/#####.tif");
}

// Mouse functions
void mousePressed() {
}

void mouseDragged() {
}

void mouseReleased() {
}





// Keyboard input
void keyPressed() {
  if (key == 's' || key == 'S') {
    String export_filename ="genuary2024_day7-rseed_"+rseed+"-t_"+millis()/1000+".png";
    // c.save(export_filename);
    println("saved to: "+export_filename);
  }

  if (key == 'r' || key == 'R') {
init();
  }
}
