const int numReadings = 32;
int readings[numReadings];
const int thresh = 10;
boolean result = false;
int inputPin = 0;
int outputPin = 13;
int readIndex = 0;

void setup() {
  Serial.begin(9600);
  for (int i = 0; i < numReadings; i++) {
    readings[i] = 0;
  }
  pinMode(outputPin, OUTPUT);
  Serial.println("Arduino is ready");
}

void loop() {
  result = false;
  readings[readIndex] = analogRead(inputPin);
  //Serial.println(readings[readIndex]);
  //Serial.print(",");

  readIndex = readIndex + 1;
  if (readIndex >= numReadings) {
    readIndex = 0;
  }

  //peak detection
  float avg = 0;
  int max_ht = 0;
  avg = readings[0];
  for(int i=1; i<numReadings; i++)
  {
    Serial.println(readings[i]);
    avg = (float)((avg*i) + readings[i])/(float)(i+1);
    if(abs((float)readings[i]-avg) > (thresh*abs((float)max_ht-avg)))
    {
      result = true;
      Serial.print(readings[i-1]);
      Serial.print(" ");
      Serial.print(readings[i]);
      Serial.print(" ");
      Serial.println(readings[i+1]);
      break;
    }
    else if(abs(readings[i]-avg) > abs(max_ht-avg))
    {
      max_ht = readings[i];
    }    
  }  
}

