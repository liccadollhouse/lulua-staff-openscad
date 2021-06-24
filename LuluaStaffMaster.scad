include <screwprimitives.scad>
include <HeartPrimitives.scad>
include <LuluaStaffSide.scad>

PipeDiameter = 27.5; // Use 3/4" Schedule 40 PVC pipe.
PipeLength = 420;

module LuluaStaffFerule()
{
    
    difference()    
    {
        union()
        {
            difference()
            {
                cylinder(d=40,h=40,$fn=128);
                
                translate([0,0,20])
                scale([1,1,1.5])
                    rotate_extrude(convexity=10,$fn=256)
                        translate([32,0,0]) circle(d=30,$fn=256);
            }        
            hull()
            {
                translate([0,0,39]) cylinder(d=40,h=1,$fn=256);
                translate([0,0,150]) sphere(d=6,$fn=256);
            }
        }
        cylinder(d=PipeDiameter,h=120,$fn=256,center=true);        
    }

}

module LuluaStaffHandleJoin()
{
    difference()
    {
        union()
        {
            translate([0,0,0])
                scale([1,1,1.5])
                rotate([0,180,0])
                rotate_extrude($fn=128)
                union()
                {
                    translate([15,0,0])circle(r=5);
                    translate([0,-5,0])square([15,10]);        
                }
            
            translate([0,0,-7])
            hull()
            {
                cylinder(h=1,d=32,$fn=128);
                translate([0,0,-30]) cylinder(h=1,d=60,$fn=128);
                
            }
            
            translate([0,0,-38])
            hull()
            {        
                cylinder(h=1,d=60,$fn=128);
                translate([0,0,-30]) cylinder(h=1,d=32,$fn=128);
            }
        }
        
        cylinder(d=PipeDiameter,h=400,$fn=256,center=true);
        translate([-83,5,-80]) rotate([90,6,0]) scale([7.01,7.01,1.01])LuluaStaffSide(10);
        mirror([1,0,0]) translate([-83,5,-80]) rotate([90,6,0]) scale([7.01,7.01,1.01])LuluaStaffSide(10);
        translate([0,0,-37]) rotate([0,90,0]) cylinder(d=ScrewDiameter8,h=400,$fn=64,center=true);
        translate([0,0,-37]) rotate([0,90,0]) cylinder(d=14,h=40,$fn=64,center=true);
    }

}

module LuluaStaffBottle()
{
    difference()
    {
        union()
        {
            translate([0,0,-112]) 
            intersection()
            {
                translate([0,0,-30]) cube(150,center=true);
                sphere(d=110,$fn=256);
            }
            translate([0,0,-180]) cylinder(d=50,h=70,center=true,$fn=128);
        }
        translate([0,0,-200]) cylinder(d=PipeDiameter,h=400,$fn=256,center=true);
        
        
    }
}

module SpikePyramid()
{
polyhedron(
  points=[ [0,10,0],[10,0,0],[0,-10,0],[-10,0,0], // the four points at base
           [0,0,30]  ],                                 // the apex point 
  faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
              [1,0,3],[2,1,3] ]                         // two triangles for square base
 );
    
}

module LuluaStaffHeartTopSpike()
{
    difference()
    {
        union()
        {
            translate([0,0,-345]) SpikePyramid();
            translate([0,0,-345]) mirror([0,0,1])SpikePyramid();
        }
        translate([0,0,-380]) cube(30,center=true);
        translate([0,0,-304]) cube(30,center=true);
    }
    
}

module LuluaStaffHeartTopFin()
{
    translate([-85,2.5,-335])
    rotate([90,45,0]) 
    linear_extrude(height=5)
    {        
        difference()
        {
            intersection()
            {
                translate([-82,0,0]) circle(d=200,$fn=256);
                translate([82,0,0]) circle(d=200,$fn=256);
            }
            translate([-45,-10,0])rotate([0,0,-70]) square(60,center=true);
            translate([-45,25,0])rotate([0,0,-80]) square(60,center=true);
        }   
    }    
}

module LuluaStaffHeartTopBody()
{
    difference()
    {
        translate([0,0,-290])
        rotate([-90,0,0])
        difference()
        {
               
            linear_extrude(height=15,center=true)
            {
                heart_mod(h=100,center=true);
            }                            
    
            linear_extrude(height=20,center=true)
            {
                heart_mod(h=80,center=true);
            }            
        }
        translate([0,0,-220]) cylinder(d=ScrewDiameter8,h=120,$fn=64,center=true);
        translate([0,0,-270]) cylinder(d=10,h=40,$fn=64,center=true);
        scale([1.02,1.02,1.02]) LuluaStaffHeartTopSpike();
        scale([1.02,1.02,1.02]) LuluaStaffHeartTopFin();
        scale([1.02,1.02,1.02]) mirror([1,0,0]) LuluaStaffHeartTopFin();
        translate([-80,0,-250]) rotate([0,-45,0]) cylinder(d=ScrewDiameter6,h=120,$fn=64,center=true);
        translate([-41,0,-288.8]) rotate([0,-45,0]) cylinder(d=8,h=10,$fn=64,center=true);
    }        
}

module LuluaStaffHeartTopBase()
{
    difference()
    {
        hull()
        {
            translate([0,0,-220])
            {
                cylinder(d=60,h=10,center=true,$fn=128);
            }
            
            translate([0,0,-250])
            {
                cylinder(d=50,h=1,center=true,$fn=128);
            }
        }
        scale([1.01,1.01,1.01]) LuluaStaffHeartTopBody();
        translate([0,0,-220]) cylinder(d=PipeDiameter,h=40,$fn=256,center=true);
        translate([0,0,-220]) cylinder(d=ScrewDiameter8,h=120,$fn=64,center=true);
    }
}




module LuluaStaffSideFinal()
{
    difference()
    {
        translate([-83,5,-80]) rotate([90,6,0]) scale([7,7,1])LuluaStaffSide(10);
        translate([0,0,-37]) rotate([0,90,0]) cylinder(d=ScrewDiameter8,h=100,$fn=64,center=true);
        translate([-41,0,-37]) rotate([0,90,0]) linear_extrude(height=7) NutWell8_2d();
    }
}

module LuluaStaffHeartChain1()
{
    
    difference()
    {
        translate([-75,0,-240])
        rotate([-90,30,0])
        union()
        {
            difference()
            {
                   
                linear_extrude(height=15,center=true)
                {
                    heart_mod(h=90,center=true);
                }                            
        
                linear_extrude(height=20,center=true)
                {
                    heart_mod(h=70,center=true);
                }            
            }
            translate([0,-46,0])
            difference()
            {
                cylinder(h=5,d=5,center=true,$fn=64);
                cylinder(h=5.1,d=2.5,center=true,$fn=64);
            }
        }
        translate([-40,0,-290]) rotate([0,-45,0]) cylinder(d=ScrewDiameter6,h=50,$fn=64,center=true);    
        translate([-53,0,-276.8]) rotate([0,-45,0]) cylinder(d=10,h=10,$fn=64,center=true);
    }   
    
}

module LuluaStaffHeartChain2()
{
    translate([-15,-70,-180])
    rotate([-90,65,0])
    union()
    {
        difference()
        {
               
            linear_extrude(height=15,center=true)
            {
                heart_mod(h=90,center=true);
            }                            
    
            linear_extrude(height=20,center=true)
            {
                heart_mod(h=70,center=true);
            }            
        }
        translate([0,-46,0])
        difference()
        {
            cylinder(h=5,d=5,center=true,$fn=64);
            cylinder(h=5.1,d=2.5,center=true,$fn=64);
        }
        translate([0,38,0])
        difference()
        {
            cylinder(h=5,d=5,center=true,$fn=64);
            cylinder(h=5.1,d=2.5,center=true,$fn=64);
        }
    }              
}

module LuluaStaffHeartChain3()
{
    translate([125,-70,-120])
    rotate([-90,25,0])
    union()
    {
        difference()
        {
               
            linear_extrude(height=10,center=true)
            {
                heart_mod(h=70,center=true);
            }                            
    
            linear_extrude(height=15,center=true)
            {
                heart_mod(h=50,center=true);
            }            
        }
        translate([0,-36.5,0])
        difference()
        {
            cylinder(h=5,d=5,center=true,$fn=64);
            cylinder(h=5.1,d=2.5,center=true,$fn=64);
        }
        translate([0,31,0])
        difference()
        {
            cylinder(h=5,d=5,center=true,$fn=64);
            cylinder(h=5.1,d=2.5,center=true,$fn=64);
        }
    }              
}
module LuluaStaffHeartChain4()
{
    translate([125,-50,-60])
    rotate([-90,-25,0])
    union()
    {
        difference()
        {
               
            linear_extrude(height=5,center=true)
            {
                heart_mod(h=40,center=true);
            }                            
    
            linear_extrude(height=10,center=true)
            {
                heart_mod(h=30,center=true);
            }            
        }
        translate([0,-21.5,0])
        difference()
        {
            cylinder(h=5,d=5,center=true,$fn=64);
            cylinder(h=5.1,d=2.5,center=true,$fn=64);
        }
        translate([0,18,0])
        difference()
        {
            cylinder(h=5,d=5,center=true,$fn=64);
            cylinder(h=5.1,d=2.5,center=true,$fn=64);
        }
    }              
}

/*
LuluaStaffHeartChain1();
LuluaStaffHeartChain2(); // Print two of these
translate([80,0,40]) LuluaStaffHeartChain2();

LuluaStaffHeartChain3();
LuluaStaffHeartChain4();


LuluaStaffSideFinal();
mirror([1,0,0]) LuluaStaffSideFinal();
cylinder(d=PipeDiameter,h=300,$fn=256);
translate([0,0,250]) LuluaStaffFerule();

LuluaStaffHandleJoin();
LuluaStaffBottle();

LuluaStaffHeartTopBody();
LuluaStaffHeartTopBase();
LuluaStaffHeartTopFin();
mirror([1,0,0]) LuluaStaffHeartTopFin();

//translate([0,0,-319.1])cylinder(h=1,d=20,$fn=32);
LuluaStaffHeartTopSpike();
*/