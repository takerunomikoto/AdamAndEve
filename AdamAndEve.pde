int World_x=20;  //haba
int World_y=20;  //takasa
DNA[][] Human=new DNA[World_x][World_y];//ninzuu;   //hito
int edge=30;    //kankaku
void setup() {    //shokika
   size(600, 600); //window-size
   background(0, 0, 0);//haikei
   frameRate(10);

   for (int i=0; i<World_x; i++) {
      for (int j=0; j<World_y; j++) {
         //rect(i*edge, j*edge, edge, edge);//make world
         Human[i][j]=new DNA(i, j);//nambering
      }
   }
   int[] Adambase1=new int[]{15, 10, 5, 15, 10, 5};//adam
   int[] Adambase2=new int[]{10, 5, 10, 10, 5, 15};//adam
   Human[4][5].BIRTH(Adambase1, Adambase2, false, true);//adam-tanjou
   Human[4][5].RENDER(4*edge, 5*edge);
   int[] Evebase1=new int[]{5, 15, 5, 10, 15, 10};
   int[] Evebase2=new int[]{10, 5, 15, 5, 10, 5};
   Human[5][5].BIRTH(Evebase1, Evebase2, false, false);
   Human[5][5].RENDER(5*edge, 5*edge);
}
void draw() {
   background(0, 0, 0);
   for (int i=0; i<World_x; i++) {
      for (int j=0; j<World_y; j++) {
         Human[i][j].ROUTINE();
      }
   }
   for (int i=0; i<World_x; i++) {
      for (int j=0; j<World_y; j++) {
         Human[i][j].RENDER(i*edge, j*edge);
      }
   }
   text(frameCount+"年", 0, 10);
}

class DNA {
   private int[] Base1;        //enki-hairetsu
   private int[] Base2;        //enki-hairetsu
   private int[] Individual;   //kotai
   private int[] IndividualColor;  //kotai-no-iro
   private boolean Sex1;      //senshoku-tai
   private boolean Sex2;      //senshoku-tai
   private boolean Sex;       //seibetsu
   private boolean Alive;     //ikiteiru
   private int Num_x, Num_y;       //kotai-chi
   private int Age;
   private int Probability;


   /*constract*/
   DNA(int Number1, int Number2) {
      Alive=false;
      Num_x=Number1;
      Num_y=Number2;
   }

   /*umarettara-jikkou*/
   void BIRTH(int[] BaseA, int[] BaseB, boolean SexA, boolean SexB) {
      Alive=true;   //ikiteiru
      Age=0;
      Probability=(int)random(30);
      Base1=BaseA;  //enki
      Base2=BaseB;  //enki
      Sex1=SexA;    //sex
      Sex2=SexB;    //sex
      if (Sex1!=Sex2) {  //YandX
         Sex=true;   //men
      } else {
         Sex=false;  //women
      }
      Individual=new int[Base1.length];
      IndividualColor=new int[Base1.length/2];
      for (int i=0; i<Base1.length; i++) {
         //if (Probability>43&random(30)<1) {
         //   Base1[i]=Base1[i]+(int)random(2)-(int)random(2);
         //}
         if (Base1[i]<Base2[i]) { //yuusei-no-hantei
            Individual[i]=Base2[i];
         } else {
            Individual[i]=Base1[i];
         }
      }
      for (int i=0; i<Base1.length/2; i++) {
         IndividualColor[i]=Individual[i*2]*16+Individual[i*2+1];//kotai-kara-iro
      }
   }
   void RENDER(int Pos_x, int Pos_y) {
      if (!Alive) return;
      Age++;
      fill(IndividualColor[0], IndividualColor[1], IndividualColor[2]);//iro
      if (Sex==true) {//men
         rect(Pos_x, Pos_y, edge, edge);
      } else {//women
         ellipse(Pos_x+edge/2, Pos_y+edge/2, edge, edge);
      }
      fill(255);
      text(Age, Pos_x, Pos_y+edge);
   }
   int[] POSTERITY() {//enki
      return (random(2)<1 ?Base1: Base2);
   }
   boolean GENDER() {//senshoku-tai
      int gender =(int)random(2);
      if (gender<1) {
         return Sex1;
      } else {
         return Sex2;
      }
   }
   int[] INDIVIDUAL() {
      return Individual;
   }

   void ROUTINE() {
      if (!Alive) return;
      DNA[] Hum = new DNA[9];
      //int[][] Neighbor = new int[][]{{Num_x-1, Num_y-1}, { Num_x, Num_y-1}, { Num_x+1, Num_y-1}, { Num_x-1, Num_y}, { Num_x+1, Num_y}, { Num_x-1, Num_y+1}, { Num_x, Num_y+1}, { Num_x+1, Num_y+1}};
      boolean Death=false;
      int Marry_x=0;
      int Marry_y=0;
      int AliveCount=0;
      //int RoundDNA_x=0;//mawari-miru
      //int RoundDNA_y=0;
      boolean bornFlug=false;
      if (Age>6&Age<30) {
         Probability--;
      }
      if (Age>=30) {
         Probability++;
      }
      for (int x=-1; x<2; x++) {
         for (int y=-1; y<2; y++) {
            if (x==0 & y==0) continue;
            if (Num_x+x >= 0 & Num_x+x < World_x & Num_y+y >= 0 & Num_y+y < World_y) {
               Hum[(x+1)+(y+1)*3] = Human[Num_x+x][Num_y+y];
               if (bornFlug==false&Sex==false&Hum[(x+1)+(y+1)*3].Sex != Sex&Hum[(x+1)+(y+1)*3].Alive&Hum[(x+1)+(y+1)*3].Age<45&Hum[(x+1)+(y+1)*3].Age>12&Age>12&Age<45&random(100)<30) {
                  
                  
                        Marry_x=x;
                        Marry_y=y;
                        bornFlug=true;
                     
                  
               }
            }
         }
      }
      if (bornFlug==true) {
         for (int x=-1; x<2; x++) {
            for (int y=-1; y<2; y++) {
               if (x==0 & y==0) continue;
               if (Num_x+x >= 0 & Num_x+x < World_x & Num_y+y >= 0 & Num_y+y < World_y) {
                  if (!Hum[(x+1)+(y+1)*3].Alive&bornFlug==true) {
                     Human[Num_x+x][Num_y+y].BIRTH(POSTERITY(), Hum[(Marry_x+1)+(Marry_y+1)*3].POSTERITY(), GENDER(), Hum[(Marry_x+1)+(Marry_y+1)*3].GENDER());
                     bornFlug=false;   
               }
               }
            }
         }
      }
      for (int x=-1; x<2; x++) {
         for (int y=-1; y<2; y++) {
            if (x==0 & y==0) continue;
            if (Num_x+x >= 0 & Num_x+x < World_x & Num_y+y >= 0 & Num_y+y < World_y) {
               //if (Hum[(x+1)+(y+1)*3].Alive) {
               //  if (Sex==true&Hum[(x+1)+(y+1)*3].Sex!=Sex) {
               //     AliveCount++;
               //     if (AliveCount>2)
               //        Death=true;
               //  }
               //  if (Sex==false&Hum[(x+1)+(y+1)*3].Sex==Sex) {
               //     AliveCount++;
               //     if ((x+1)+(y+1)*3>2&AliveCount%2==0)
               //        Death=true;
               //  }
               //}
               if (Probability>50-random(10)) {
                  Death=true;
               }
            }
         }
      }
      if (Death==true) {
         Alive=false;
      }
   }
}