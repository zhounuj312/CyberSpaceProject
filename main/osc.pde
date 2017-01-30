
void oscEvent(OscMessage theOscMessage) {
	String pattern = theOscMessage.addrPattern();
	//截获theOscMessage.addrPattern的第二个字符 并转换为int值
	int indexOfGroup = int(pattern.substring(1,2));
	//分别处理不同的OSC消息
	//根据组的编号选择处理函数
	switch (indexOfGroup) {
	case 0:
		setEffectState(theOscMessage);
		break;
	case 1:
		setAudioAmp(theOscMessage);
	case 3:
		doRotary(theOscMessage);
	case 4:
		doPad(theOscMessage);
	default:
		break;
	}
}
void setAudioAmp(OscMessage theOscMessage){
	float value = theOscMessage.get(0).floatValue();
	audio.setAudioAmp(map(value,0,1,0,40));
	theOscMessage = null;
}
void doRotary(OscMessage theOscMessage){
	String pattern = theOscMessage.addrPattern();
	/*--- ChangeBgColor 部分-----------------------------------------*/
	if(pattern.equals("/3/CHANGESPPED")) {
		float value = theOscMessage.get(0).floatValue();
		if(value == 1) {
			changeColorSpeed = 255;
		}
		else{
			changeColorSpeed = map(value,0,1,0,80);
		}
	}
	if(pattern.equals("/3/CHANGE")) {
		float value = theOscMessage.get(0).floatValue();
		if (value == 1) {
			if(chooseBgFgColor == 0) {
				chooseBgFgColor = 1;
			}
			else if(chooseBgFgColor == 1) {
				chooseBgFgColor = 0;
			}
		}
	}
	/*--- Fade Background部分-----------------------------------------*/
	if(pattern.equals("/2/FADENUM")) {
		float value = theOscMessage.get(0).floatValue();
		fadeNumber = map(value,0,1,100,0);
	}
	if(pattern.equals("/2/FADE")) {
		float value = theOscMessage.get(0).floatValue();
		if( value == 0 ) doFade = false;
		if( value == 1 ) doFade = true;

	}
}
void doPad(OscMessage theOscMessage){
	String pattern = theOscMessage.addrPattern();
	/*--- 设置摄像机位置-----------------------------------------*/
	if(pattern.equals("/4/3D1")) {
		float valueOfY = theOscMessage.get(0).floatValue();
		cameraEyeY = map(valueOfY, 0, 1, 0, height);
		float valueOfX = theOscMessage.get(1).floatValue();
		cameraEyeX = map(valueOfX, 0, 1, 0, width);
	}
	if(pattern.equals("/4/Z")) {
		float valueOfZ = theOscMessage.get(0).floatValue();
		cameraEyeZ = map(valueOfZ, 0, 1, 0, height);

	}
	//处理RESET按钮
	if(pattern.equals("/4/RESET") && theOscMessage.get(0).floatValue() == 1) {
		//将3DPAD的坐标还原为中央
		OscMessage myMessage = new OscMessage("/4/3D1");
		myMessage.add(0.5);
		myMessage.add(0.5);
		oscP5.send(myMessage, myRemoteLocation);
		myMessage.clear();
		myMessage = new OscMessage("/4/Z");
		myMessage.add(0.5);
		oscP5.send(myMessage, myRemoteLocation);
		myMessage.clear();
		//将摄像机的坐标还原为中央
		cameraEyeY = height / 2;
		cameraEyeX = width / 2;
		cameraEyeZ = height / 2;

	}
}
//发送音频数据
void sendAudioInfo(){
	float[] audioInfo = new float[4];
	audioInfo[0] = audio.myAudioData[0];
	audioInfo[1] = audio.myAudioData[5];
	audioInfo[2] = audio.myAudioData[10]; //高频大小
	audioInfo[3] = audio.avgAudio;      //平均音频音量大小
	for(int i = 0; i < 4; i++) {
		OscMessage myMessage = new OscMessage("/5/SPECTRUM/" + (i + 1));
		float sendValue = map(audioInfo[i],0,100,0,1);
		myMessage.add(sendValue);
		oscP5.send(myMessage, myRemoteLocation);
		myMessage.clear();
	}

}
void doChangeColorBtn(OscMessage theOscMessage){
	String pattern = theOscMessage.addrPattern();


}
void setEffectState(OscMessage theOscMessage) {
	String pattern = theOscMessage.addrPattern();
	//获取addrPattern 如果按钮发送过来的值为 true则执行
	if(theOscMessage.get(0).floatValue() != 0 ) {
		// 设置doSetup 为 true
		pointPaths = null;
		doSetup = true;
		// 设置effectState的状态
		String name = pattern.substring(3,pattern.length());
		effectState = EffectNameEnum.valueOf(name);
		// 除了被按下的按钮 设置其他编组为0的按钮状态为false
		for(EffectNameEnum e : EffectNameEnum.values()) {
			//如果遍历到的枚举名等于现在被按下的按钮名则不执行
			if(e.toString().equals(name)) continue;
			//向TouchOsc发送消息设置按钮的值为false
			OscMessage myMessage = new OscMessage("/0/" + e.toString());
			myMessage.add(0);
			oscP5.send(myMessage, myRemoteLocation);
			myMessage.clear();
		}
	}
	else{
		//如果发送过来的为false 则设置状态值为IDLE
		effectState = EffectNameEnum.IDLE;

	}

}
