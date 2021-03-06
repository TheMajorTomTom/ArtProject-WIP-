//Window
int scWidth=800;
int scHeight=480;

//Palette
color selected = color(0);
color [] colors = {#000000,#666666,#999999,#FFFFFF
                  ,#5B0B0B,#AA0D0D,#C63B3B,#FF7070
                  ,#5B1F0B,#AA340D,#C65E3B,#FF9370
                  ,#5B330B,#AA5C0D,#C6813B,#FFB770
                  ,#5B470B,#AA830D,#C6A43B,#FFDB70
                  ,#5B5B0B,#AAAA0D,#C6C63B,#FFFF70
                  ,#475B0B,#83AA0D,#A4C63B,#DBFF70
                  ,#335B0B,#5CAA0D,#81C63B,#B7FF70
                  ,#1F5B0B,#34AA0D,#5EC63B,#93FF70
                  ,#0B5B0B,#0DAA0D,#3BC63B,#70FF70
                  ,#0B5B1F,#0DAA34,#3BC65E,#70FF93
                  ,#0B5B33,#0DAA5C,#3BC681,#70FFB7
                  ,#0B5B47,#0DAA83,#3BC6A4,#70FFDB
                  ,#0B5B5B,#0DAAAA,#3BC6C6,#70FFFF
                  ,#0B475B,#0D83AA,#3BA4C6,#70DBFF
                  ,#0B335B,#0D5CAA,#3B81C6,#70B7FF
                  ,#0B1F5B,#0D34AA,#3B5EC6,#7093FF
                  ,#0B0B5B,#0D0DAA,#3B3BC6,#7070FF
                  ,#1F0B5B,#340DAA,#5E3BC6,#9370FF
                  ,#330B5B,#5C0DAA,#813BC6,#B770FF
                  ,#470B5B,#830DAA,#A43BC6,#DB70FF
                  ,#5B0B5B,#AA0DAA,#C63BC6,#FF70FF
                  ,#5B0B47,#AA0D83,#C63BA4,#FF70DB
                  ,#5B0B33,#AA0D5C,#C63B81,#FF70B7};
int lat=4;
int dpb=12;

//Layer
PGraphics layer1;
int layerX=lat*(dpb+3)+4;
int layerY=3;
int layerWidth=scWidth-(lat*(dpb+3)+5)-2;
int layerHeight=scHeight-(layerY*2);


public class Location {
   int X;
   int Y;
   public Location(int tt, int tg) {
      X=tt;
      Y=tg;
   }
   public void setX( int tt ) {
      X = tt;
   }
   public int getX( ) {
      return X;
   }
   public void setY( int tg ) {
      Y = tg;
   }
   public int getY( ) {
      return Y;
   }
}
Location cartesian = new Location( 2, 2 );

public class GridGUI{
  Location location;
  PGraphics paletteGUI;
  color[]palettecolors;
  public GridGUI(int x, int y, color [] colorlist){
    location=new Location(x,y);
    paletteGUI=createGraphics((dpb+2)*lat+3,((colorlist.length+lat-1)/lat)*(dpb+2)+3);
  }
  public GridGUI(Location local,color[]colorlist){
    location=local;
    paletteGUI=createGraphics((dpb+2)*lat+3,((colorlist.length+lat-1)/lat)*(dpb+2)+3);
    paletteGUI.beginDraw();
    paletteGUI.strokeWeight(1);
    paletteGUI.fill(245,215,215);
    paletteGUI.stroke(0);
    paletteGUI.rect(0,0,(dpb+2)*lat+2,((colorlist.length+lat-1)/lat)*(dpb+2)+2);
    for(int i=0; i<colors.length;i++){
      paletteGUI.fill(colors[i]);
      paletteGUI.rect((i%lat)*(dpb+2)+2,i/lat*(dpb+2)+2,dpb,dpb);
    }
    paletteGUI.endDraw();
    palettecolors=colorlist;
  }
  public PGraphics display(){
    return paletteGUI;
  }
  public Location getLocation(){
    return location;
  }
  public color getColor(){
    Location inGrid=new Location(mouseX-location.getX()-2,mouseY-location.getY()-2);
    if(inGrid.getX()<paletteGUI.width-4){
      if(inGrid.getY()<paletteGUI.height-4){
        if(((inGrid.getY()-(inGrid.getY()%(dpb+2)))/(dpb+2))*lat+((inGrid.getX()-(inGrid.getX()%(dpb+2)))/(dpb+2))<palettecolors.length){
          return palettecolors[((inGrid.getY()-(inGrid.getY()%(dpb+2)))/(dpb+2))*lat+((inGrid.getX()-(inGrid.getX()%(dpb+2)))/(dpb+2))];
        }
      }
    }
    return selected;
  }
}

GridGUI defaultPalette;

void settings(){
  size(scWidth,scHeight);
}

void setup(){
  surface.setResizable(true);
  background(220);
  frameRate(120);
  noSmooth();
  //rect(layerX-1,layerY-1,layerWidth+1,layerHeight+1);
  if (args!=null){
    System.out.println(args.length);
  }
  layer1=createGraphics(layerWidth,layerHeight);
  layer1.noSmooth();
  defaultPalette=new GridGUI(cartesian,colors);
}

void mouseClicked(){
    selected=defaultPalette.getColor();
    System.out.println(hex(selected));
    
}

void draw(){
  if(mousePressed){
    //stroke(selected);
    //strokeWeight(3);
    layer1.beginDraw();
    layer1.stroke(selected);
    layer1.strokeWeight(3);
    //layer1.line(layer1.width*.5, layer1.height*.5, mouseX, mouseY);
    layer1.line(mouseX-layerX-1,mouseY-layerY-1,pmouseX-layerX-1,pmouseY-layerY-1);
    layer1.endDraw();
    //stroke(selected);
    //strokeWeight(3);
    //line(mouseX,mouseY,pmouseX,pmouseY);
    //point(mouseX,mouseY);
    //point((mouseX+pmouseX)/2,(mouseY+pmouseY)/2);
    //point((((mouseX+pmouseX)/2)+pmouseX)/2,(((mouseY+pmouseY)/2)+pmouseY)/2);
    //point((((mouseX+pmouseX)/2)+mouseX)/2,(((mouseY+pmouseY)/2)+mouseY)/2);
  }
  stroke(0);
  fill(255);
  rect(layerX-1,layerY-1,layerWidth+1,layerHeight+1);
  image(layer1,layerX,layerY);
  image(defaultPalette.display(),defaultPalette.getLocation().getX(),defaultPalette.getLocation().getY());
  //listcolors();
}