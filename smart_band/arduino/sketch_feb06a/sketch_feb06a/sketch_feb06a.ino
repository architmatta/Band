const int numReadings = 32;

int readings[numReadings];
float avg; //In case of Beta1 int gives diff value
//signed long smoothData[numReadings];
int readIndex = 1;
int starttime;

int inputPin = A0;
int outputPin = 8;

void setup() {
  Serial.begin(9600);
  for (int i = 0; i < numReadings; i++) {
    readings[i] = 0;
      }

  pinMode(outputPin, OUTPUT);
  digitalWrite(outputPin, LOW);
  Serial.println("<Arduino is ready>");
}

void loop() {
  readings[readIndex] = analogRead(inputPin/10);
 // Serial.print(readings[readIndex]);
 // Serial.print(",");

  calcavg();
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
void calcavg() {
 for (int i = 0; i < numReadings; i++) {
    avg = avg + readings[i];
      }
      avg = avg/32;
  }


void blinkLED() {

  if (readIndex > 0) {
    
    if (readings[i] >   10*avg)
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

