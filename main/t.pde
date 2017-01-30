float ta = 3;
float tb = 3;
float tc = 0.1;

float tbass;
float tmid;
float thigh;
int tFrame;
void Tsetup() { // custom setup = runs once
	RG.setPolygonizerLength(audio.avgAudio); // use average audio for shape segmenting
	tFrame = 0;
}


void Tdraw() { // custom draw = renders fooorever

	tbass = audio.myAudioFFT.calcAvg(20, 400) * audio.myAudioAmp/10; // fft.calcAvg(minFreq, maxFreq)
	tmid = audio.myAudioFFT.calcAvg(400, 3000) * audio.myAudioAmp/2;
	thigh = audio.myAudioFFT.calcAvg(7000, 10000) * audio.myAudioAmp/5;
	//println(thigh);

	//SETTINGS [change, but don't delete any]
	myTextFont = "FreeSans.ttf"; // set font
	myTextSize = height * .8; // *NEW* set text size (0 - height)
	useLowerCase = false; // *NEW* optionally set true for lowercase
	myTextLength = 15; // custom cut length
	background(bgColor); // default background
	//backgroundFade(30); // very experimental.. sorta fails in 3D
	tFrame ++;
	// takes care of type for you
	if (tFrame >=20) processType("W");
	if (tFrame >=40) processType("WT");
	if (tFrame >=60) processType("WTF");

	pushMatrix(); // only adjusts translate/scale within matrix
	translate(width / 2, height / 2); // suggestion to draw from center out
	scale(.65); // <- custom scale of letters

	if (pointPaths != null) { // draw if points ready

		for (int i = 0; i < pointPaths.length; i++) {
			noFill();
			stroke(fgColor);

			beginShape(); // just demo shape below!
			for (int j = 0; j < pointPaths[i].length; j++) {

				int audioWaveIndex = floor(map(j, 0, pointPaths[i].length, 0, audio.myAudio.bufferSize()));
				float audioWave = audio.myAudio.left.get(audioWaveIndex) * audio.myAudioAmp;

				if (j % 6==0) {
					fill(fgColor);
					rectMode(CENTER);
					noStroke();
					rect((pointPaths[i][j].x) * map(audio.avgAudio, 0, audio.myAudioMax, 1.3, 1.7), pointPaths[i][j].y, tbass / 6, tbass / 6);
				}
				if (j % 8==0) {
					fill(fgColor, (map(pointPaths[i][j].y, 100, 10, 50, 200)) * 0.001 * ta / 3);
					noStroke();
					rect((pointPaths[i][j].x) * map(audio.avgAudio, 0, audio.myAudioMax, 1.3, 1.7), pointPaths[i][j].y, tmid , tmid);
				}
				else {
					pushMatrix();
					noStroke();
					fill(fgColor, (map(pointPaths[i][j].y, 50, 250, 50, 200)) * 0.5 * ta / 3);
					rect((pointPaths[i][j].x) * map(audio.avgAudio, 0, audio.myAudioMax, 1.3, 1.7), pointPaths[i][j].y, 1, tb / 5); // try other shapes
					popMatrix();
				}

				ta += 0.04;
				tb += 0.01;
				tc *= map(0, 0, audio.myAudioMax, 1, 1.1);

				fill(random(fgColor), 100);
				noStroke();
				if (ta >= 150) {
					ta *= -1;
				}

				//println(b);
				if (tb >= 70) {
					tb *= -1;
				}

				if (tc == 1 ) {
					tb *= -1;
				}
			} // j
			endShape();
		} // i
	} // if pointsPath
	popMatrix();
}  // draw
