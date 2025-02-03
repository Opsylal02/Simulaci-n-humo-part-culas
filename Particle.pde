// Class for a simple particle with no rotational motion
public class Particle
{
   ParticleSystem _ps;  // Reference to the parent ParticleSystem
   int _id;             // Id. of the particle (-)

   float _m;            // Mass of the particle (kg)
   PVector _s;          // Position of the particle (m)
   PVector _v;          // Velocity of the particle (m/s)
   PVector _a;          // Acceleration of the particle (m/(s·s))
   PVector _F;          // Force applied on the particle (N)
   float _energy;       // Energy (J)

   float _radius;       // Radius of the particle (m)
   color _color;        // Color of the particle (RGBA)
   float _lifeSpan;     // Total time the particle should live (s)
   float _timeToLive;   // Remaining time before the particle dies (s)

   Particle(ParticleSystem ps, int id, float m, PVector s, PVector v, float radius, color c, float lifeSpan)
   {
      _ps = ps;
      _id = id;

      _m = m;
      _s = s;
      _v = v;

      _a = new PVector(0.0, 0.0);
      _F = new PVector(0.0, 0.0);
      _energy = 0.0;

      _radius = radius;
      _color = c;
      _lifeSpan = lifeSpan;
      _timeToLive = _lifeSpan;
   }

   void setPos(PVector s)
   {
      _s = s;
   }

   void setVel(PVector v)
   {
      _v = v;
   }

   PVector getForce()
   {
      return _F;
   }

   float getEnergy()
   {
      return _energy;
   }

   float getRadius()
   {
      return _radius;
   }

   float getColor()
   {
      return _color;
   }

   float getTimeToLive()
   {
      return _timeToLive;
   }

   boolean isDead()
   {
      return (_timeToLive <= 0.0);
   }

   void update(float timeStep)
   {
      _timeToLive -= timeStep;

      updateSimplecticEuler(timeStep);
      updateEnergy();
      
   }

   void updateSimplecticEuler(float timeStep)
   {
      updateForce();
    
      _v.add(PVector.mult(_a, timeStep));  
      _s.add(PVector.mult(_v, timeStep));  
   }

 // Actualización de fuerzas
void updateForce() {
  
  
   PVector Fpeso = PVector.mult(Gg, _m); 

  
   PVector Viento = new PVector(1.0, 0.0); 
   PVector randomviento = PVector.sub(Viento, _v);
   PVector Froz = PVector.mult(randomviento, Kd); 
   
   println(Froz);
   _F = PVector.add(Froz, Fpeso);

     _a = _F.div(_m);
}


void updateEnergy() {
  
   float h = (DISPLAY_SIZE_Y - _s.y)/100; //altura
   
   float Ep = _m * G * h; 
   
   float Ec = _v.mag() * _v.mag() * _m / 200; 
   
   _energy = Ep + Ec;
}


   void render(boolean useTexture)
   {
      if (useTexture)
      {
         PImage imagen = _ps._tex;
        imageMode(CENTER);
        image(imagen,_s.x, _s.y);
       float transparency = map(_timeToLive, 0, _lifeSpan, 0, 255);
        tint(255, transparency); // Establecer el color de transparencia
        image(imagen, _s.x, _s.y);
        
      } 
      else
      {
         noStroke();
        fill(152,200,255);
        ellipse(_s.x, _s.y, 10, 10);
      }
   }
}
