import interfascia.*;

public class CPseudoEditor{
  
  private int xPos, yPos;//position
  private int dimX, dimY;//dimensions
  private String name, tmpName;
  private static final int offset = 5;//space between Elements
  
  private boolean inEdition = false;
  
  //======Buttons
  IFButton editButton, deleteButton;
  IFTextField nameField;
  
  // Default constructor
  public CPseudoEditor (){
    this.xPos = 0;
    this.yPos = 0;
    this.dimX = 0;
    this.dimY = 0;
  }

  public CPseudoEditor (String name, int xPos, int yPos, int dimX, int dimY){
    this.name = name;
    this.tmpName = name;
    this.xPos = xPos;
    this.yPos = yPos;
    this.dimX = dimX;
    this.dimY = dimY;
    setButtons ();
  }
  
  private void setButtons (){
    
    this.editButton = new IFButton(
      "E",
      xPos + dimX - (dimY*2) + offset,
      yPos,
      dimY,
      dimY
    );
    
    this.deleteButton = new IFButton(
      "X",
      xPos + dimX - dimY +(offset*2),
      yPos,
      dimY,
      dimY
    );
    
    this.nameField = new IFTextField (
      name,
      xPos,
      yPos,
      xPos + dimX - ((dimY *2)+ offset * 5),
      name
    );
    
    GUIController gc = npntPseudoPicker.controller ();
    gc.add (editButton);
    gc.add (deleteButton);
    gc.add (nameField);
    
    textSize(dimY);
    text (this.name, (float)xPos, (float)yPos);
  }
  
  private void setEditMode (){
    
  }
  
  private void setReadMode (){
  
  }
  
  public void delete (){
    GUIController gc = npntPseudoPicker.controller();
    
    gc.remove (editButton);
    gc.remove (deleteButton);
    gc.remove (nameField);
  }
  
  void actionPerformed (GUIEvent e){
    //@TODO
  }
}