const int numReadings = 32;
int count = 0;
int readings[numReadings];
float avg = 0.0; //In case of Beta1 int gives diff value
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
  readings[readIndex] = analogRead(inputPin);
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
  // Serial.print(avg);
  //Serial.print(",");
  avg = avg / 32;
}


void blinkLED() {
  Serial.print(readings[readIndex]);
  Serial.print(",");
  Serial.print(avg);
  Serial.print("\n");
  ++count;
  if (readIndex > 0 && count>=600) {

    if (readings[readIndex] > 1.7 * avg)
    {
      digitalWrite(outputPin, HIGH);
      delay(2000);
      digitalWrite(outputPin, LOW);

    }
  }


}


