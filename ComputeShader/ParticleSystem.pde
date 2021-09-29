
class ParticleSystem {
  int computeWorkGroupSize;

  FloatList particleAttribList = new FloatList();
  float[] particlesBuffer;
  float[] particlesColorBuffuer;
  FloatBuffer fbParticles;
  FloatBuffer fbParticleColors;
  int numOfParticles;
  ShaderProgram shaderProgram;
  ComputeProgram computeProgram;

  ParticleSystem(int count) {
    IntBuffer getBuffer = IntBuffer.allocate(1);
    gl.glGetIntegeri_v(GL4.GL_MAX_COMPUTE_WORK_GROUP_SIZE, 0, getBuffer);
    computeWorkGroupSize = getBuffer.get(0);

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
    computeProgram = new ComputeProgram(gl, "comp.glsl", computeWorkGroupSize, fbParticles);
  }

  void update() {
    computeProgram.beginDispatch(ceil(numOfParticles/(float)computeWorkGroupSize), 1, 1);
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
