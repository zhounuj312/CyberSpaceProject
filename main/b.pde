
void Bsetup() { // custom setup = runs once
}

void Bdraw() { // custom draw = renders fooorever

  //SETTINGS [change, but don't delete any]
  myTextFont = "FreeSans.ttf"; // set font
  myTextSize = height*.6;
  useLowerCase = false;
  myTextLength = 15;
  processType("B"); // takes care of type for you, turn off if using custom
  background(bgColor);

  translate(width*.5, height*.5);
  noFill();
  if (pointPaths != null) { // draw if points ready
    pushMatrix();
    popMatrix();
    rotateZ(radians(frameCount*.4));
    int audioLoop = floor(map(audio.avgAudio, 0, 50, 1, 360));

    for (int k=0; k < audioLoop; k+=2) {
      for (int i = 0; i < pointPaths.length; i++) {
        pushMatrix();
        translate(0, 0, height/1.2);
        scale(map(k, 0, 360, 1, 0));
        rotateZ(radians(map(k, 0, 360, 0, 180)));
        noFill();
        stroke(map(k, 0, audioLoop, fgColor, bgColor));
        beginShape(); 

        for (int j=0; j < pointPaths[i].length; j++) {
          int audioWaveIndex = floor(map(j*k, 0, pointPaths[i].length*k, 0, audio.myAudio.bufferSize()));
          float audioWave = audio.myAudio.left.get(audioWaveIndex)*audio.myAudioAmp/2;
          int audioFreqIndex = floor(map(j, 0, pointPaths[i].length, 0, audio.myAudioFFT.avgSize()));
          float audioFreq = audio.myAudioFFT.getAvg(audioFreqIndex)*audio.myAudioAmp;
          vertex(pointPaths[i][j].x, pointPaths[i][j].y, -audioFreq*k*.2);
        } // j
        endShape();

        popMatrix();
      } // k
    } // i
  } // if pointsPath
}  // draw

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
