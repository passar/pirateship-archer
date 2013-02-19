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
int num = 2; 
Spring[] springs = new Spring[num]; 


void setup() {
  size(340, 550);
  i = width;
  u = height;
  o = (height+width)/12;
  l = o/2;

  springs[0] = new Spring(240, 260, 40, 0.98, 8.0, 0.1, springs, 0); 
  springs[1] = new Spring(320, 210, 120, 0.95, 9.0, 0.1, springs, 1); 
  

  //startvärden för bollen
  //rita upp bollen
  slumpa();
  boll();
  //poäng
  output = createWriter("positions.txt");
}
void draw() {
  background(204);
  for (int i = 0; i < num; i++) { 
    springs[i].update(); 
    springs[i].display();
  } 

  rora();
  klicka();
  boll();
  //  point(mouseX, mouseY);
  line(j, k, mouseX, mouseY);
}

void mousePressed() 
{
  for (int i = 0; i < num; i++) { 
    springs[i].pressed();
  }
}

void mouseReleased() 
{
  for (int i=0; i<num; i++) { 
    springs[i].released();
  }
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

class Spring 
{ 
  // Screen values 
  float xpos, ypos;
  float tempxpos, tempypos; 
  int size = 20; 
  boolean over = false; 
  boolean move = false; 

  // Spring simulation constants 
  float mass;       // Mass 
  float k = 0.2;    // Spring constant 
  float damp;       // Damping 
  float rest_posx;  // Rest position X 
  float rest_posy;  // Rest position Y 

  // Spring simulation variables 
  //float pos = 20.0; // Position 
  float velx = 0.0;   // X Velocity 
  float vely = 0.0;   // Y Velocity 
  float accel = 0;    // Acceleration 
  float force = 0;    // Force 

  Spring[] friends;
  int me;

  // Constructor
  Spring(float x, float y, int s, float d, float m, 
  float k_in, Spring[] others, int id) 
  { 
    xpos = tempxpos = x; 
    ypos = tempypos = y;
    rest_posx = x;
    rest_posy = y;
    size = s;
    damp = d; 
    mass = m; 
    k = k_in;
    friends = others;
    me = id;
  } 

  void update() 
  { 
    if (move) { 
      rest_posy = mouseY; 
      rest_posx = mouseX;
    } 

    force = -k * (tempypos - rest_posy);  // f=-ky 
    accel = force / mass;                 // Set the acceleration, f=ma == a=f/m 
    vely = damp * (vely + accel);         // Set the velocity 
    tempypos = tempypos + vely;           // Updated position 

    force = -k * (tempxpos - rest_posx);  // f=-ky 
    accel = force / mass;                 // Set the acceleration, f=ma == a=f/m 
    velx = damp * (velx + accel);         // Set the velocity 
    tempxpos = tempxpos + velx;           // Updated position 


    if ((overEvent() || move) && !otherOver() ) { 
      over = true;
    } 
    else { 
      over = false;
    }
  } 

  // Test to see if mouse is over this spring
  boolean overEvent() {
    float disX = tempxpos - mouseX;
    float disY = tempypos - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < size/2 ) {
      return true;
    } 
    else {
      return false;
    }
  }

  // Make sure no other springs are active
  boolean otherOver() {
    for (int i=0; i<num; i++) {
      if (i != me) {
        if (friends[i].over == true) {
          return true;
        }
      }
    }
    return false;
  }

  void display() 
  { 
    if (over) { 
      fill(153);
    } 
    else { 
      fill(255);
    } 
    ellipse(tempxpos, tempypos, size, size);
  } 

  void pressed() 
  { 
    if (over) { 
      move = true;
    } 
    else { 
      move = false;
    }
  } 

  void released() 
  { 
    move = false; 
    rest_posx = xpos;
    rest_posy = ypos;
  }
}

