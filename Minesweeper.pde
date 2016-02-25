import de.bezier.guido.*;
boolean mark;
public boolean lost;
private boolean gameOver = false;
public int TOTAL, xx, yy;
private int numMarkedBombs = 0;
private int NUM_ROWS = 20;
private int NUM_COLS = 20;//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons;
private MSButton[][] buttons1;
private MSButton restartbutton; //2d array of minesweeper buttons
private MSButton flagButton;
private UIButton markbutton;
private ArrayList <MSButton> bombs = new ArrayList <MSButton> ();
private ArrayList <MSButton> bombs1 = new ArrayList <MSButton> ();
//ArrayList of just the minesweeper buttons that are mined
void setup ()
{
  size(600, 400);
  textAlign(CENTER, CENTER);
  // make the manager
  Interactive.make( this );
  markbutton = new UIButton(0, 0);
  markbutton.x =400;
  markbutton.y =100;
  markbutton.width = 200;
  markbutton.height = 100;
  markbutton.setLabel("CHEAT");
  flagButton = new MSButton(0, 0);
  flagButton.x =400;
  flagButton.y =200;
  flagButton.width = 200;
  flagButton.height = 100;
  flagButton.setLabel("TURN ON TO FLAG");
  restartbutton = new MSButton(0, 0);
  restartbutton.x =400;
  restartbutton.y = 0;
  restartbutton.width = 200;
  restartbutton.height = 100;
  restartbutton.setLabel("+BOMBS");
  buttons = new MSButton [NUM_ROWS] [NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }
  //declare and initialize buttons
  setBombs();
}
public void setBombs()
{
  int x = 0;
  while (x < 50) {
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    if (!bombs.contains(buttons[row][col])) {
      bombs.add(buttons[row][col]);
    }
    x++;
  }
  //your code
}
public void draw ()
{
  background( 0 );
  fill(xx, yy, 0);
  rect(425, 325, 150, 50);
  fill(100);
  rect(462.5, 337.5, 75, 25);
  for (int i = 0; i < NUM_ROWS; i++) {
    for (int j = 0; j < NUM_COLS; j++) {
      if (markbutton.isClicked()==true) {  
        buttons[i][j].cheatmark = true;
        buttons[i][j].Color3 = 255;
        System.out.println(buttons[i][j].Color3);
      }
    }
  }
  if (isWon()==true) {
    displayWinningMessage();
    yy=255;
  }
  if (lost==true)
  {
    xx=255;
  }
  for (int x = 0; x< bombs.size(); x++) {
    if (bombs.get(x).isMarked()) {
      numMarkedBombs+=1;
      noLoop();
    }
  }
  fill(0);
  rect(420, 150, 50, 50);
  fill(255,0,0);  
  text("BUTTONS CHECKED"+" --> "+TOTAL+"/400",510,310);
  fill(0,255,0); 
  text("BOMBS DIFFUSED"+" --> "+"x"+"/"+bombs.size(),500,390);
  fill(255);
  System.out.println(TOTAL+","+isWon()+","+(bombs.size()+TOTAL)+";");
  //System.out.println(isWon());
  //text(numMarkedBombs, 420, 150);
}
public void TotalClicked()
{
  for (int i = 0; i < NUM_ROWS; i++) {
    for (int j = 0; j < NUM_COLS; j++) {
      if (buttons[i][j].clicked==true&&buttons[i][j].counted==false)
      {
        TOTAL=TOTAL+1;
        buttons[i][j].counted=true;
      } else {
        TOTAL=TOTAL+0;
      }
    }
  }
}
public boolean isWon()
{
  if (bombs.size()+TOTAL==400) {
    return true;
  }
  return false;
}
public void mousePressed () {
  TotalClicked();
}
public void displayWinningMessage()
{
  String winMessage = "GOODGAME";
  fill(0, 255, 0);
  text(winMessage, 500, 350 );
  //your code here
}
public void displayLosingMessage()
{
  String loseMessage = "ENDGAME" ;
  fill(255, 0, 0);
  text(loseMessage, 500, 350 );
  //your code here
}

public class UIButton
{
  private int r, c, Color;
  private float x, y, width, height;
  private boolean clicked, marked, cheatmark;
  private String label;
  public UIButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager
  public void mousePressed () 
  {
    if (clicked == false) {
      clicked = true;
    } else if (clicked = true) {
      clicked = false;
    }
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public void draw () {
    if (clicked==true) {
      //cheating = true;
      fill( 200 );
    } else {
      fill( 100 );
    }
    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
}
public class MSButton
{
  private int r, c, Color1, Color2, Color3;
  private float x, y, width, height;
  private boolean clicked, marked, cheatmark, counted;
  private String label;
  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager
  public void mousePressed () 
  {
    bombs1 = new ArrayList <MSButton> ();
    if (restartbutton == this&&TOTAL==0&&bombs.size()<70) {
      for (int r = 0; r < NUM_ROWS; r++) {
        for (int c = 0; c < NUM_COLS; c++) {
          buttons[r][c].marked = false;
          buttons[r][c].clicked = false;
          buttons[r][c].setLabel("");
        }
        clicked=true;
      }
      setBombs();

      gameOver = false;
      return;
    }
    if (gameOver == true) {
      return;
    }
    if (clicked == false) {
      clicked = true;
    } else if (flagButton==this) {
      clicked = false;
    } else {
      return;
    }
    if (keyPressed == true) {
      marked = !marked;
    } else if (bombs.contains(this)) {
      displayLosingMessage();
      lost=true;
      gameOver = true;
    } else if (countBombs(r, c) > 0&&flagButton!=this&&restartbutton!=this) {
      setLabel(label + countBombs(r, c));
    } else {
      if (isValid(r+1, c+1) && !buttons[r+1][c+1].isClicked()&&flagButton!=this&&restartbutton!=this) {
        buttons[r+1][c+1].mousePressed();
      }
      if (isValid(r-1, c-1) && !buttons[r-1][c-1].isClicked()&&flagButton!=this&&restartbutton!=this) {
        buttons[r-1][c-1].mousePressed();
      }
      if (isValid(r, c+1) && !buttons[r][c+1].isClicked()&&flagButton!=this&&restartbutton!=this) {
        buttons[r][c+1].mousePressed();
      }
      if (isValid(r, c-1) && !buttons[r][c-1].isClicked()&&flagButton!=this&&restartbutton!=this) {
        buttons[r][c-1].mousePressed();
      }
      if (isValid(r+1, c) && !buttons[r+1][c].isClicked()&&flagButton!=this&&restartbutton!=this) {
        buttons[r+1][c].mousePressed();
      }
      if (isValid(r-1, c) && !buttons[r-1][c].isClicked()&&flagButton!=this&&restartbutton!=this) {
        buttons[r-1][c].mousePressed();
      }
      if (isValid(r-1, c+1) && !buttons[r-1][c+1].isClicked()&&flagButton!=this&&restartbutton!=this) {
        buttons[r-1][c+1].mousePressed();
      }
      if (isValid(r+1, c-1) && !buttons[r+1][c-1].isClicked()&&flagButton!=this&&restartbutton!=this) {
        buttons[r+1][c-1].mousePressed();
      }
    }
    //your code here
  }
  public void draw () 
  { 
    if (flagButton==this&&flagButton.clicked==true) {
      Color1=255;
    }
    if (cheatmark==true)
    {
      fill(Color1, Color2, Color3);
    } else if (marked) {
      fill(0);
    } else if ( clicked && bombs.contains(this) ) { 
      fill(255, 0, 0);
    } else if (clicked) {
      fill( 200 );
    } else { 
      fill( 100 );
    }
    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
    if (buttons[r][c].isClicked() && bombs.contains(buttons[r][c])) {

      displayLosingMessage();
    }
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    // if(0 <= r && r <= NUM_ROWS-1 && 0 <= c && c <= NUM_COLS-1){
    //     return true;
    // }
    // //your code here
    // return false;
    if (r < 0) return false;
    else if (r >= NUM_ROWS) return false;
    else if (c < 0) return false;
    else if (c >= NUM_COLS) return false;
    else return true;
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    if (isValid(row-1, col-1) && bombs.contains(buttons[row-1][col-1])) {
      numBombs++;
    }
    if (isValid(row-1, col+1) && bombs.contains(buttons[row-1][col+1])) {
      numBombs++;
    }
    if (isValid(row-1, col) && bombs.contains(buttons[row-1][col])) {
      numBombs++;
    }  
    if (isValid(row, col-1) && bombs.contains(buttons[row][col-1])) {
      numBombs++;
    }    
    if (isValid(row, col+1) && bombs.contains(buttons[row][col+1])) {
      numBombs++;
    }
    if (isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1])) {
      numBombs++;
    }
    if (isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1])) {
      numBombs++;
    }
    if (isValid(row+1, col) && bombs.contains(buttons[row+1][col])) {
      numBombs++;
    }
    //your code here
    return numBombs;
  }
}