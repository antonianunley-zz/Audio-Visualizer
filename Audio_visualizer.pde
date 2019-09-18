//Imports needed
import ddf.minim.analysis.*;
import ddf.minim.*;

//object needed to access microphone
AudioInput input;

//works with input to access microphone sound
Minim minim;
//needed analyze the sound
FFT fft;
int bands = 64;

void setup()
{
    size(513, 480);
    minim = new Minim(this);
    input = minim.getLineIn();
    //input will be based on your computers input capabilities
    fft = new FFT(input.bufferSize(), input.sampleRate()); 
}

void draw()
{
  background(205, 174, 232);
  stroke(255);
  int w = width/bands;
  fft.forward(input.mix);
  
  //println(fft.specSize());
  line (0, height/2, width, height/2);
  
  for (int i = 0; i < fft.specSize(); i++){
    
    //making the outline white
    stroke(255,255,255); 
    //filling the circles with random colors
    fill(255,255,255);
    float amp = fft.getBand(i) * 10;
    if (amp > height/2){ //Use if statements to prevent the bars from crossing
      rect(i,height, 1,-fft.getBand(i));
      rect(i * w,height, w-2,height/2);
    } else {
      rect(i,height, 1,-fft.getBand(i));
      rect(i * w,height, w-2,-amp);
    }
     //creating an inverted image on the top of the screen
     stroke(0);
     fill(0);
     if (amp < height/2){
       rect(i,0, 1,-fft.getBand(i));
       rect(i * w,0, w-2,amp);
     } else {
       rect(i,0, 1,-fft.getBand(i));
       rect(i * w,0, w-2,height/2);
     }
     //println(fft.getBand(1));
  }
  noStroke();
 
}
  
