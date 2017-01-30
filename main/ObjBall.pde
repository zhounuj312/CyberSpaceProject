class ObjBall {
    float radius;
    int index;
    float flightLevel;
    float ratateRaius;
    ObjBall(float radius,int index,float flightLevel,float ratateRaius){
        this.radius = radius;
        this.index = index;
        this.flightLevel = flightLevel;
        this.ratateRaius = ratateRaius;
    }
    void updateRadius(float radius) {
        this.radius = radius;
    }
    void display(){
        sphere(radius);
    }
}
