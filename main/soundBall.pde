
ObjBall[] objBall;
float ballAngle;
float ballCubeAngleX;
float ballCubeAngleY;
float ratateSpeed = 0.01;
float ratateRaius = 300;

void BALLsetup() {
	float ballMaxRaius = width/3;
	float ballMinRaius = ballMaxRaius - width/10;
	objBall = new ObjBall[180];
	println(ballMaxRaius);
	for(int i = 0; i < objBall.length; i++) {
		objBall[i] = new ObjBall(random(5),int(random(11)),random(-40,40),random(ballMinRaius,ballMaxRaius));
	}
}


void BALLdraw() {

	background(bgColor);
	for(int i = 0; i < objBall.length; i++) {
		objBall[i].updateRadius(map(audio.myAudioData[objBall[i].index],0,20,0.5,10));
	}



    //画个小方块在中央
	pushMatrix();
	translate(width / 2,height / 2,0);
	fill(fgColor);
	// strokeWeight(1);
	stroke(fgColor);
	ballCubeAngleX += map(audio.myAudioData[1],0,20,0,0.3);
	ballCubeAngleY += map(audio.myAudioData[0],0,20,0,0.3);
	rotateX(ballCubeAngleX);
	rotateZ(ballCubeAngleY);
	box(25);
	popMatrix();

	pushMatrix();
	translate(width / 2,height / 2,0);
	noFill();
	// strokeWeight(1);
	stroke(fgColor);
	rotateX(ballCubeAngleX);
	rotateZ(ballCubeAngleY);
	box(50);
	popMatrix();
	//编号0的音频Band决定 旋转的速度
	ballAngle += map(audio.myAudioData[0],0,20,0,0.03);
	//排列小球成星系状
	pushMatrix();
	translate(width / 2,height / 2);
	rotateY(ballAngle);
	sphereDetail(6);
	fill(fgColor);
	noStroke();
	for(int i = 0; i < objBall.length; i++) {
		pushMatrix();
		float x = sin((PI / 180) * (360 / objBall.length) * i) * objBall[i].ratateRaius;
		float z = cos((PI / 180) * (360 / objBall.length) * i) * objBall[i].ratateRaius;
		translate(x,objBall[i].flightLevel,z);
		objBall[i].display();
		popMatrix();
	}
	popMatrix();

}
