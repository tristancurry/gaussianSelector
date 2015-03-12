float sigma = 1.0; //value of population st. dev (1 for Z units)
int sigmaDomain = 15; //how many standard deviations either side of the mean to bother drawing from
float sigmaResolution = .3; //how wide to make the bins for counting
final float sigmaSquared = sq(sigma); //precalculation of variance to avoid having to square repeatedly for fixed parameters
float mu = 0;
final float sqrtTwoPi = sqrt(TWO_PI); //precalculation
final float alpha = 1/(sigma*sqrtTwoPi); //precalculation of normalising factor to avoid having to square repeatedly for fixed parameters
int[] scores = new int[2*(int(sigmaDomain/sigmaResolution)) + 1];
int trials = 1000;

float yScale;


void setup() {
  size(600, 600);
  yScale = height/(2*sigmaResolution*alpha*trials);
}

void draw() {
  background(100);
  if (frameCount >= trials) {
    noLoop();
  }
  //conversion of a uniform prob distribution density function into a Gaussian one (inefficient)!
  float X = random(-1*sigmaDomain*sigma, sigmaDomain*sigma);
  float Y = random(0, alpha);
  while (Y > gaussian1 (X)) {
    X = random(-1*sigmaDomain*sigma, sigmaDomain*sigma);
    Y = random(0, alpha);
  }


//tallying according to bin size
  int p = int(round(X/sigmaResolution));
  p = p+int(sigmaDomain/sigmaResolution);
  scores[p]++;
//drawing a histogram
  for (int i = 0; i < scores.length; i++) {

    rect(i*width/(1.0*scores.length), 0, 1*width/(1.0*scores.length), yScale*scores[i]);
  }

  textAlign(RIGHT);
  textSize(14);
  text("number of trials = " + frameCount, width - 5, height - 5);
}







//Gaussian function
float gaussian(float x, float a, float b, float c) {
  float g = a*exp(-1*sq(x - b)/(2*sq(c)));
  return g;
}

//Gaussian function with parameters that generate standard normal distro
float gaussian1(float x) {
  float g = alpha*exp(-1*sq(x - mu)/(2*sigmaSquared));
  return g;
}

