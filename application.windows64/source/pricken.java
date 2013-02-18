import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class pricken extends PApplet {

/*
Prickspelet av Andreas Sandsk\u00e4r
 Till f\u00f6r en tankarna kring gps spelet att jaga pricken
 
 program som ritar upp en prick p\u00e5 sk\u00e4rmen,
 pricken ska slumpas vart p\u00e5 skr\u00e4men den hamnar,
 n\u00e4r pricken har satts p\u00e5 sk\u00e4rmen
 genom att r\u00f6ra pricken ska den f\u00f6rsvinna och en ny ritas upp
 avsluta programmet med att klicka i \u00f6versta v\u00e4nstra h\u00f6rnet.
 Po\u00e4ng skrivs till fil som highscore.
 */
 
float u, i, j, k, l, o;
int farg;
PrintWriter output;

public void setup() {
  size(150, 200);
  background(204);
  //startv\u00e4rden f\u00f6r bollen
  i = width;
  u = height;
  o = (height+width)/12;
  l = o/2;
  //rita upp bollen
  slumpa();
  boll();
  //po\u00e4ng
  output = createWriter("positions.txt");
}
public void draw() {
  rora();
  klicka();
  boll();
  point(mouseX, mouseY);
}

public void slumpa() {
  //bollen ska alltid hamna innom ramen f\u00f6r helheten
  // l\u00e4gsta talet ska allts\u00e5 vara bollens bredd
  // h\u00f6gsta talet ska vara ytans storlek minus bollens halva bredd.
  j = random(l, i-l);
  k = random(l, u-l);
}

public void boll() {
  fill(farg);
  ellipse(j, k, o, o);
}

public void rora() {
  //l\u00e4gg fram en ny boll och bakgrund n\u00e4r musen g\u00e5r \u00f6ver bollensyta
  // l\u00f6sningen \u00e4r falsk f\u00f6r ytan \u00e4r kvadatisk
  if (mouseX >= j-l && mouseX <= j+l && mouseY >= k-l && mouseY <= k+l) {
    //byt f\u00e4rg p\u00e5 den
    farg = farg + 25;
    if (farg > 255) {
      farg = 0;
    }
    //slmunpa nya v\u00e4rden f\u00f6r bollens possition
    slumpa();
    //rita \u00f6ver den gamla pricken
    background(204);
    //skriv in po\u00e4ng i filen
    output.println(mouseX);  // Write the coordinate to the file
  }
}
public void klicka() {
  //st\u00e4ng programmet med klick i v\u00e4nstra h\u00f6rnan
  if (mousePressed == true && mouseX <= j/12 && mouseY <= k/12) {
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
    exit();  // Stops the program
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pricken" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
