#include <Average.h>

const int numReadings = 32;

Average<float> readings(numReadings);

int readIndex = 1;
float average = 0.0;
float largest = 0.0;
float smallest = 0.0;
float deviation = 0.0;

int inputPin = A0;
int outputPin = 13;

void setup() {
  Serial.begin(9600);
  /*for (int i = 0; i < numReadings; i++) {
    readings.push(0);
    }*/

  pinMode(outputPin, OUTPUT);
  Serial.println("<Arduino is ready>");
}

void loop() {
  readings.push(analogRead(inputPin/10));
  //Serial.print(readings);
  //Serial.print(",");

  average = readings.mean();
  largest = readings.maximum();
  smallest = readings.minimum();
  deviation = readings.stddev();

  Serial.print(average);
  Serial.print(",");
  /*Serial.print(largest);
  Serial.print(",");
  Serial.print(smallest);
  Serial.print(",");
  Serial.print(deviation);
  Serial.print(",");*/

  /*readIndex = readIndex + 1;
    if (readIndex >= numReadings) {
    readIndex = 0;
    }*/

  for (int i = 0; i < numReadings; i++) {
    Serial.print(readings.get(i));
    Serial.print(",");
    Serial.print(average);
    Serial.print(",");
    /*Serial.print(largest);
    Serial.print(",");
    Serial.print(smallest);
    Serial.print(",");
    Serial.print(deviation);
    Serial.print(",");
    Serial.println();*/
  }
/*
  Serial.println();
  delay(1);*/
}
