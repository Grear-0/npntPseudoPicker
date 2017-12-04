import interfascia.*;

String [] pseudosList;
PImage
  tartineImage, // ULTIMATE Tartine Button !!
  settingsImage
; 

private static GUIController gc; // our GUI controller that manage UI elements

String randPseudo;

int mode = 1; // Actual mode

final static int
  SETTINGS = 0,
  PICK = 1,
  WELCOME = 2
;


void setup (){
  size (500, 500);
  
  //Init UI
  gc = new GUIController (this);
  
  //Init pseudos
  loadPseudos ();
  randPseudo = getRandom (sortPseudos(false));
}

void draw (){
  noLoop ();
  if (mode == SETTINGS){
    drawSettings ();
  }
  else if (mode == PICK){
    textSize (24);
    text (randPseudo, 10, 30);
  }
  else{
    //Draw the Tartine Button
    //Set mode to PICK on click.
  }
}

//==========SETTINGS========
void drawSettings (){
  // Background =====
  noStroke ();
  color c = color (255, 5f);
  fill (c);
  rect (
    25,
    25,
    width - 50,
    height - 50, 
    7 // rounded corners
  );
  //=======EDIT FIELDS=====
  CPseudoEditor[] editors = new CPseudoEditor[pseudosList.length];
  
  for (int i = 0; i < pseudosList.length; i++){
    editors[i] = new CPseudoEditor (pseudosList[i], 30, 10 + (i*20), width - 60, 20);
  }
  gc.draw();
}



//========PICKING===========
String getRandom (String[] pseudos){
  int r = (int)random (0, pseudos.length);
  
  return clearPseudo (pseudos[r]);
}

/**
@Description: Here we load all pseudos in the Pseudos's file.
*/
void loadPseudos (){
  pseudosList = loadStrings ("datas/pseudos.dat");
}

/**
Clear unwanted character at start of the Pseudo p.
*/
String clearPseudo (String p){
  if (p.charAt(0) == '*'){
    StringBuilder sb = new StringBuilder (p);
    sb.deleteCharAt (0);
    return sb.toString ();
  }
  else return p;
}

String[] sortPseudos (boolean picked){
  ArrayList<String> sortedPseudos = new ArrayList<String>();
  
  // @TODO optimize it
  for (int i = 0; i < pseudosList.length; i++){
    
    if (pseudosList[i].charAt(0) == '*' && picked){
      sortedPseudos.add (pseudosList[i]);
    }
    else if (pseudosList[i].charAt (0) != '*' && !picked){
      sortedPseudos.add (pseudosList[i]);
    }
  }
  String r[] = new String[sortedPseudos.size()];
  return sortedPseudos.toArray (r);
}

public static GUIController controller (){
  return gc;
}

void actionPerformed (GUIEvent e){
}