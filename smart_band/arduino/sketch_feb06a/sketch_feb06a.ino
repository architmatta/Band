
int inputPin = A0;
int reading;

void setup() {
  Serial.begin(9600);
  pinMode(inputPin, INPUT);
}

void loop() {
  reading = analogRead(inputPin/10);
  Serial.println(reading);
}
