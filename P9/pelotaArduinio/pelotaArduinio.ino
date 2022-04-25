int analogPin = 0;   // potentiometer connected to analog pin 3
int val = 0;         // variable to store the read value
int x = 0;
void setup() {
  pinMode(analogPin, INPUT);  // sets the pin as output
  Serial.begin(9600);
}

void loop() {
  val = analogRead(analogPin);  // read the input pin
  //Dependiendo del tipo de sensor, hay que cambiar los valores fromLow y fromHigh del mapeo
  //x = map(val, 200, 600, -100, 500);
  x = map(val, 400, 1000, -100, 500);
  Serial.println(x);
  delay(100);
}
