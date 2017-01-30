/*---- YOUR CUSTOM CODE BELOW ------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()-----*/
// float myCustomVar = 0;

void Psetup() { // custom setup = runs ones
}

void Pdraw() { // custom draw = renders fooorever
  //SETTINGS [change, plz don't delete any]
  myTextFont = "FreeSans.ttf"; // ie. "apple_ii.ttf";
  myTextSize = height*.75; // <- custom size
  myTextLength = 2; // <- custom length for cuts
  processType("P"); // <- function happens below
  background(bgColor); // <- up to you if you want a background!

  pushMatrix(); // only adjusts translate/scale within matrix
  translate(width/2, height/2); // suggestion to draw from center out
  scale(.4); // <- custom scale of letters

  float audioShrink = .3;

  if (pointPaths != null) { // only draw if pointPaths ready
    noFill(); // optional..
    stroke(fgColor); // optional...



    beginShape();

    //fill(255, 255, 255, 20);
    //rect(displayWidth, displayHeight, displayWidth, displayHeight);
for(int j = 0; j < pointPaths.length; j++){
    for (int i=0; i < pointPaths[j].length; i++) {

      int audioIndex = floor(map(i, 0, pointPaths[j].length, 0, audio.myAudioFFT.avgSize()));
      int audioMouseX = floor(map(mouseY/2, 0, pointPaths[j].length, 0, audio.myAudioFFT.avgSize()));
      float audiolLevel = audio.myAudioFFT.getAvg(audioIndex)*audio.myAudioAmp*i/10*audioShrink;



      //noCursor();
      noStroke();

      float distance = abs(audio.avgAudio/3);

      fill(fgColor, distance);

      rotateY(audio.avgAudio/audio.myAudioAmp*10); // use mouseX to rotate one axis of entire shape

      //rotateX(map(height, 0, width, PI, -PI)/200); // use mouseX to rotate one axis of entire shape
      ellipse(pointPaths[j][i].x + audiolLevel*10, pointPaths[j][i].y, 7, 7);
      ellipse(pointPaths[j][i].x - audiolLevel*10, pointPaths[j][i].y, 7, 7);
      //size audio
      ellipse(pointPaths[j][i].x, pointPaths[j][i].y, 7 + audio.avgAudio*audioShrink, 7 + audio.avgAudio*audioShrink);


      if (audio.avgAudio*audioShrink < audio.myAudioAmp*2) {
        fill(fgColor, distance*1.5);
        rotateY(0);
        ellipse(pointPaths[j][i].x, pointPaths[j][i].y, audio.avgAudio*2*audioShrink, audio.avgAudio*2*audioShrink);
        ellipse(pointPaths[j][i].x, pointPaths[j][i].y, audio.avgAudio*2*audioShrink, audio.avgAudio*2*audioShrink);
      }

      if (audio.avgAudio*audioShrink < audio.myAudioAmp*4) {
        fill(fgColor, fgColor, fgColor, distance);
        rotateY(0);
        ellipse(pointPaths[j][i].x, pointPaths[j][i].y, audio.avgAudio*audioShrink, audio.avgAudio*audioShrink);
        ellipse(pointPaths[j][i].x, pointPaths[j][i].y, audio.avgAudio*audioShrink, audio.avgAudio*audioShrink);
      }


    }
    endShape();

    //shape2
    /*
    beginShape();
     for (int i=0; i < pointPaths.length; i++) {

     int audioIndex = floor(map(i, 0, pointPaths.length, 0, fft.avgSize()));
     int audioMouseX = floor(map(mouseX/2, 0, pointPaths.length, 0, fft.avgSize()));
     float audiolLevel = fft.getAvg(audioIndex)*audio.myAudioAmp*i/10;

     noCursor();
     noStroke();
     fill(255, 50);
     ellipse(pointPaths[j][i].x + audiolLevel, pointPaths[j][i].y -audiolLevel, audio.myAudioAmp, audio.myAudioAmp);
     }
     endShape();*/
    }
    popMatrix();
    } // END CUSTOM CODE
}


/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
