class AudioProcesser {
Minim minim;
AudioPlayer myAudio;
BeatDetect beat;


FFT myAudioFFT;

boolean showVisualizer = false;

int myAudioRange = 11;
int myAudioMax = 100;
float avgAudio; // store avg volume

float myAudioAmp = 20.0;
float myAudioIndex = 0.05;
float myAudioIndexAmp = myAudioIndex;
float myAudioIndexStep = 0.05;

float[]       myAudioData = new float[myAudioRange];

AudioProcesser(PApplet stage){
	minim = new Minim(stage);
	myAudio = minim.loadFile("tokyo.mp3");
	beat = new BeatDetect(myAudio.bufferSize(), myAudio.sampleRate());
    beat.setSensitivity(300);
	myAudio.loop();

	myAudioFFT = new FFT(myAudio.bufferSize(), myAudio.sampleRate());
	myAudioFFT.linAverages(myAudioRange);
	// myAudioFFT.window(FFT.TRIANGULAR);
}
AudioProcesser(PApplet stage,String fileName){
	minim = new Minim(stage);
	myAudio = minim.loadFile(fileName);
	myAudio.loop();
	beat = new BeatDetect(myAudio.bufferSize(), myAudio.sampleRate());
    beat.setSensitivity(300);

	myAudioFFT = new FFT(myAudio.bufferSize(), myAudio.sampleRate());
	myAudioFFT.linAverages(myAudioRange);
	// myAudioFFT.window(FFT.TRIANGULAR);
}

void setAudioAmp(float audioAmp){
	myAudioAmp = audioAmp;
}
void myAudioDataUpdate() {
    //获取Beat
	beat.detect(myAudio.mix);
	//计算平均音频音量
	for (int i = 0; i < myAudioFFT.avgSize (); i++) {
      avgAudio+= abs(myAudioFFT.getAvg(i)*myAudioAmp); // duplicate everything for stereo w/ right too!
    }
    avgAudio /= myAudioFFT.avgSize();

	myAudioFFT.forward(myAudio.mix);
	for (int i = 0; i < myAudioRange; ++i) {
		float tempIndexAvg = (myAudioFFT.getAvg(i) * myAudioAmp) * myAudioIndexAmp;
		float tempIndexCon = constrain(tempIndexAvg, 0, myAudioMax);
		myAudioData[i] = tempIndexCon;
		myAudioIndexAmp += myAudioIndexStep;
	}
	myAudioIndexAmp = myAudioIndex;

}

void myAudioDataWidget() {
	// noLights();
	// hint(DISABLE_DEPTH_TEST);
	noStroke(); fill(0,200); rect(0, height - 112, width, 102);
	for (int i = 0; i < myAudioRange; ++i) {
		fill(#CCCCCC);
		rect(10 + (i * 5), (height - myAudioData[i]) - 11, 4, myAudioData[i]);
	}
	// hint(ENABLE_DEPTH_TEST);
}

void stop() {
	myAudio.close();
	minim.stop();

}

}
