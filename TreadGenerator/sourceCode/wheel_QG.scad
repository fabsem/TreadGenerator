fn = 100;
$fn = 100;

incl = 0;
nQG = 80;
L = 45;
QGl = L / cos(incl);
echo(QGl);
QGw = 3;
w = 245;
AR = 45; //Wheel aspect ratio
inches = 18;
r_rim = inches/2 * 25.4;  //Wheel radius
r = r_rim + w * AR / 98;


// support needed for LONGITUDINAL GROOVES
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

module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n)
    offset(delta=-n)
    square([r,h]);
    square([n,h]);
  }
}




// LATERAL GROOVES GENERATION

    //base per MRF volumes
module QG_mrf(incl,nQG,QGl,QGw) {

 //         translate([0,32,0])          //Needed to mound on the rim for sims
 //   rotate([90,0,0])            //Change plane
 //       difference(){

  //      wheel_1_right(w,r,ng,gh,gw);
  //      cylinder(2*w,r_rim*1.4,r_rim*1.35,center=true); //1.35
  //  }
    shift = (w / (2.04167 * 2)); 
     translate([0,32,0])          //Needed to mount on the rim for sims
    rotate([90,0,0])            //Change plane
      difference(){

         pathRadius=r;
         num=nQG;
         color([0.5,0.5,0.5])
         translate([0,0,(shift+32)])

          for (i=[1:num])  {

              //cube(size=[QGw,40,QGl],center=true);
              translate([pathRadius*cos(i*(360/num)),pathRadius*sin(i*(360/num)),0])
              rotate([0,0,(i-0) * (360/num)])

              rotate([180,0,180])
              translate([15,0,0])
             
                 rotate([incl,0,0])
                 cube(size=[30,QGw,QGl],center=true);
             
        }
        
    }
}
//incl = 40;

module QG_mrf_I(incl,nQG,QGl,QGw) {


    shift = (w / (2.04167 * 2)); 
     translate([0,32,0])          //Needed to mount on the rim for sims
    rotate([90,0,180])            //Change plane
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
           
                 rotate([-incl,0,0])
                 cube(size=[30,QGw,QGl],center=true);
               
        }
        
    }
}
    

  
module differencefunziona(incl,nQG,QGl,QGw,pathRadius,radius,angles,width){
    scale([1e-3,1e-3,1e-3])
difference(){
QG_mrf(incl,nQG,QGl,QGw);
    cutelement(pathRadius,nQG,incl,QGw,radius,angles,width);
}
}

module differencefunziona_I(incl,nQG,QGl,QGw,pathRadius,radius,angles,width){
    scale([1e-3,1e-3,1e-3])
    difference(){
        QG_mrf_I(incl,nQG,QGl,QGw);
        cutelement_I(pathRadius,num,incl,QGw,radius,angles,width);
    }
}





//supporto per rendere MRF curvo
radius = r/6;
angles = [40, 90];
width = 25;
//fn = 80;
shift = (w / (2.04167 * 2)); 



module sector(radius, angles, $fn = fn) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = fn) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 



num = nQG;
pathRadius = r/1.35;


// supporto per rendere MRF curvo matrice di rotazione 
module cutelement(pathRadius,num,incl,QGw,radius,angles,width) {

    rotate([0,incl/10,0])
translate([0, -32, 0])
rotate([90,0,-90])
      for (i=[1:num])  {

            
translate([0,pathRadius*cos(i*(360/num)),pathRadius*sin(i*(360/num))])
rotate([(i-0) * (360/num),0,0])
rotate([0,-incl,0])
linear_extrude(QGw*10,center=true) 
arc(radius, angles, width);
      }
}


module cutelement_I(pathRadius,num,incl,QGw,radius,angles,width) {
   rotate([0,incl/10,0])
translate([0, shift + 37, 0])

  rotate([90,0,180])  
      for (i=[1:num])  {

            
translate([pathRadius*cos(i*(360/num)),pathRadius*sin(i*(360/num)),0])
rotate([90,90,(i-0) * (360/num)])
    
          rotate([180,0,180])
          rotate([0,incl,0])
linear_extrude(QGw*10,center=true) 
arc(radius, angles, width);
      }
}




module QG_E() {
    
    difference(){
        scale([1e3,1e3,1e3])
        slick(w,r);
        differencefunziona(incl,nQG,QGl,QGw,pathRadius,radius,angles,width);
    }
    
}

module QG_2(){
    difference(){
        QG_E();
        differencefunziona_I(incl,nQG,QGl,QGw,pathRadius,radius,angles,width);
    }
}

module MRF_volume_E(){
  
    intersection(){
        differencefunziona(incl,nQG,QGl,QGw,pathRadius,radius,angles,width);
        QG_E();
    }

}



module MRF_volume_EE(w,AR,i,ng,gh,gw,incl,nQG,QGl,QGw,pathRadius,radius,angles,width){
    intersection(){
        differencefunziona(incl,nQG,QGl,QGw,pathRadius,radius,angles,width);

       wheel_LG_far_mod(w,AR,i,ng,gh,gw);
    }
}


module MRF_volume_II(w,AR,i,ng,gh,gw,incl,nQG,QGl,QGw,pathRadius,radius,angles,width){
    intersection(){
        differencefunziona_I(incl,nQG,QGl,QGw,pathRadius,radius,angles,width);

       wheel_LG_far_mod(w,AR,i,ng,gh,gw);
    }
}       

module QG_E_far(incl,nQG,QGl,QGw,w,AR,i,ng,gh,gw){
        difference(){
       
        wheel_LG_far_mod(w,AR,i,ng,gh,gw);
           
        differencefunziona(incl,nQG,QGl,QGw,pathRadius,radius,angles,width);
    }
}


module QG_2_far(incl,nQG,QGl,QGw,w,AR,i,ng,gh,gw){
 
    difference(){
        
        QG_E_far(incl,nQG,QGl,QGw,w,AR,i,ng,gh,gw);
        
        differencefunziona_I(incl,nQG,QGl,QGw,pathRadius,radius,angles,width);
}

}



module MRF_2_far(incl,nQG,QGl,QGw,w,AR,i,ng,gh,gw){
    MRF_volume_EE(w,AR,i,ng,gh,gw,incl,nQG,QGl,QGw,pathRadius,radius,angles,width);
    MRF_volume_II(w,AR,i,ng,gh,gw,incl,nQG,QGl,QGw,pathRadius,radius,angles,width);
}

i = inches;
ng = 4;
gh = 9.2;
gw = 10;



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

module wheel_1(w,r,ng,gh,gw)
{
    if (ng == 4) {
        //gap = (120 - ((ng-2)*2 + 2 * 1) * gw/2) / 3;
        ext = (w / (2.04167 * 2));
        gap = ((ext*2) - ng * gw) / (ng - 1);
    difference() {
    //cylinder(w,r,r,center=true);



    translate([0,0,-w/2])
    //rounded_cylinder(r=r,h=w,n=50,center=true);
    rounded_cylinder(r=r,h=w,n=49,center=true);
    translate([0,0,-ext + gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    translate([0,0,ext - gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    //translate([0,0,-20 + gw/2])
        translate([0,0,-gap/2 - gw/2])
    cylinder(gw,r/0.9,r/0.9,center=true);
    //translate([0,0,20 - gw/2])
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
       // 
    //cylinder(w,r,r,center=true);

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
    //cylinder(w,r,r,center=true);

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
          // gap = (120 - ((ng-2)*2 + 2 * 1) * gw/2) / (ng-1);
           ext = (w / (2.04167 * 2));
          gap = ((ext*2) - ng * gw) / (ng - 1);
    difference() {
    //cylinder(w,r,r,center=true);

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
