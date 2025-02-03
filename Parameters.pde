// Display and output parameters:

final int DRAW_FREQ = 100;                            // Draw frequency (Hz or Frame-per-second)
final int DISPLAY_SIZE_X = 1000;                      // Display width (pixels)
final int DISPLAY_SIZE_Y = 1000;                      // Display height (pixels)
final int [] BACKGROUND_COLOR = {30, 20, 50};         // Background color (RGB)
final int [] TEXT_COLOR = {255, 255, 0};              // Text color (RGB)
final String FILE_NAME = "data.csv";                  // File to write the simulation variables 


// Parameters of the problem:

final float TS = 0.01;     // Initial simulation time step (s)
final float NT = 100.0;    // Rate at which the particles are generated (number of particles per second) (1/s)           
final float tiempovida= 1.0;       // Particles' lifespan (s) 
final float m =3.1;
final float r = 1.8;
final float Kd = 0.0001;


//


// Constants of the problem:

final String TEXTURE_FILE = "sprite.png";
final PVector S0 = new PVector(DISPLAY_SIZE_X/2, DISPLAY_SIZE_Y); 
final PVector S01 = new PVector(DISPLAY_SIZE_X/2+50, DISPLAY_SIZE_Y); 
final PVector S02 = new PVector(DISPLAY_SIZE_X/2-50, DISPLAY_SIZE_Y); 


final PVector V0 = new PVector(0.0, 0.0);  


final float vx = 1; 
final float vy = -1000;  



final float vx2 = 1; 
final float vy2 = -1000; 



final float vx3 = 1; 
final float vy3 = -1000;  


final float G = 9.801;     // Gravedad m/s² 
final float GM = G * 100; // Gravedad cm/s²
final PVector Gg = new PVector(0, GM);  
