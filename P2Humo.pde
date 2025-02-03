// Problem description: //<>//
// 
//
//
// Differential equations:
// 
// 
//      


// Simulation and time control:

float _timeStep;        // Simulation time-step (s)
float _simTime = 0.0;   // Simulated time (s)

// Output control:

boolean _writeToFile = false;
boolean _useTexture = true;
PrintWriter _output;
PImage humoTextura;


// Variables to be monitored:

float _energy;                // Total energy of the system (J)
int _numParticles;            // Total number of particles
float t_comp;

ParticleSystem _ps,_ps1,_ps2;

PVector V;
// Main code:

void settings()
{
   size(DISPLAY_SIZE_X, DISPLAY_SIZE_Y);
}

void setup()
{
 
   frameRate(DRAW_FREQ);
   background(BACKGROUND_COLOR[0], BACKGROUND_COLOR[1], BACKGROUND_COLOR[2]);

   initSimulation();
}

void stop()
{
   endSimulation();
}

void keyPressed()
{
   if (key == 'r' || key == 'R')
      restartSimulation();
   else if (key == 't' || key == 'T')
      _useTexture = !_useTexture;
   else if (key == '+')
      _timeStep *= 1.1;
   else if (key == '-')
      _timeStep /= 1.1;
}

void initSimulation()
{
   if (_writeToFile)
   {
      _output = createWriter(FILE_NAME);
      writeToFile("t, E, n");
   }
     _ps = new ParticleSystem(S0);
     _ps1 = new ParticleSystem(S01);
      _ps2 = new ParticleSystem(S02);

   _simTime = 0.0;
   _timeStep = TS;
      

}

void restartSimulation()
{
   //
    initSimulation();
   //
}

void endSimulation()
{
   if (_writeToFile)
   {
      _output.flush();
      _output.close();
   }
}

void draw()
{
   drawStaticEnvironment();
   drawMovingElements();

   float t1 = millis();
   updateSimulation();
     float t2 = millis();
   t_comp = t2 - t1;
   displayInfo();

   if (_writeToFile)
      writeToFile(_simTime + ", " + _energy + ", " + _numParticles);
}

void drawStaticEnvironment()
{
   background(BACKGROUND_COLOR[0], BACKGROUND_COLOR[1], BACKGROUND_COLOR[2]);
 
}

void drawMovingElements()
{
   _ps.render(_useTexture);
   _ps1.render(_useTexture);
   _ps2.render(_useTexture);
}

void updateSimulation()
{
  
    _energy = _ps.getTotalEnergy() +  _ps1.getTotalEnergy() +  _ps2.getTotalEnergy();
    _simTime += _timeStep;
    
   for(int j = 0; j < NT * _timeStep; j++)
    {
    V = new PVector(vx + random(-90, 90), vy + random(-90, 90));
    _ps.addParticle(m, V0, V, r, 200,tiempovida);
    
     V = new PVector(vx2 + random(-90, 90), vy + random(-90, 90));
    _ps1.addParticle(m, V0, V, r, 255,tiempovida);
    
    V = new PVector(vx3 + random(-90, 90), vy + random(-90, 90));
    _ps2.addParticle(m, V0, V, r, 200,tiempovida);
}

   _ps.update(_timeStep);
   _ps1.update(_timeStep);
   _ps2.update(_timeStep);
 
  _numParticles = _ps.getNumParticles() +_ps1.getNumParticles() +_ps2.getNumParticles() ;
}

void writeToFile(String data)
{
   _output.println(data);
}

void displayInfo()
{
   stroke(TEXT_COLOR[0], TEXT_COLOR[1], TEXT_COLOR[2]);
   fill(TEXT_COLOR[0], TEXT_COLOR[1], TEXT_COLOR[2]);
   textSize(20);
   text("Draw: " + frameRate + "fps", width*0.025, height*0.05);
   text("Simulation time step = " + _timeStep + " s", width*0.025, height*0.075);
   text("Simulated time = " + _simTime + " s", width*0.025, height*0.1); 
   text("Number of particles: " + _numParticles, width*0.025, height*0.125);
   text("Total energy: " + _energy/1000.0 + " kJ", width*0.025, height*0.15);
}
