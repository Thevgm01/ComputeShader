
class ParticleSystem {
  FloatList particleAttribList = new FloatList();
  float[] particlesBuffer;
  float[] particlesColorBuffuer;
  FloatBuffer fbParticles;
  FloatBuffer fbParticleColors;
  int numOfParticles;
  ShaderProgram shaderProgram;
  ComputeProgram computeProgram;

  ParticleSystem(int count) {

    numOfParticles = count;
    particlesBuffer = new float[count * 6];
    for (int i=0; i<count; i++) {
      particlesBuffer[i * 6 + 0] = random(-1, 1); // pos X
      particlesBuffer[i * 6 + 1] = random(-1, 1); // pos Y
      //particlesBuffer[i * 6 + 2] = 0;           // vel X
      //particlesBuffer[i * 6 + 3] = 0;           // vel Y
      //particlesBuffer[i * 6 + 4] = 0;           // acc X
      //particlesBuffer[i * 6 + 5] = 0;           // acc Y
    }

    fbParticles = Buffers.newDirectFloatBuffer(particlesBuffer);
    shaderProgram = new ShaderProgram(gl, "vert.glsl", "frag.glsl");
    computeProgram = new ComputeProgram(gl, "comp.glsl", fbParticles);
  }

  void update() {
    computeProgram.beginDispatch(ceil(numOfParticles/1024f), 1, 1);
    shaderProgram.begin();
  }

  void render() {
    shaderProgram.draw(numOfParticles);
  }

  void release() {
    shaderProgram.release();
    computeProgram.release();
  }
}
