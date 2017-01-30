/*---- YOUR CUSTOM CODE BELOW --------------------------*/
/*---- PUT OWN VARIABLES JUST BEFORE customSetup()------*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0;
// int aSpeed = 0;

void LINEsetup() { // custom setup = runs once

}

void LINEdraw() {
	// custom draw = renders fooorever
	float supererTurn = (audio.myAudioMax);
	//SETTINGS [change, but don't delete any]
	myTextFont = "No Parking.ttf";   // set font
	myTextSize = height * .6; // *NEW* set text size (0 - height)
	useLowerCase = false;   // *NEW* optionally set true for lowercase
	myTextLength = 80;   // custom cut length
	processType("CyberSpace");   // takes care of type for you, turn off if using custom
	// background(0); // default background
	//backgroundFade(30); // very experimental.. sorta fails in 3D


	pushMatrix(); // only adjusts translate/scale within matrix

	translate(width / 2, height / 2); // suggestion to draw from center out
	// rotateY(radians(frameCount * 1));
	if (audio.avgAudio>40) {
		//rotateY(ampWave*2);
	}

	if (pointPaths != null) { // draw if points ready

		for (int i = 0; i < pointPaths.length; i++) {
			noFill();
			stroke(fgColor);

			beginShape(); // just demo shape below!
			for (int j = 0; j < pointPaths[i].length; j++) {

				int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, audio.myAudio.bufferSize()));
				float audioWave = audio.myAudio.right.get(audioWaveIndex) * audio.myAudioAmp;

				curveVertex(pointPaths[i][j].x + audioWave * 4, pointPaths[i][j].y, 105);//floor(easeAudio)
				curveVertex(pointPaths[i][j].x + audioWave * 4, pointPaths[i][j].y, 10);
			} // j
			endShape();


		} // i

	} // if points
	popMatrix();
	// drawFade();

	// cool laser

	// pushMatrix(); // only adjusts translate/scale within matrix
	//
	// translate(width / 2, height / 2); // suggestion to draw from center out
	// rotateY(radians(frameCount * 1));
	// if (audio.avgAudio>40) {
	//  rotateY(audio.myAudioAmp * 2);
	// }
	// popMatrix();
}  // draw

/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/
