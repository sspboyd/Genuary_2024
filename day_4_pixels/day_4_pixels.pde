float PHI = 1.61803399;
float i_PHI = 0.61803399;

int window_w, window_h, canv_w, canv_h;

int rseed = int(random(100000000));
//int[] fib_seq = {2, 1, 3, 4, 7, 11, 18, 29, 47, 76, 123, 199, 322, 521, 843};

PGraphics c; // canvas
PImage base_img;
PVector pxl_line_1, pxl_line_2;

int num_layers = 47;

String[] base_img_strs = {"Barack_Obama_2004.jpg",
  "cindy_crawford.png", "beethoven.jpg",
  "ingres.jpg", "christus.jpg", "vermeer.jpg",
  "van_gogh.jpg", "Jack_Nicholson_2002.jpg",
  "van_gogh2.jpg", "holbein.jpg"};

int img_idx = int(random(base_img_strs.length));


void settings() {
  base_img=loadImage(base_img_strs[img_idx]);

  canv_w=base_img.width;
  canv_h=base_img.height;
  window_w=canv_w;
  window_h=canv_h;

  size(window_w, window_h);

  println("rseed: "+rseed);
}


void setup() {
  rectMode(CENTER);
  c = createGraphics(canv_w, canv_h);
  c.beginDraw();
  c.noStroke();
  c.rectMode(CENTER);
  c.image(base_img, 0, 0);
  c.endDraw();

  pxl_line_1 = new PVector();
  pxl_line_2 = new PVector();
}

void draw() {
  image(c, 0, 0, window_w, window_h);

  if (mousePressed == true) {
    PVector curr_box = new PVector();

    int max_num_boxes = int(pxl_line_1.dist(pxl_line_2)*i_PHI);
    int max_pxl_sz = int(max(2, pxl_line_1.dist(pxl_line_2)*pow(i_PHI, 2)));

    for (int l=0; l<num_layers; l++) {
      int layer_pxl_sz = int(max_pxl_sz/(l+1));
      int layer_num_boxes = int(max_num_boxes/(num_layers-l));

      for (int b=0; b<layer_num_boxes; b++) {
        curr_box.x = map(b, 0, layer_num_boxes, pxl_line_1.x, pxl_line_2.x);
        curr_box.y = map(b, 0, layer_num_boxes, pxl_line_1.y, pxl_line_2.y);

        float layer_offset_amt = (max_pxl_sz - layer_pxl_sz)/2;

        int base_img_x = int(curr_box.x);
        int base_img_y = int(curr_box.y);
        base_img_x += int(random(-layer_offset_amt, layer_offset_amt));
        base_img_y += int(random(-layer_offset_amt, layer_offset_amt));
        color curr_clr = base_img.get(base_img_x, base_img_y);

        noStroke();
        fill(curr_clr);
        rect(base_img_x, base_img_y, layer_pxl_sz, layer_pxl_sz);
      }
    }
    // Update x/y pos for end of the line.
    pxl_line_2.x=mouseX;
    pxl_line_2.y=mouseY;

    // Draw the line with dots on the ends
    stroke(255, 150);
    line(pxl_line_1.x-1, pxl_line_1.y-1, pxl_line_2.x-1, pxl_line_2.y-1);

    stroke(0, 150);
    line(pxl_line_1.x, pxl_line_1.y, pxl_line_2.x, pxl_line_2.y);

    fill(255, 150);
    ellipse(pxl_line_1.x, pxl_line_1.y, 18, 18);

    fill(0, 150);
    ellipse(pxl_line_2.x, pxl_line_2.y, 18, 18);
    noStroke();
  }
}

// Mouse functions
void mousePressed() {
  // Set start position for the line
  pxl_line_1.x = mouseX;
  pxl_line_1.y = mouseY;
}

void mouseDragged() {
  // Update the end position for the line
  pxl_line_2.x=mouseX;
  pxl_line_2.y=mouseY;
}

void mouseReleased() {
  // When you let go of the mouse button, draw the 'pixels' (boxes).
  render_boxes(pxl_line_1, pxl_line_2);
}

void render_boxes(PVector p1, PVector p2) {
  int max_num_boxes = int(p1.dist(p2)*i_PHI);
  int max_pxl_sz = int(max(2, p1.dist(p2)*pow(i_PHI, 2)));

  for (int l=0; l<num_layers; l++) {
    int layer_pxl_sz = int(max_pxl_sz/(l+1));
    int layer_num_boxes = int(max_num_boxes/(num_layers-l));
    int alpha_val = 255*max_num_boxes/(num_layers-l);
    for (int b=0; b<layer_num_boxes; b++) {
      PVector curr_box = new PVector();
      curr_box.x = map(b, 0, layer_num_boxes, p1.x, p2.x);
      curr_box.y = map(b, 0, layer_num_boxes, p1.y, p2.y);
      float layer_offset_amt = (max_pxl_sz - layer_pxl_sz)/2;
      
      int base_img_x = int(curr_box.x);
      int base_img_y = int(curr_box.y);
      base_img_x += int(random(-layer_offset_amt, layer_offset_amt));
      base_img_y += int(random(-layer_offset_amt, layer_offset_amt));
      
      color curr_clr = color(base_img.get(base_img_x, base_img_y), alpha_val);
      
      c.beginDraw();
      c.fill(curr_clr);
      c.rect(base_img_x, base_img_y, layer_pxl_sz, layer_pxl_sz);
      c.endDraw();
    }
  }
}


// Keyboard input
void keyPressed() {
  if (key == 's' || key == 'S') {
    String export_filename ="genuary2024_day4-rseed_"+rseed+"-t_"+millis()/1000+".png";
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
    c.beginDraw();
    c.clear();
    c.image(base_img, 0, 0, canv_w, canv_h);
    c.endDraw();
  }
}
