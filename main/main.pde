// CC Shanghai University Of Engineering Science
// This is part of Zhou Juren and Pan Yi graduation project,
// Design by Zhou Junren, Pan Yi 2017
// built in Processing 3.2.3
// This project require minim, openkinect, geomerative, oscP5 library.
// You can download these library in processing IDE.


/*---- SETTINGS 设置 ---------------------------------------*/
boolean fullScreenToggle = true;        //是否全屏
int sizeWidth = 500, sizeHeight = 500; //不全屏的话则设置画布大小
String musicFileName = "tokyo.mp3";     //Data文件夹内音频的文件名
float bgColor = 0;
float fgColor = 255;

void settings(){
	if(fullScreenToggle) {
		fullScreen(P3D);
	}
	else{
		size(sizeWidth,sizeHeight,P3D);
	}
}

/*---- Audio 音频部分 ---------------------------------------*/
import ddf.minim.*;
import ddf.minim.analysis.*;
AudioProcesser audio;

/*--- TYPE 部分 ------------------------------------------*/
import geomerative.*;
RShape grp;
RPoint[][] pointPaths; // 2D array = an array of arrays!
PFont myFont;
String myTextFont = "FreeSans.ttf";
float myTextSize = 250;
float myTextLength = 25;
boolean shiftDown = false;
boolean useLowerCase = false;

/*--- Kinect&OSC 部分 ------------------------------------------*/
import oscP5.*;      //加载osc库
import netP5.*;      //加载net库

OscP5 oscP5;
int oscPort = 12000;                     //设置OSC通讯的端口
String oscReceiverAddress = "172.20.10.3"; //设置接受者IP
int oscReceiverPort = 9000;
NetAddress myRemoteLocation;

/*--- 效果状态器 部分 ------------------------------------------*/
public enum EffectNameEnum {
	IDLE, BALL, LINE,T,P,B,F,O
};
//是否显示Fade效果
boolean doFade;
float fadeNumber;
boolean doSetup;
EffectNameEnum effectState;
/*--- 摄像机位置 部分 ------------------------------------------*/
float cameraEyeX = width / 2;
float cameraEyeY = height / 2;
float cameraEyeZ = height / 2;
/*--- Setup() 初始化函数 -----------------------------------*/
void setup(){
	background(bgColor);
	audio = new AudioProcesser(this, musicFileName);   //初始化音频处理器
	//初始化OSC
	oscP5 = new OscP5(this,12000);
	myRemoteLocation = new NetAddress(oscReceiverAddress,oscReceiverPort);
	//初始化 effectState 为idle状态
	effectState = EffectNameEnum.IDLE;
	//初始化 RG
	RG.init(this);
	cameraEyeX = width / 2;
	cameraEyeY = height / 2;
	cameraEyeZ = height / 2;
}
/*--- draw() 每一帧会被执行一次-----------------------------------*/
void draw(){
	background(bgColor);

	audio.myAudioDataUpdate(); //刷新音频数据
	sendAudioInfo();
	pushMatrix();
	camera(cameraEyeX, cameraEyeY, (cameraEyeZ) / tan(PI * 30.0 / 180.0), width / 2.0, height / 2.0, 0, 0, 1, 0);
	//画效果
	changeBgFg();
	drawEffect();
	popMatrix();

	fill(fgColor);
	textSize(12);
	text("FPS: "+frameRate, 10, 30); //显示当前帧率
}
/*--- 选择对应的效果 -----------------------------------*/
void drawEffect(){
	if(effectState == EffectNameEnum.IDLE) {
		background(bgColor);
		return;
	}
	//p5在PApplet类中定义了method()这一方法,详情查阅Processing Java docs
	if(doSetup) {
		method(effectState.toString() + "setup");
		doSetup = false;
	}
	method(effectState.toString() + "draw");
}

/*--- 处理字体-----------------------------------------*/
void processType(String myText) {
	grp = RG.getText(myText, myTextFont, 250, CENTER);
	grp = RG.centerIn(grp, g, constrain(map(myTextSize, 0, height, height * .5, 0), 0, height * .5));
	RG.setPolygonizer(RG.UNIFORMLENGTH); // type of division
	RG.setPolygonizerLength(myTextLength); // size of divisions
	pointPaths = grp.getPointsInPaths(); // get coordinates for every point
}

/*--- 交换前后景颜色 -----------------------------------------*/
int chooseBgFgColor; float changeColorSpeed;

void changeBgFg(){
	if (chooseBgFgColor == 0) {
		if(bgColor >= 0) bgColor = bgColor - changeColorSpeed;
		if(fgColor <= 255) fgColor = fgColor + changeColorSpeed;
	}
	if (chooseBgFgColor == 1) {
		if(bgColor <= 255) bgColor = bgColor + changeColorSpeed;
		if(fgColor >= 0) fgColor = fgColor - changeColorSpeed;
	}
}
/*--- 画Fade效果-----------------------------------------*/
// void drawFade(){
// 	if(doFade) {
// 		fill(0,100);
// 		noStroke();
// 		rect(0,0,width,height);
// 	}
// 	else{
// 		background(bgColor);
// 	}
// }
