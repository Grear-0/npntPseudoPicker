import interfascia.*;

String [] pseudosList; // all pseudos

PImage
  tartineImage, // ULTIMATE Tartine Button !!
  settingsImage
; 

private static GUIController gc; // our GUI controller that manage UI elements

private static IFButton paramButton;

String randPseudo; // picked pseudo

int mode = 1, modeDelta = 2; // Actual mode and previous mode (must be different at start)

final static int
  SETTINGS = 0,
  PICK = 1,
  WELCOME = 2
;


void setup (){
  size (500, 500);
  
  //Init UI
  gc = new GUIController (this);
  
  paramButton = new IFButton ("P", width - 60, 10, 50, 50);
  
  //Init pseudos
  loadPseudos ();
  randPseudo = getRandom (sortPseudos(false));
}

void draw (){
  if (mode != modeDelta){
    
    mode = modeDelta;
    if (mode == SETTINGS){
      drawSettings ();
    }
    else if (mode == PICK){
      int decal = (int)randPseudo.chars().count() * 7;
      textSize (32);
      text (randPseudo, width/2 - decal, height/2);
    }
    else{
      drawWelcomeScreen();
      //Draw the Tartine Button
      //Set mode to PICK on click.
    }
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

//========WELCOME===========
private void drawWelcomeScreen (){
  gc.add (paramButton);
  paramButton.addActionListener (this);
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
  if (e.getSource() == paramButton){
    modeDelta = 0;
  }
}