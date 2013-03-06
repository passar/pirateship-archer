/*
Prickspelet av Andreas Sandskär
 Till för en tankarna kring gps spelet att jaga pricken
 
 program som ritar upp en prick på skärmen,
 pricken ska slumpas vart på skrämen den hamnar,
 när pricken har satts på skärmen
 genom att röra pricken ska den försvinna och en ny ritas upp
 avsluta programmet med att klicka i översta vänstra hörnet.
 Poäng skrivs till fil som highscore.
 */

int antal = 3;
Bubb[] bubblare = new Bubb[antal];
Bubb sp1;

float c = 200, v = 200;

float u, i, j, k, l, o;
int farg;
PrintWriter output;


void setup() {
//  size(200, 400);
  i = width;
  u = height;
  o = (height+width)/12;
  l = o/2;
 
 //startvärden för bollen
  slumpa();
 
  //sp1 = new Bubb();
  
  bubblare[0] = new Bubb();
  slumpa();
  bubblare[1] = new Bubb();
  slumpa();
  bubblare[2] = new Bubb();


  //poäng
  output = createWriter("positions.txt");
}
void draw() {
  // background(204);

  //sp1.display();
  bubblare[0].display();
  bubblare[1].display();
  bubblare[2].display();

  rora();
  klicka();
  boll();
 // point(mouseX, mouseY);
  line(j, k, mouseX, mouseY);
}



void slumpa() {
  //bollen ska alltid hamna innom ramen för helheten
  // lägsta talet ska alltså vara bollens bredd
  // högsta talet ska vara ytans storlek minus bollens halva bredd.
  j = random(l, i-l);
  k = random(l, u-l);
}

//gör en class array av bollen så att den går att 
// röra på ett riktigt sätt med mouseEvent kanske
void boll() {
  //  noStroke();
  fill(farg);
  ellipse(j, k, o, o);
}

void rora() {
  //lägg fram en ny boll och bakgrund när musen går över bollensyta

    if (sqrt(sq(j - mouseX) + sq(k - mouseY)) < l ) {
    //byt färg på den
    farg = farg + 25;
    if (farg > 255) {
      farg = 0;
    }

    //slmunpa nya värden för bollens possition
    slumpa();
    //rita över den gamla pricken
    background(204);
    //skriv in poäng i filen
    output.println(mouseX);  // Write the coordinate to the file
  }
}
void klicka() {
  //stäng programmet med klick i vänstra hörnan
  if (mousePressed == true && mouseX <= j/8 && mouseY <= k/8) {
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
    exit();  // Stops the program
  }
}

//fula sättet med att göra områden runtomkring
//problemet är att det finns så många möjligheter
// alltså det är åtta runt om.
// träffa en så måste man fortsätta den vägen som är närmast antingen 
// medurs eller moturs.
// en fuling är att inte ta hänsyn till det och bara köra till att alla åtta är prickade
void omkring() {
  // top
  if (mouseX >= j-l && mouseX <= j+l && mouseY >= k-l && mouseY <= k+l) {
  }
}

class Bubb {
  Bubb[] andra;
  float x, y, diameter;
  
  Bubb() {
    andra = bubblare;
    x = c =j;
    y = v =k;
    diameter = l;
    
  }
  void display() {
    stroke(0);
    ellipse(x, y, diameter, diameter);
  }
}

