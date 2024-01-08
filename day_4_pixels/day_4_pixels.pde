int window_w, window_h, canv_w, canv_h;
float PHI = 1.61803399;
float i_PHI = 0.61803399;
int rseed = int(random(10000000));
//int[] fib_seq = {4, 7, 29, 47, 199, 322 };
int[] fib_seq = {1, 3, 4, 7, 11, 18, 29, 47, 76, 123, 199, 322, 521, 843};
PGraphics c; // short for canvas
PImage base_img;
//float matte_dim, plt_x1, plt_x2, plt_y1, plt_y2, plt_w, plt_h;
//int[] num_sqrs = fib_seq;
//int[] num_sqrs = {7, 11, 47, 199 };
//float  frame_ratio = pow(i_PHI, 5);
float x_img_scale, y_img_scale;
PVector pxl_line_1, pxl_line_2;


String[] base_img_strs = {"Barack_Obama_2004.jpg", "cindy_crawford.png", "beethoven.jpg", "ingres.jpg", "christus.jpg", "vermeer.jpg", "van_gogh.jpg", "Jack_Nicholson_2002.jpg","van_gogh2.jpg", "holbein.jpg"};
int img_idx = int(random(base_img_strs.length));


void settings() {
  //base_img=loadImage("Barack_Obama_2004.jpg");
  //base_img=loadImage("van_gogh.jpg");
  //base_img=loadImage("van_gogh2.jpg");
  base_img=loadImage(base_img_strs[img_idx]);
  canv_w=base_img.width;
  canv_h=base_img.height;
  window_w=canv_w;
  window_h=canv_h;
  int base_img_max_dim = max(base_img.width, base_img.height);
  size(window_w, window_h);
  //size(540, 960);
  //size(800, 1000);

  x_img_scale = base_img.width/window_w;
  y_img_scale = base_img.height/window_h;

  randomSeed(rseed);
  //randomSeed(1);
  println(rseed);

  //matte_dim = min(canv_w, canv_h)*frame_ratio;
  //plt_x1 = matte_dim;
  //plt_x2 = canv_w-matte_dim;
  //plt_y1 = matte_dim;
  //plt_y2 = canv_h-matte_dim;
  //plt_w = plt_x2-plt_x1;
  //plt_h = plt_y2-plt_y1;
}


// get sqr(


void setup() {
  background(255);
  rectMode(CENTER);
  c = createGraphics(canv_w, canv_h);
  //c.smooth(3);
  c.beginDraw();
  c.clear();
  c.noStroke();
  c.rectMode(CENTER);
  c.image(base_img, 0, 0);
  c.endDraw();

  pxl_line_1 = new PVector(0, 0);
  pxl_line_2 = new PVector(0, 0);
}

void draw() {
  background(255);
  image(c, 0, 0, window_w, window_h);
  if (mousePressed == true) {

    int max_num_boxes = int(pxl_line_1.dist(pxl_line_2)*i_PHI);
    //int max_num_boxes = 100;
    int num_layers= 18;
    noStroke();
    //c.stroke(255,0,0);
    PVector curr_box = new PVector();
    int max_pxl_sz = int(max(2, pxl_line_1.dist(pxl_line_2)*pow(i_PHI, 2)));

    for (int l=0; l<num_layers; l++) {
      int layer_pxl_sz = int(max_pxl_sz/(l+1));
      int layer_num_boxes = int(max_num_boxes/(num_layers-l));
      int alpha_val = 255*max_num_boxes/(num_layers-l);
      for (int b=0; b<layer_num_boxes; b++) {

        curr_box.x = map(b, 0, layer_num_boxes, pxl_line_1.x, pxl_line_2.x);
        curr_box.y = map(b, 0, layer_num_boxes, pxl_line_1.y, pxl_line_2.y);
        float layer_offset_amt = (max_pxl_sz - layer_pxl_sz)/2;
        int base_img_x = int(curr_box.x);
        int base_img_y = int(curr_box.y);
        base_img_x += int(random(-layer_offset_amt, layer_offset_amt));
        base_img_y += int(random(-layer_offset_amt, layer_offset_amt));
        //base_img_x += int(random(-10, 10));
        //base_img_y += int(random(-10, 10));
        color curr_clr = color(base_img.get(int(base_img_x*x_img_scale), int(base_img_y*y_img_scale)), alpha_val);
        //curr_clr.alpha(alpha_val);
        //c.beginDraw();
        fill(curr_clr);
        rect(base_img_x, base_img_y, layer_pxl_sz, layer_pxl_sz);
        //c.endDraw();
      }
    }





    //println("mouse is pressed! "+millis()/100);
    pxl_line_2.x=mouseX;
    pxl_line_2.y=mouseY;
    stroke(255,150);
    line(pxl_line_1.x-1, pxl_line_1.y-1, pxl_line_2.x-1, pxl_line_2.y-1);
    stroke(0,150);
    line(pxl_line_1.x, pxl_line_1.y, pxl_line_2.x, pxl_line_2.y);
    fill(255,150);
    ellipse(pxl_line_1.x,pxl_line_1.y,18,18);
    fill(0,150);
    ellipse(pxl_line_2.x,pxl_line_2.y,18,18);
    noStroke();
  }
}

void mousePressed() {
  pxl_line_1.x = mouseX;
  pxl_line_1.y = mouseY;
  pxl_line_2.x=mouseX;
  pxl_line_2.y=mouseY;
}

void mouseClicked() {
}

void mouseDragged() {
  pxl_line_2.x=mouseX;
  pxl_line_2.y=mouseY;
  //stroke(255);
  //line(pxl_line_1.x-1, pxl_line_1.y-1, pxl_line_2.x-1, pxl_line_2.y-1);
  //stroke(0);
  //line(pxl_line_1.x, pxl_line_1.y, pxl_line_2.x, pxl_line_2.y);
  //noStroke();
}

void mouseReleased() {
  render_boxes(pxl_line_1, pxl_line_2);
}

void render_boxes(PVector p1, PVector p2) {

  int max_num_boxes = int(p1.dist(p2)*i_PHI);
  //int max_num_boxes = 100;
  int num_layers= 18;
  c.noStroke();
  //c.stroke(255,0,0);
  PVector curr_box = new PVector();
  int max_pxl_sz = int(max(2, p1.dist(p2)*pow(i_PHI, 2)));

  for (int l=0; l<num_layers; l++) {
    int layer_pxl_sz = int(max_pxl_sz/(l+1));
    int layer_num_boxes = int(max_num_boxes/(num_layers-l));
    int alpha_val = 255*max_num_boxes/(num_layers-l);
    for (int b=0; b<layer_num_boxes; b++) {

      curr_box.x = map(b, 0, layer_num_boxes, p1.x, p2.x);
      curr_box.y = map(b, 0, layer_num_boxes, p1.y, p2.y);
      float layer_offset_amt = (max_pxl_sz - layer_pxl_sz)/2;
      int base_img_x = int(curr_box.x * x_img_scale);
      int base_img_y = int(curr_box.y * y_img_scale);
      base_img_x += int(random(-layer_offset_amt, layer_offset_amt));
      base_img_y += int(random(-layer_offset_amt, layer_offset_amt));
      //base_img_x += int(random(-10, 10));
      //base_img_y += int(random(-10, 10));
      color curr_clr = color(base_img.get(base_img_x, base_img_y), alpha_val);
      //curr_clr.alpha(alpha_val);
      c.beginDraw();
      c.fill(curr_clr);
      c.rect(base_img_x, base_img_y, layer_pxl_sz, layer_pxl_sz);
      c.endDraw();
    }
  }
}



void keyPressed() {
  if (key == 's' || key == 'S') {
    String export_filename ="genuary2024_day4_"+rseed+".png";
    c.save(export_filename);
    println("saved to: "+export_filename);
  }
  if (key == 'r' || key == 'R') {
    c.beginDraw();
    c.clear();
    c.image(base_img, 0, 0, canv_w, canv_h);
    c.endDraw();
  }
  if (key == 'n' || key == 'N') {
    img_idx = img_idx < base_img_strs.length-1 ? img_idx + 1 : 0;
    base_img = loadImage(base_img_strs[img_idx]);
    x_img_scale = base_img.width/window_w;
    y_img_scale = base_img.height/window_h;
    c.beginDraw();
    c.clear();
    c.image(base_img, 0, 0, canv_w, canv_h);
    c.endDraw();
  }
}
