/*A remake of the textArt program from scratch

-import an image and use its resolution
-from a scaling variable, determine the sketch size from the image size

*/


//SETTINGS
//Set up the image scaling
  float scale = 1;//Scale up for higher resolutions
  float pixelation = 15;//Determines how degraded the image is.
  String textToDraw = "12345678901 23456    7890";
  PImage img;
  String imgName = "IMG.jpg";//Note that the size must be changed to the resolution of this image manually.


//---------------------------------------------------------------------------------------------------
void setup(){
  size(1280,799);//Note that if an index out of bounds exception comes up, try adding 1 to one of the values.
  noLoop();
}


//---------------------------------------------------------------------------------------------------
void draw(){
  img = loadImage(imgName);
  background(255);
  
  String[] lines = loadStrings("textToDraw.txt");
  for(String line : lines){
    textToDraw = textToDraw + "{" + line.toLowerCase();
  }
  
  drawText(textToDraw);
  save("output.jpg");
}


//---------------------------------------------------------------------------------------------------
void drawText(String s){
  //Set up the font sizing
  int charsPerRow = width/(int) pixelation;//Determine how many pixels/characters will go on one row
  int charsPerColumn = height/(int) pixelation;//Same with columns
  float fontSize = (width/charsPerRow)/0.625;//set the font size so that it will fit exactly
  PFont f = createFont("blockFont.ttf",fontSize);
  textFont(f);
  
  s = s.replace(' ','{'); //For the font, make spaces appear as blank tiles.
  
  //See how many characters are needed in total to fill the picture:
  float totalCharacters = (width/pixelation) * (height/pixelation);
  
  //Now cut the text down, or pad the text out to size:
  if(s.length() > totalCharacters){
    s = s.substring(0,(int) totalCharacters);
  }else{
    float padCount = totalCharacters-s.length();
    for(int i=0;i<padCount;i++){s+="{";}
  }
  
  //Get the pixel data and reference using pixels[] (can be found on the processing reference)
  image(img,0,0);
  loadPixels();
  background(255);
  
  int xpos;
  int ypos;
  
  //Draw each character one by one
  int characterIndex = 0;
  for(int r=0;r<charsPerColumn;r++){//for each row
    for(int c=0;c<charsPerRow;c++){//each character in said row
      xpos = (width/charsPerRow)*c;
      ypos = (height/charsPerColumn)*(r+1);
    
      fill(pixels[xpos + ypos*width]);
      text(s.substring(characterIndex,characterIndex+1),xpos,ypos);
      characterIndex ++;
    }
  }
  
}