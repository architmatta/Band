const int numReadings = 32;

int readings[numReadings];
float smoothData[numReadings]; //In case of Beta1 int gives diff value
//signed long smoothData[numReadings];
int readIndex = 1;
float Beta1 = 0.03125; //dec it to inc smoothness
int Beta2 = 4;
int starttime;

int inputPin = A0;
int outputPin = 8;

void setup() {
  Serial.begin(9600);
  for (int i = 0; i < numReadings; i++) {
    readings[i] = 0;
    smoothData[i] = 0;
  }

  pinMode(outputPin, OUTPUT);
  digitalWrite(outputPin, LOW);
  Serial.println("<Arduino is ready>");
}

void loop() {
  readings[readIndex] = analogRead(inputPin/10);
 // Serial.print(readings[readIndex]);
 // Serial.print(",");

  reduceNoise();
 // Serial.print(smoothData[readIndex]);
 // Serial.print(",");

  blinkLED();//give output in case of impulse

  readIndex = readIndex + 1;
  if (readIndex >= numReadings) {
    readIndex = 0;
  }

 // Serial.print("\n");
  delay(1);
}
void reduceNoise() {
  if (readIndex > 0 && readIndex < 32) {
    smoothData[readIndex] = Beta1 * readings[readIndex] \
                            + (1 - Beta1) * smoothData[readIndex - 1];
  }
  else if (readIndex == 0) {
    smoothData[readIndex] = Beta1 * readings[readIndex] \
                            +(1 - Beta1) * smoothData[31];
  }
}

void blinkLED() {

  if (readIndex > 0) {
    int deviation = readings[readIndex] - smoothData[readIndex];
    deviation = abs(deviation);
    //Serial.print(deviation);
    //Serial.print(",");
    int prevIndex = readIndex - 1;
    int prevDev = readings[prevIndex] - smoothData[prevIndex];
    prevDev = abs(prevDev);
    Serial.print(deviation);
    Serial.print(",");
    Serial.print(prevDev);
    Serial.print("\n");
    if (deviation >   10*(prevDev)
        /*&& deviation < 10 * (prevDev + 0.5)*/) {
      starttime = millis();
      //Serial.print("Case 1");
      digitalWrite(outputPin, HIGH);
      if (millis() - starttime > 500) {
        digitalWrite(outputPin, LOW);
      }
    }
    
    /*if (deviation > 15 * (prevDev + 0.5)
        && deviation < 20 * (prevDev + 0.5)) {
      starttime = millis();
      //Serial.print("Case 2");
      digitalWrite(outputPin, HIGH);
      if (millis() - starttime > 100) {
        digitalWrite(outputPin, LOW);
      }
    }
    if (deviation > 20 * (prevDev + 0.5)) {
      //Serial.print("Case 3");
      starttime = millis();
      digitalWrite(outputPin, HIGH);
      if (millis() - starttime > 150) {
        digitalWrite(outputPin, LOW);
      }
    }*/
  }
}

