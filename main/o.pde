/*---- PUT OWN VARIABLES JUST BEFORE customSetup()-----*/
// name vars starting with your letter to avoid duplicate variables!
// float aXpos = 0;
// int aSpeed = 0;

void Osetup() { // custom setup = runs once
}

void Odraw() { // custom draw = renders fooorever

	//SETTINGS [change, but don't delete any]
	myTextFont = "FreeSans.ttf"; // ie. "apple_ii.ttf";
	myTextSize = height * .75; // <- custom size
	myTextLength = 10; // <- custom length for cuts
	processType("O"); // <- function below (comment out if you prefer custom)
	background(bgColor); // <- up to you if you want a background!
	//backgroundFade(20); // prefer fade?
	smooth();



	pushMatrix(); // only adjusts translate/scale within matrix
	translate(width / 2, height / 2); // suggestion to draw from center out
	//scale(0.65);

	if (pointPaths != null) { // only draw if points ready
		noFill(); // optional..
		stroke(fgColor); // optional...
		//fill(255);

		for (int i = 0; i < pointPaths.length; i++) {
			pushMatrix();
			scale(map(audio.avgAudio,0,audio.myAudioMax,.3,.75));   // <- custom scale of letters

			for (int k = 1; k<30; k++) {
				rotateY(map(k,1,10,0,2 * PI) + radians(frameCount * 0.1));
				stroke(fgColor);
				beginShape();
				for (int j = 0; j < pointPaths[i].length; j++) {



					int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, audio.myAudio.bufferSize()));
					float audioWave = audio.myAudio.left.get(audioWaveIndex) * audio.myAudioAmp;

					//int loop Points = int map(easeAudio,0,maxAudio,0,pointsPath[i].length));

					//float aSize = map(avgAudio,0,maxAudio,5,50);

					vertex(pointPaths[i][j].x, pointPaths[i][j].y,5,10); // try other shapes

					//line(pointPaths[i][j].x+audioFreq, pointPaths[i][j].y+audioFreq,10,10); // try other shapes
					// [i] refers to which character, [j] refers to which point in that character
				}
				endShape();
			} // k
			popMatrix();

			pushMatrix();

			//demo
			for (int k = 1; k<100; k += 10) {
				rotateX(map(k,1,10,0,2 * PI) + radians(frameCount * 0.1));
				stroke(fgColor);
				beginShape();
				for (int j = 0; j < pointPaths[i].length; j++) {
					int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, audio.myAudio.bufferSize()));
					float audioWave = audio.myAudio.left.get(audioWaveIndex) * audio.myAudioAmp;

					vertex(pointPaths[i][j].x, pointPaths[i][j].y,5, 10); // try other shapes

				}
				endShape();
			}
            popMatrix();
		}



		popMatrix();
	}
}
/*---- YOUR CUSTOM CODE ABOVE ------------------------*/
/***** DON'T EDIT BELOW *******************************/
