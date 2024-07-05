// Persistence of Vision Ray Tracer Scene Description File

#include "colors.inc"
#include "metals.inc"
#include "textures.inc"

global_settings {
    assumed_gamma 2.2
}

camera {
  orthographic
  location      <7.5*sqrt(3)-0.5,-500,22>
  sky           z
  right         -50*image_width/image_height*x
  up            50*z
  look_at       <7.5*sqrt(3)-0.5,0,22>
}

background {rgb 1}

light_source {<20, -50,20 > rgb <0.28, 0.3, 0.3>}
light_source {<-25, -80,120> rgb <0.64, 0.66, 0.61>}
light_source {<-16,-50,0> rgb <0.1, 0.1, 0.15>}

// ----------------------------------------
#declare t1=texture{pigment{rgb <0.6,0.9,1>} finish{phong 0.4 specular 0.1 ambient 0.43 reflection 0.1}}
#declare t2=texture{pigment{rgb <0.9,0.3,0.4>} finish{phong 0.4 specular 0.1 ambient 0.43 reflection 0.1}}
#declare t3=texture{pigment{rgb <0.8,0.8,0.8>} finish{phong 0.4 specular 0.1 ambient 0.43 reflection 0.1}}
#declare t4=texture{pigment{rgb <0.4,0.3,0.9>} finish{phong 0.4 specular 0.1 ambient 0.43 reflection 0.1}}
#declare t5=texture{pigment{rgb <1,0.9,0.6>} finish{phong 0.4 specular 0.1 ambient 0.43 reflection 0.1}}
#declare r=0.5;

PARTICLES
