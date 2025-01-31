import com.jogamp.opengl.*;
import com.jogamp.common.nio.Buffers;
import java.nio.IntBuffer;
import java.nio.FloatBuffer;

ParticleSystem ps;
GL4 gl;

void setup() {
  size(1000, 1000, P2D);

  PGL pgl = ((PGraphicsOpenGL)g).pgl;
  gl = ((PJOGL)pgl).gl.getGL4();

  ps = new ParticleSystem(1920*1080);
}

void draw() {
  background(0);
  ps.update();
  ps.render();
}

void dispose() {
  ps.release();
}
