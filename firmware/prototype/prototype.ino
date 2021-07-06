// prototyping on arduino nano

void setup() {
  // put your setup code here, to run once:
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);
}

void loop() {
  delay(10000);
  doBlaze();
}

void doBlaze() {
  // pulse side tear gem leds round in circles
  // TODO
  
  // play the blaze sound (can this be done in the background?)
  // TODO

  // wait for elena to say "blaze"
  // delay(??)

  // vibrate the shaft (ooh matron)
  digitalWrite(7, HIGH);
  
  // flash all the leds in a "bip bi beeeeep" pattern
  digitalWrite(8, HIGH);
  delay(100);
  digitalWrite(8, LOW);
  delay(150);
  digitalWrite(8, HIGH);
  delay(75);
  digitalWrite(8, LOW);
  delay(200);
  digitalWrite(8, HIGH);
  delay(1500);

  // leds and vibration off
  digitalWrite(8, LOW);
  digitalWrite(7, LOW);
}
