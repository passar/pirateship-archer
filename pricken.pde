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
 
float u, i, j, k, l, o;
int farg;
PrintWriter output;

void setup() {
  size(150, 200);
  background(204);
  //startvärden för bollen
  i = width;
  u = height;
  o = (height+width)/12;
  l = o/2;
  //rita upp bollen
  slumpa();
  boll();
  //poäng
  output = createWriter("positions.txt");
}
void draw() {
  rora();
  klicka();
  boll();
  point(mouseX, mouseY);
}

void slumpa() {
  //bollen ska alltid hamna innom ramen för helheten
  // lägsta talet ska alltså vara bollens bredd
  // högsta talet ska vara ytans storlek minus bollens halva bredd.
  j = random(l, i-l);
  k = random(l, u-l);
}

void boll() {
  fill(farg);
  ellipse(j, k, o, o);
}

void rora() {
  //lägg fram en ny boll och bakgrund när musen går över bollensyta
  // lösningen är falsk för ytan är kvadatisk
  if (mouseX >= j-l && mouseX <= j+l && mouseY >= k-l && mouseY <= k+l) {
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
  if (mousePressed == true && mouseX <= j/12 && mouseY <= k/12) {
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
    exit();  // Stops the program
  }
}

