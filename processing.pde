PShader toon;
float time;
PGraphics pg1;
PGraphics pg2;

void setup() {
  time = 0;
  size(1024, 1024, P2D);
  noStroke();
  toon = loadShader("frag.glsl", "vert.glsl");
  toon.set("resolution", width, height);
  pg1 = createGraphics(1024, 1024, P2D);
  pg2 = createGraphics(1024, 1024, P2D);
}

void draw() {
  toon.set("time", time);
  toon.set("backbuffer", time%2==1?pg1:pg2);
  toon.set("mouse", (float)mouseX, height - (float)mouseY);
  PGraphics pg = time%2==0?pg1:pg2;
  pg.beginDraw();
  pg.shader(toon);
  pg.background(0);
  pg.rect(0,0,width,height);
  pg.endDraw();
  image(pg, 0, 0); 
  time += 1;
}