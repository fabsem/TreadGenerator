// Wheel Generation Code

// Wheel Definition
slick = 1; //Slick
ng =  4; // Number of Longitudinal Grooves
QG = 12;    //Include Lateral Grooves
nQG = 80; //Number of Lateral Grooves

// Wheel Geometry
w = 241-2*3; //235 //Wheel width (deformed contour to match sims)
w = 241-3;
AR = 45; //Wheel aspect ratio
inches = 18;
r_rim = inches/2 * 25.4;  //Wheel radius
r = r_rim + w * AR / 98;

//groove_width = 32;
garea = 321.4;              //Groove Frontal Area
gh = 9.2;                   //Groove height
gw = garea/(ng * gh);      //Groove width (evaluated)
QGw = 4;                  //QG Groove width
QGl = 45;                  //QG Groove length

incl = 0;

//Resolution
//res = 5e2;
$fn = 1e2;// 100 is good and fast

// DO NOT CHANGE FROM HERE ---



module QG_E(incl,nQG,QGl,QGw,w,r,ng,gh,gw){
        $incl = incl;
    $nQG = nQG;
    $QGl = QGl;
    $QGw = QGw;
    $w = w;
    $r = r;
    $ng = ng;
    $gh = gh;
    $gw = gw;


    scale([1e-3,1e-3,1e-3])
        difference(){
        translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
        difference(){

        wheel_1($w,$r,$ng,$gh,$gw);
        cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true); //1.35
    }
    
   QG_mrf($incl,$nQG,$QGl,$QGw);
}
}



module QG_I(incl,nQG,QGl,QGw,w,r,ng,gh,gw){
    $incl = incl;
    $nQG = nQG;
    $QGl = QGl;
    $QGw = QGw;
    $w = w;
    $r = r;
    $ng = ng;
    $gh = gh;
    $gw = gw;

    scale([1e-3,1e-3,1e-3])
       difference(){
                 translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
        difference(){

        wheel_1($w,$r,$ng,$gh,$gw);
        cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true); //1.35
    }




    QG_mrf_I($incl,$nQG,$QGl,$QGw);
  
}
}


module QG_2(incl,nQG,QGl,QGw,w,r,ng,gh,gw){

        $incl = incl;
    $nQG = nQG;
    $QGl = QGl;
    $QGw = QGw;
    $w = w;
    $r = r;
    $ng = ng;
    $gh = gh;
    $gw = gw;

   //

   difference(){
      QG_E($incl,$nQG,$QGl,$QGw,$w,$r,$ng,$gh,$gw);

       scale([1e-3,1e-3,1e-3])
    QG_mrf_I($incl,$nQG,$QGl,$QGw);
   }
}

module QG_tire(){
    
    
    
    if (QG == 0) {

    difference(){
                 translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
        difference(){

        wheel_1_right(w,r,ng,gh,gw);
        cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true); //1.35
    }
   QG_mrf();
}
}
    if (QG == 1) {

    difference(){
                 translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
        difference(){

        wheel_1(w,r,ng,gh,gw);
        cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true); //1.35
    }
    rotate([0,0,180])
    translate([0,-68,0])
    QG_mrf();
}
}
    if (QG == 2) {


    difference(){
        translate([0,32,0])          //Needed to mound on the rim for sims
        rotate([90,0,0])            //Change plane

        difference(){

            wheel_1(w,r,ng,gh,gw);
            cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true); //1.35
            }

            QG_mrf();
            }


}
}






module QG_mrf(incl,nQG,QGl,QGw) {

    shift = (w / (2.04167 * 2)); 
     translate([0,32,0])          //Needed to mount on the rim for sims
    rotate([90,0,0])            //Change plane
      difference(){

         pathRadius=r;
         num=nQG;
         color([0.5,0.5,0.5])
         translate([0,0,(shift+32)])

          for (i=[1:num])  {

           
              translate([pathRadius*cos(i*(360/num)),pathRadius*sin(i*(360/num)),0])
              rotate([0,0,(i-0) * (360/num)])

              rotate([180,0,180])
              translate([15,0,0])
             difference(){
              
                 cube(size=[30,QGw,QGl],center=true);
              
                    color([0,0,0])
                  rotate([90,70,0])
                  translate([0,10,0])
                 cube(size=[60,QGw*9,QGl],center=true);
           
        }
        }


}


}



module QG_mrf_I(incl,nQG,QGl,QGw) {
       rotate([0,0,180])
    translate([0,-68,0])
 

     translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
      difference(){

         pathRadius=330;
         num=nQG;
         color([0.5,0.5,0.5])
         translate([0,0,(60+32)])

          for (i=[1:num])  {

           
              translate([pathRadius*cos(i*(360/num)),pathRadius*sin(i*(360/num)),0])
              rotate([0,0,(i-0) * (360/num)])

              rotate([180,0,180])
              translate([15,0,0])
             difference(){
          
                 cube(size=[40,QGw,QGl],center=true);
                 
                    color([0,0,0])
                  rotate([90,70,0])
                  translate([0,10,0])
                 cube(size=[60,QGw*9,QGl],center=true);
        }
        }



}


}


module wheel_1(w,r,ng,gh,gw)
{
    if (ng == 4) {
       
        ext = (w / (2.04167 * 2));
        gap = ((ext*2) - ng * gw) / (ng - 1);
    difference() {
   



    translate([0,0,-w/2])
   
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    
        translate([0,0,-gap/2 - gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    
        translate([0,0,gap/2 + gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext- gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,gap/2 + gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-gap/2 - gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

       if (ng == 3) {
           ext = (w / (2.04167 * 2));
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,0])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext- gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,0])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

          if (ng == 2) {
              
        ext = (w / (2.04167 * 2));
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext- gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

      if (ng == 5) {
        
           ext = (w / (2.04167 * 2));
          gap = ((ext*2) - ng * gw) / (ng - 1);
    difference() {
   

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0, -gw - gap])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,0 ])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,+gw +gap ])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext- gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-gw -gap ])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,0 ])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,+gw +gap])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

}



module wheel_1_special(w,r,ng,gh,gw,opt1,opt2)
{
    if (ng == 4) {
        
        ext = (w / (2.04167 * 2));
        gap = ((ext*2) - ng * gw) / (ng - 1);

        size1 = opt1[3];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[2];
        gw2 = gw + gw * size2 / 100;
        size3 = opt1[1];
        gw3 = gw + gw * size3 / 100;
        size4 = opt1[0];
        gw4 = gw + gw * size4 / 100;
        
        gap1 = opt2[2];
        
        gap2 = opt2[1];
        
        gap3 = opt2[0];
        
        
    if (gap1 == []) {  
        
      gap2 = gap + gap * gap2/100;
       gap3 = gap + gap * gap3/100;
        difference() {
    



    translate([0,0,-w/2])
   
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);        
    translate([0,0,ext - gw4/2])
    cylinder(gw4,r/0.9,r/0.9,center=true);
    
    translate([0,0,ext - gw4 - gap3 - gw3 - gap2 - gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
   
    translate([0,0,ext - gw4 - gap3 - gw3/2])
    cylinder(gw3,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,ext- gw4/2])
   cylinder(gw4,r-gh,r-gh,center=true);
   translate([0,0,ext - gw4 - gap3 - gw3 - gap2 - gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0,ext - gw4 - gap3 - gw3/2])
   cylinder(gw3,r-gh,r-gh,center=true);
   } }
    if (gap2 == []) {   
       
             gap1 = gap + gap * gap1/100;
       gap3 = gap + gap * gap3/100;
       
        difference() {
    



    translate([0,0,-w/2])
   
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw4/2])
    cylinder(gw4,r/0.9,r/0.9,center=true);
    
    translate([0,0,-ext + gw1 + gap1 + gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    
    translate([0,0,ext - gw4 - gap3 - gw3/2])
    cylinder(gw3,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,ext - gw4/2])
   cylinder(gw4,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw1 + gap1 + gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0,ext - gw4 - gap3 - gw3/2])
   cylinder(gw3,r-gh,r-gh,center=true);
   } }
    if (gap3 == []) {  
      
       gap1 = gap + gap * gap1/100;
       gap2 = gap + gap * gap2/100;
        
        difference() {
   



    translate([0,0,-w/2])
    
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw4/2])
    cylinder(gw4,r/0.9,r/0.9,center=true);
    
        translate([0,0,-ext + gw1 + gap1 + gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    
        translate([0,0,-ext + gw1 + gap1 + gw2 + gap2 + gw3/2])
    cylinder(gw3,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,ext - gw4/2])
   cylinder(gw4,r-gh,r-gh,center=true);
    translate([0,0,-ext + gw1 + gap1 + gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw1 + gap1 + gw2 + gap2 + gw3/2])
   cylinder(gw3,r-gh,r-gh,center=true);
   }}

   }

       if (ng == 3) {
           
        ext = (w / (2.04167 * 2));
        gap = ((ext*2) - ng * gw) / (ng - 1);

        size1 = opt1[2];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[1];
        gw2 = gw + gw * size2 / 100;
        size3 = opt1[0];
        gw3 = gw + gw * size3 / 100;
           
        gap1 = opt2[1];
        gap2 = opt2[0];
        
    if (gap1 == []) {    
        gap2 = gap + gap * gap2 / 100;
        difference() {
       
    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw3/2])
    cylinder(gw3,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw3 - gap2 - gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,ext - gw3/2])
   cylinder(gw3,r-gh,r-gh,center=true);
   translate([0,0,ext - gw3 - gap2 - gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   }  
   }
   
    if (gap2 == []) {  
     gap1 = gap + gap * gap1 / 100;
        difference() {
        
       

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw3/2])
    cylinder(gw3,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw1 + gap1 + gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,ext- gw3/2])
   cylinder(gw3,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw1 + gap1 + gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   } }
           
           

   }

          if (ng == 2) {
              ext = (w / (2.04167 * 2));
    difference() {
        
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext- gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

      if (ng == 5) {
        ext = (w / (2.04167 * 2));
        gap = ((ext*2) - ng * gw) / (ng - 1);

        size1 = opt1[4];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[3];
        gw2 = gw + gw * size2 / 100;
        size3 = opt1[2];
        gw3 = gw + gw * size3 / 100;
        size4 = opt1[1];
        gw4 = gw + gw * size4 / 100;
        size5 = opt1[0];
        gw5 = gw + gw * size5 / 100;
        
        gap1 = opt2[3];
        
        gap2 = opt2[2];
        
        gap3 = opt2[1];
        gap4 = opt2[0];
          
          
          
         if (gap1 == []) {
             
             gap2 = gap + gap * gap2/100;
             gap3 = gap + gap * gap3/100;
             gap4 = gap + gap * gap4/100;
             
                 difference() {
    
    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw5/2])
    cylinder(gw5,r/0.9,r/0.9,center=true);
    translate([0,0, ext - gw5 - gap4 - gw4 - gap3 - gw3 - gap2 - gw2/2]) // 2
    cylinder(gw2,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw5 - gap4 - gw4 - gap3 - gw3/2]) // 3 
    cylinder(gw3,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw5 - gap4 - gw4/2 ])  // 4
    cylinder(gw4,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,ext- gw5/2])
   cylinder(gw5,r-gh,r-gh,center=true);
   translate([0,0, ext - gw5 - gap4 - gw4 - gap3 - gw3 - gap2 - gw2/2]) // 2
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0,ext - gw5 - gap4 - gw4 - gap3 - gw3/2]) // 3 
   cylinder(gw3,r-gh,r-gh,center=true);
   translate([0,0,ext - gw5 - gap4 - gw4/2 ])  // 4
   cylinder(gw4,r-gh,r-gh,center=true);
   }
             }
         if (gap2 == []) {
             gap1 = gap + gap * gap1/100;
             gap3 = gap + gap * gap3/100;
             gap4 = gap + gap * gap4/100;
             
                 difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw1/2]) // 1
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw5/2]) // 5
    cylinder(gw5,r/0.9,r/0.9,center=true);
    translate([0,0, -ext + gw1 + gap1 + gw2/2]) // 2
    cylinder(gw2,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw5 - gap4 - gw4 - gap3 - gw3/2]) // 3 
    cylinder(gw3,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw5 - gap4 - gw4/2 ])  // 4
    cylinder(gw4,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,ext- gw5/2])
   cylinder(gw5,r-gh,r-gh,center=true);
   translate([0,0, -ext + gw1 + gap1 + gw2/2]) // 2
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0,ext - gw5 - gap4 - gw4 - gap3 - gw3/2]) // 3 
   cylinder(gw3,r-gh,r-gh,center=true);
   translate([0,0,ext - gw5 - gap4 - gw4/2 ])  // 4
   cylinder(gw4,r-gh,r-gh,center=true);
   }
             }
         if (gap3 == []) {
             gap1 = gap + gap * gap1/100;
             gap2 = gap + gap * gap2/100;
             gap4 = gap + gap * gap4/100;
                 difference() {
   

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw5/2])
    cylinder(gw5,r/0.9,r/0.9,center=true);
    translate([0,0, -ext + gw1 + gap1 + gw2/2]) // 2
    cylinder(gw2,r/0.9,r/0.9,center=true);
    translate([0,0, -ext + gw1 + gap1 + gw2 + gap2 + gw3/2]) // 2
    cylinder(gw3,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw5 - gap4 - gw4/2 ])  // 4
    cylinder(gw4,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,ext- gw5/2])
   cylinder(gw5,r-gh,r-gh,center=true);
   translate([0,0, -ext + gw1 + gap1 + gw2/2]) // 2
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0, -ext + gw1 + gap1 + gw2 + gap2 + gw3/2]) // 3
   cylinder(gw3,r-gh,r-gh,center=true);
   translate([0,0,ext - gw5 - gap4 - gw4/2 ])  // 4
   cylinder(gw4,r-gh,r-gh,center=true);
   }
             }
         if (gap4 == []) {
             gap1 = gap + gap * gap1/100;
             gap2 = gap + gap * gap2/100;
             gap3 = gap + gap * gap3/100;
                 difference() {
   

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw5/2])
    cylinder(gw5,r/0.9,r/0.9,center=true);
    translate([0,0, -ext + gw1 + gap1 + gw2/2]) // 2
    cylinder(gw2,r/0.9,r/0.9,center=true);
    translate([0,0, -ext + gw1 + gap1 + gw2 + gap2 + gw3/2]) // 3
    cylinder(gw3,r/0.9,r/0.9,center=true);
    translate([0,0, -ext + gw1 + gap1 + gw2 + gap2 + gw3 + gap3 + gw4/2]) // 3
    cylinder(gw4,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,ext- gw5/2])
   cylinder(gw5,r-gh,r-gh,center=true);
   translate([0,0, -ext + gw1 + gap1 + gw2/2]) // 2
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0, -ext + gw1 + gap1 + gw2 + gap2 + gw3/2]) // 3
   cylinder(gw3,r-gh,r-gh,center=true);
   translate([0,0, -ext + gw1 + gap1 + gw2 + gap2 + gw3 + gap3 + gw4/2]) // 3
   cylinder(gw4,r-gh,r-gh,center=true);
   }
             }
         

   }

}

module wheel_1_left(w,r,ng,gh,gw)
{

    if (ng == 4) {
        
        ext = (w / (2.04167 * 2));
        gap = gw;
    difference() {
    



    translate([0,0,-w/2])
    
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw/2 + 2*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    
        translate([0,0,-ext + gw/2 + 4*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
   
        translate([0,0,-ext + gw/2 + 6*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw/2 + 2*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw/2 + 4*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw/2 + 6*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

       if (ng == 3) {
           ext = (w / (2.04167 * 2));
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw/2 + 2*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw/2 + 4*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw/2 + 2*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw/2 + 4*gw ])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

          if (ng == 2) {
              ext = (w / (2.04167 * 2));
    difference() {
   

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw/2 + 2*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw/2 + 2*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }
             if (ng == 1) {
                 ext = (w / (2.04167 * 2));
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

      if (ng == 5) {
          ext = (w / (2.04167 * 2));
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw/2 + 2*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw/2 + 4*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw/2 + 6*gw ])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw/2 + 8*gw ])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw/2 + 2*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw/2 + 4*gw ])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw/2 + 6*gw ])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw/2 + 8*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

}


module wheel_1_left_special(w,r,ng,gh,gw,opt1,opt2) 
{
        
      gap = gw;
    
    if (ng == 4) {
        
        gap = gw;
        
        
        ext = (w / (2.04167 * 2));
       

        size1 = opt1[3];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[2];
        gw2 = gw + gw * size2 / 100;
        size3 = opt1[1];
        gw3 = gw + gw * size3 / 100;
        size4 = opt1[0];
        gw4 = gw + gw * size4 / 100;
        
       
        gap1 = gap + gap * opt2[2] / 100;
        gap2 = gap + gap * opt2[1] / 100;
        gap3 = gap + gap * opt2[0] / 100;
        
        difference() {
   



    translate([0,0,-w/2])
    
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw1 + gap1 + gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    
        translate([0,0,-ext + gw1 + gap1 + gw2 + gap2 + gw3/2])
    cylinder(gw3,r/0.9,r/0.9,center=true);
   
      translate([0,0,-ext + gw1 + gap1 + gw2 + gap2 + gw3 + gap3 + gw4/2])
    cylinder(gw4,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw1 + gap1 + gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
    translate([0,0,-ext + gw1 + gap1 + gw2 + gap2 + gw3/2])
   cylinder(gw3,r-gh,r-gh,center=true);
     translate([0,0,-ext + gw1 + gap1 + gw2 + gap2 + gw3 + gap3 + gw4/2])
   cylinder(gw4,r-gh,r-gh,center=true);
   }
   
            }

        

   

       if (ng == 3) {
           ext = (w / (2.04167 * 2));
        

        size1 = opt1[2];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[1];
        gw2 = gw + gw * size2 / 100;
        size3 = opt1[0];
        gw3 = gw + gw * size3 / 100;
        
        gap1 = opt2[1];
        
        gap2 = opt2[0];
        
      
            gap1 = gap + gap * opt2[1]/100;
            gap2 = gap + gap * opt2[0]/100;
          
            
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw1 + gap1 + gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw1 + gap1 + gw2 + gap2 + gw3/2])
    cylinder(gw3,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw1 + gap1 + gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw1 + gap1 + gw2 + gap2 + gw3/2])
   cylinder(gw3,r-gh,r-gh,center=true);
   }
   }

          if (ng == 2) {
              ext = (w / (2.04167 * 2));
        size1 = opt1[1];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[0];
        gw2 = gw + gw * size2 / 100;
        
        gap1 = opt2[0];
        gap1 = gap + gap * opt2[0]/100;
              
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw1 + gap1 + gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw1 + gap1 + gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   }
   }
             if (ng == 1) {
                 size1 = opt1[0];
        gw1 = gw + gw * size1 / 100;
                 ext = (w / (2.04167 * 2));
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   }
   }

      if (ng == 5) {
          ext = (w / (2.04167 * 2));
        size1 = opt1[4];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[3];
        gw2 = gw + gw * size2 / 100;
        size3 = opt1[2];
        gw3 = gw + gw * size3 / 100;
        size4 = opt1[1];
        gw4 = gw + gw * size4 / 100;
          size5 = opt1[0];
        gw5 = gw + gw * size5 / 100;
        
        gap1 = opt2[3];
        
        gap2 = opt2[2];
        
        gap3 = opt2[1];
        gap4 = opt2[0];
        
      
            gap1 = gap + gap * opt2[3]/100;
            gap2 = gap + gap * opt2[2]/100;
            gap3 = gap + gap * opt2[1]/100;
            gap4 = gap + gap * opt2[0]/100;
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw1 + gap1 + gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw1 + gap1 + gw2 + gap2 + gw3/2])
    cylinder(gw3,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw1 + gap1 + gw2 + gap2 + gw3 + gap3 + gw4/2])
    cylinder(gw4,r/0.9,r/0.9,center=true);
    translate([0,0,-ext + gw1 + gap1 + gw2 + gap2 + gw3 + gap3 + gw4 + gap4 + gw5/2])
    cylinder(gw5,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-ext + gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw1 + gap1 + gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw1 + gap1 + gw2 + gap2 + gw3/2])
   cylinder(gw3,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw1 + gap1 + gw2 + gap2 + gw3 + gap3 + gw4/2])
   cylinder(gw4,r-gh,r-gh,center=true);
   translate([0,0,-ext + gw1 + gap1 + gw2 + gap2 + gw3 + gap3 + gw4 + gap4 + gw5/2])
   cylinder(gw5,r-gh,r-gh,center=true);
   }
   }

}

module wheel_1_right(w,r,ng,gh,gw)
{
    if (ng == 4) {
       
        ext = (w / (2.04167 * 2));
        gap = gw;
    difference() {
   



    translate([0,0,-w/2])
    
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,ext - gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw/2 - 2*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    
        translate([0,0,ext - gw/2 - 4*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    
        translate([0,0,ext - gw/2 - 6*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,ext - gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext - gw/2 - 2*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext - gw/2 - 4*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext - gw/2 - 6*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

       if (ng == 3) {
           ext = (w / (2.04167 * 2));
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,ext - gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw/2 - 2*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw/2 - 4*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,ext - gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext - gw/2 - 2*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext - gw/2 - 4*gw ])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

          if (ng == 2) {
              ext = (w / (2.04167 * 2));
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,ext - gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw/2 - 2*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,ext - gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext - gw/2 - 2*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }
             if (ng == 1) {
                 ext = (w / (2.04167 * 2));
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,ext - gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,ext - gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

      if (ng == 5) {
          ext = (w / (2.04167 * 2));
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,ext - gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw/2 - 2*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw/2 - 4*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw/2 - 6*gw ])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw/2 - 8*gw ])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,ext - gw/2])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext - gw/2 - 2*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext - gw/2 - 4*gw ])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext - gw/2 - 6*gw ])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,ext - gw/2 - 8*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

}



module wheel_1_right_special(w,r,ng,gh,gw,opt1,opt2) {
         gap = gw;
    
    if (ng == 4) {
        
        gap = gw;
        
        
        ext = (w / (2.04167 * 2));
        

        size1 = opt1[0];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[1];
        gw2 = gw + gw * size2 / 100;
        size3 = opt1[2];
        gw3 = gw + gw * size3 / 100;
        size4 = opt1[3];
        gw4 = gw + gw * size4 / 100;
        
       
        gap1 = gap + gap * opt2[0] / 100;
        gap2 = gap + gap * opt2[1] / 100;
        gap3 = gap + gap * opt2[2] / 100;
    difference() {
    



    translate([0,0,-w/2])
   
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,ext - gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw1 - gap1 - gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
   
    translate([0,0,ext - gw1 - gap1 - gw2 - gap2 - gw3/2])
    cylinder(gw3,r/0.9,r/0.9,center=true);
    
    translate([0,0,ext - gw1 - gap1 - gw2 - gap2 - gw3 - gap3 - gw4/2])
    cylinder(gw4,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,ext - gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,ext - gw1 - gap1 - gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0,ext - gw1 - gap1 - gw2 - gap2 - gw3/2])
   cylinder(gw3,r-gh,r-gh,center=true);
   translate([0,0,ext - gw1 - gap1 - gw2 - gap2 - gw3 - gap3 - gw4/2])
   cylinder(gw4,r-gh,r-gh,center=true);
   }
   }

       if (ng == 3) {
                  gap = gw;
        
        
        ext = (w / (2.04167 * 2));
        

        size1 = opt1[0];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[1];
        gw2 = gw + gw * size2 / 100;
        size3 = opt1[2];
        gw3 = gw + gw * size3 / 100;
        gap1 = gap + gap * opt2[0] / 100;
        gap2 = gap + gap * opt2[1] / 100;
           
    difference() {
   

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,ext - gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw1 - gap1 - gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw1 - gap1 - gw2 - gap2 - gw3/2])
    cylinder(gw3,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,ext - gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,ext - gw1 - gap1 - gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0,ext - gw1 - gap1 - gw2 - gap2 - gw3/2])
   cylinder(gw3,r-gh,r-gh,center=true);
   }
   }

          if (ng == 2) {
                    gap = gw;
        
        
        ext = (w / (2.04167 * 2));
        

        size1 = opt1[0];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[1];
        gw2 = gw + gw * size2 / 100;
              
        gap1 = gap + gap * opt2[0] / 100;
              
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,ext - gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw1 - gap1 - gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,ext - gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,ext - gw1 - gap1 - gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   }
   }
             if (ng == 1) {
                 size1 = opt1[0];
        gw1 = gw + gw * size1 / 100;
                 ext = (w / (2.04167 * 2));
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,ext - gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,ext - gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   }
   }

      if (ng == 5) {
                  gap = gw;
        
        
        ext = (w / (2.04167 * 2));
        
        size1 = opt1[0];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[1];
        gw2 = gw + gw * size2 / 100;
        size3 = opt1[2];
        gw3 = gw + gw * size3 / 100;
        size4 = opt1[3];
        gw4 = gw + gw * size4 / 100;
        size5 = opt1[4];
        gw5 = gw + gw * size5 / 100;
        
       
        gap1 = gap + gap * opt2[0] / 100;
        gap2 = gap + gap * opt2[1] / 100;
        gap3 = gap + gap * opt2[2] / 100;
        gap4 = gap + gap * opt2[3] / 100;
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,ext - gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw1 - gap1 - gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw1 - gap1 - gw2 - gap2 - gw3/2])
    cylinder(gw3,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw1 - gap1 - gw2 - gap2 - gw3 - gap3 - gw4/2])
    cylinder(gw4,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw1 - gap1 - gw2 - gap2 - gw3 - gap3 - gw4 - gap4 - gw5/2])
    cylinder(gw5,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,ext - gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,ext - gw1 - gap1 - gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0,ext - gw1 - gap1 - gw2 - gap2 - gw3/2])
   cylinder(gw3,r-gh,r-gh,center=true);
   translate([0,0,ext - gw1 - gap1 - gw2 - gap2 - gw3 - gap3 - gw4/2])
   cylinder(gw4,r-gh,r-gh,center=true);
   translate([0,0,ext - gw1 - gap1 - gw2 - gap2 - gw3 - gap3 - gw4 - gap4 - gw5/2])
   cylinder(gw5,r-gh,r-gh,center=true);
   }
   }

}




module wheel_1_central(w,r,ng,gh,gw)
{
    if (ng == 4) {
        
        gap = gw;
    difference() {
    



    translate([0,0,-w/2])
    
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-1 * gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,-3 * gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    
        translate([0,0,  gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    
        translate([0,0,3* gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-1 * gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-3 * gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,  gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,3 * gw])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

       if (ng == 3) {
    difference() {
   

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,0])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,-2 * gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,2 * gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0, 0])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-2 * gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,2 * gw ])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

          if (ng == 2) {
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,-gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-gw])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }
             if (ng == 1) {
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,0])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,0])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

      if (ng == 5) {
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,0])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,-2*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,-4*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,2*gw])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,+4*gw ])
    cylinder(gw,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,0])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-2*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,-4* gw ])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,2*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   translate([0,0,4*gw])
   cylinder(gw,r-gh,r-gh,center=true);
   }
   }

}

module wheel_1_central_special(w,r,ng,gh,gw,opt1,opt2) 
{
    gap = gw;
    
    if (ng == 4) {
        
        gap = gw;
        
        
        ext = (w / (2.04167 * 2));
        

        size1 = opt1[3];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[2];
        gw2 = gw + gw * size2 / 100;
        size3 = opt1[1];
        gw3 = gw + gw * size3 / 100;
        size4 = opt1[0];
        gw4 = gw + gw * size4 / 100;
        
        gap1 = gap + gap * opt2[2] / 100;
        gap2 = gap + gap * opt2[1] / 100;
        gap3 = gap + gap * opt2[0] / 100;
        
    difference() {
    



    translate([0,0,-w/2])
   
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,- gap2/2 - gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    translate([0,0,- gap2/2 - gw2 - gap1 - gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
   
        translate([0,0,  gap2/2 + gw3/2])
    cylinder(gw3,r/0.9,r/0.9,center=true);
    
        translate([0,0,gap2/2 + gw3 + gap3 + gw4/2])
    cylinder(gw4,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,- gap2/2 - gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0,- gap2/2 - gw2 - gap1 - gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,  gap2/2 + gw3/2])
   cylinder(gw3,r-gh,r-gh,center=true);
   translate([0,0,gap2/2 + gw3 + gap3 + gw4/2])
   cylinder(gw4,r-gh,r-gh,center=true);
   }
   }

       if (ng == 3) {
        gap = gw;
        
       
        ext = (w / (2.04167 * 2));
        

        size1 = opt1[2];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[1];
        gw2 = gw + gw * size2 / 100;
        size3 = opt1[0];
        gw3 = gw + gw * size3 / 100;
        
        gap1 = gap + gap * opt2[1] / 100;
        gap2 = gap + gap * opt2[0] / 100;
           
    difference() {
   

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,0])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    translate([0,0, - gw2/2 - gap1 - gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0, gw2/2 + gap2 + gw3/2])
    cylinder(gw3,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0, 0])
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0, - gw2/2 - gap1 - gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0, gw2/2 + gap2 + gw3/2])
   cylinder(gw3,r-gh,r-gh,center=true);
   }
   }

          if (ng == 2) {
        gap = gw;
        
        
        ext = (w / (2.04167 * 2));
       

        size1 = opt1[1];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[0];
        gw2 = gw + gw * size2 / 100;
        
        gap1 = gap + gap * opt2[0] / 100;
              
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-gap1/2 - gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,gap1/2 + gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,-gap1/2 - gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,gap1/2 + gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   }
   }
             if (ng == 1) {
                         gap = gw;
        
        
        ext = (w / (2.04167 * 2));
        
        size1 = opt1[0];
        gw1 = gw + gw * size1 / 100;
                 
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,0])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,0])
   cylinder(gw1,r-gh,r-gh,center=true);
   }
   }

      if (ng == 5) {
        gap = gw;
        
       
        ext = (w / (2.04167 * 2));
        

        size1 = opt1[4];
        gw1 = gw + gw * size1 / 100;
        size2 = opt1[3];
        gw2 = gw + gw * size2 / 100;
        size3 = opt1[2];
        gw3 = gw + gw * size3 / 100;
        size4 = opt1[1];
        gw4 = gw + gw * size4 / 100;
        size5 = opt1[0];
        gw5 = gw + gw * size5 / 100;
        
        gap1 = gap + gap * opt2[3] / 100;
        gap2 = gap + gap * opt2[2] / 100;
        gap3 = gap + gap * opt2[1] / 100;
        gap4 = gap + gap * opt2[0] / 100;
        
        
    difference() {
    

    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,0])
    cylinder(gw3,r/0.9,r/0.9,center=true);
    translate([0,0,- gw3/2 - gap2 - gw2/2])
    cylinder(gw2,r/0.9,r/0.9,center=true);
    translate([0,0,- gw3/2 - gap2 - gw2 - gap1 - gw1/2])
    cylinder(gw1,r/0.9,r/0.9,center=true);
    translate([0,0,gw3/2 + gap3 + gw4/2])
    cylinder(gw4,r/0.9,r/0.9,center=true);
    translate([0,0,gw3/2 + gap3 + gw4 + gap4 + gw5/2])
    cylinder(gw5,r/0.9,r/0.9,center=true);
    }


   union() {
   translate([0,0,0])
   cylinder(gw3,r-gh,r-gh,center=true);
   translate([0,0,- gw3/2 - gap2 - gw2/2])
   cylinder(gw2,r-gh,r-gh,center=true);
   translate([0,0,- gw3/2 - gap2 - gw2 - gap1 - gw1/2])
   cylinder(gw1,r-gh,r-gh,center=true);
   translate([0,0,gw3/2 + gap3 + gw4/2])
   cylinder(gw4,r-gh,r-gh,center=true);
   translate([0,0,gw3/2 + gap3 + gw4 + gap4 + gw5/2])
   cylinder(gw5,r-gh,r-gh,center=true);
   }
   }

}







module wheel(w,r)
{
    difference(){
        wheel_1(w,r);
        cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true);
    }
}


module slick_1(w,AR,i)
{
    r_rim = i/2 * 25.4;  //Wheel radius
    r = r_rim + w * AR / 98;
    scale([1e-3,1e-3,1e-3])
    translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
    color([0.5,0.5,0.5])
    difference(){
    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true);
    }
}

module slick(w,r)
{
    scale([1e-3,1e-3,1e-3])
    translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
    color([0.5,0.5,0.5])
    difference(){
    translate([0,0,-w/2])
    rounded_cylinder(r=r,h=w,n=49,center=true);
    cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true);
    }
}

module LG_4(w,r)
{
    scale([1e-3,1e-3,1e-3])
    translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
   
    difference(){
        wheel_1(w,r);
        cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true);
    }
}

module LG_3(w,r)
{
        scale([1e-3,1e-3,1e-3])
    translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
    wheel_3(w,r);
}

module wheel_LG_far(w,r,ng,gh,gw)
{
    scale([1e-3,1e-3,1e-3])
    translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
    difference(){
    wheel_1(w,r,ng,gh,gw);
    cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true);
    }
}

module wheel_LG_far_mod(w,AR,i,ng,gh,gw)
{
    r_rim = i/2 * 25.4;  //Wheel radius
    r = r_rim + w * AR / 98;
    scale([1e-3,1e-3,1e-3])
    translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
    difference(){
    wheel_1(w,r,ng,gh,gw);
    cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true);
    }
}

module wheel_LG_left(w,AR,i,ng,gh,gw)
{
        r_rim = i/2 * 25.4;  //Wheel radius
    r = r_rim + w * AR / 98;
                scale([1e-3,1e-3,1e-3])
    translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
        difference(){
        wheel_1_left(w,r,ng,gh,gw);
        cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true);
    }
}

module wheel_LG_right(w,AR,i,ng,gh,gw)
{
        r_rim = i/2 * 25.4;  //Wheel radius
    r = r_rim + w * AR / 98;
    scale([1e-3,1e-3,1e-3])
    translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
        difference(){
        wheel_1_right(w,r,ng,gh,gw);
        cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true);
    }
}

module wheel_LG_central(w,AR,i,ng,gh,gw)
{
         r_rim = i/2 * 25.4;  //Wheel radius
    r = r_rim + w * AR / 98;
    scale([1e-3,1e-3,1e-3])
    translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
        difference(){
        wheel_1_central(w,r,ng,gh,gw);
        cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true);
    }
}


module wheel_LG_special(w,AR,i,ng,gh,gw,opt1,opt2)
{
         r_rim = i/2 * 25.4;  //Wheel radius
    r = r_rim + w * AR / 98;
    scale([1e-3,1e-3,1e-3])
    translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
        difference(){
        wheel_1_special(w,r,ng,gh,gw,opt1,opt2);
        cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true);
    }
}

module wheel_LG_left_special(w,AR,i,ng,gh,gw,opt1,opt2)
{
         r_rim = i/2 * 25.4;  //Wheel radius
    r = r_rim + w * AR / 98;
    scale([1e-3,1e-3,1e-3])
    translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
        difference(){
        wheel_1_left_special(w,r,ng,gh,gw,opt1,opt2);
        cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true);
    }
}

module wheel_LG_right_special(w,AR,i,ng,gh,gw,opt1,opt2)
{
         r_rim = i/2 * 25.4;  //Wheel radius
    r = r_rim + w * AR / 98;
    scale([1e-3,1e-3,1e-3])
    translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
        difference(){
        wheel_1_right_special(w,r,ng,gh,gw,opt1,opt2);
        cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true);
    }
}

module wheel_LG_central_special(w,AR,i,ng,gh,gw,opt1,opt2)
{
         r_rim = i/2 * 25.4;  //Wheel radius
    r = r_rim + w * AR / 98;
    scale([1e-3,1e-3,1e-3])
    translate([0,32,0])          //Needed to mound on the rim for sims
    rotate([90,0,0])            //Change plane
        difference(){
        wheel_1_central_special(w,r,ng,gh,gw,opt1,opt2);
        cylinder(2*w,r_rim*1.35,r_rim*1.35,center=true);
    }
}


module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n)
    offset(delta=-n)
    square([r,h]);
    square([n,h]);
  }
}
