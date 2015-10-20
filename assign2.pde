PImage background1Img,background2Img,enemyImg,treasureImg,fighterImg,hpImg;
PImage end1Img, end2Img, start1Img, start2Img;

float x=0;
float enemyX=0;                           
float enemyY=random(0,440);   
float hpX=38.8;   //hplength:22~216pixel,length=194,10hp=19.4,20hp=38.8    
float treasureX=random(45,585);     
float treasureY=random(45,405);     
float fighterX=589;
float fighterY=240;

final int GAME_START=0,GAME_RUN=1,GAME_OVER=2;
int gameState;

boolean upPressed=false,downPressed=false,rightPressed=false,leftPressed=false;

void setup(){
  size(640,480);
  
  background1Img=loadImage("img/bg1.png");
  background2Img=loadImage("img/bg2.png");
  enemyImg=loadImage("img/enemy.png");
  treasureImg=loadImage("img/treasure.png");
  fighterImg=loadImage("img/fighter.png");
  hpImg=loadImage("img/hp.png");
  end1Img=loadImage("img/end1.png");
  end2Img=loadImage("img/end2.png");
  start1Img=loadImage("img/start1.png");
  start2Img=loadImage("img/start2.png");
 
}

void draw(){
  switch(gameState){
      case GAME_START:
        image(start2Img,0,0);     //start image
        if(mouseX>=210 && mouseX<=440 && mouseY>=380 && mouseY<=410){
          image(start1Img,0,0);
          if(mousePressed){        //click
         gameState=GAME_RUN;      //start image with highlight
         }
        }
      break;
   
     case GAME_RUN:
       //background
        image(background1Img,x,0);
        image(background2Img,x-640,0);
        image(background1Img,x-1280,0);
        x++;
        x%=1280;
         
        //fighter_mouse_moving
        if(upPressed){
        fighterY-=5;
        }if(fighterY<0){
          fighterY=0;
        }
        if(downPressed){
        fighterY+=5;
        }if(fighterY>height-51){
          fighterY=height-51;
        }
        if(rightPressed){
        fighterX+=5;
        }if(fighterX>width-51){
          fighterX=width-51;
        }
        if(leftPressed){
        fighterX-=5;
        }if(fighterX<0){
          fighterX=0;
        }
        image(fighterImg,fighterX,fighterY);   //fighter_mouse_moving_done
        
        //hp
        noStroke();
        fill(255,0,0);
        rect(22,14,hpX,15);
        image(hpImg,10,10);
        
        //treasure(41*41pixel)    
        image(treasureImg,treasureX,treasureY);
        if (fighterX>=treasureX-41 && fighterX<=treasureX+51 && fighterY>=treasureY-41 && fighterY<=treasureY+51){
          hpX+=19.4;
          treasureX=random(30,580);     
          treasureY=random(30,450);
        }
    
        //enemy(61*61 pixel)
        image(enemyImg,enemyX,enemyY);
        enemyX+=3;
        enemyX%=640;
        
        if(enemyY>fighterY){
          enemyY-=3;
          }else if (enemyY==fighterY){
            enemyY=random(0,440);
            }else{
              enemyY+=3;
        }
        
        //hit detection of fighter(51*51)&enemy(61*61)
        if(fighterX>=enemyX-55 && fighterX<=enemyX+61 && fighterY>=enemyY-51 && fighterY<=enemyY+61){
          hpX-=38.8;
          enemyX=0;
          enemyY=random(0,440);
        }
        
        //hp range
        if(hpX>=194){
          hpX=194;
        }else if(hpX<=0){
          gameState=GAME_OVER;
        }
        
     break;
   
     case GAME_OVER:
       image(end2Img,0,0);
       if(mouseX>=210 && mouseX<=425 && mouseY>=310 && mouseY<=345){
         image(end1Img,0,0);
         if(mousePressed){         //click
         gameState=GAME_RUN;      //change case
         x=0;
         enemyX=0;                           
         enemyY=random(65,440);   
         hpX=38.8;     
         treasureX=random(45,585);     
         treasureY=random(45,405);     
         fighterX=589;
         fighterY=240;                                
         } 
       }
     break;
  }
}

void keyPressed(){
  if(key==CODED){
    switch(keyCode){
      case UP:
        upPressed=true;
        break;
      case DOWN:
        downPressed=true;
        break;
      case RIGHT:
        rightPressed=true;
        break;
      case LEFT:
        leftPressed=true;
        break;
    }
  }
}

void keyReleased(){
  if(key==CODED){
   switch(keyCode){  
     case UP:
       upPressed=false;
       break;
     case DOWN:
       downPressed=false;
       break;
     case RIGHT:
       rightPressed=false;
       break;
     case LEFT:
       leftPressed=false;
       break;   
    }
  }
}
