// prototyping on NodeMCU

uint8_t TIP_LED_STALK = D0;
uint8_t VIB_MOTOR = D1;
uint8_t GEM_LEDS[] = {D2, D5, D6};

bool USE_VIBRATION_MOTOR = false;

//uint8_t PIN_MP3_RX = D5; // connected to TX by way of a 2.2kohm/3.3kohm voltage divider
// in case dfplayermini is transmitting at 5v
//uint8_t PIN_MP3_TX = D6; // connected to RX with a 1kohm resister in series. since we are
// sending at 3.3v, no need for a v divider.

void setup() {
  // Init USB serial port for debugging
  Serial.begin(9600);
  
  // put your setup code here, to run once:
  pinMode(GEM_LEDS[0], OUTPUT);
  pinMode(GEM_LEDS[1], OUTPUT);
  pinMode(GEM_LEDS[2], OUTPUT);
  pinMode(TIP_LED_STALK, OUTPUT);
  pinMode(VIB_MOTOR, OUTPUT);
}

void loop() {
  delay(5000);
  doBlaze();
}

void setSideGemLeds(uint8_t highOrLow) {
  for (int ledIdx = 0; ledIdx < 3; ledIdx++)
  {
    digitalWrite(GEM_LEDS[ledIdx], highOrLow);
  }
}

void doBlaze() {
  // play the blaze sound (can this be done in the background?)
  //player.playMp3Folder(2);

  // while elena says "blaze"
  // pulse side tear gem leds round in circles
  setSideGemLeds(LOW);
  for (int i = 0; i < 5; i++) {
    for (int ledIdx = 0; ledIdx < 3; ledIdx++)
    {
      digitalWrite(GEM_LEDS[ledIdx], HIGH);
      delay(50);
      digitalWrite(GEM_LEDS[ledIdx], LOW);
    }
  }
  // light all side gems
  setSideGemLeds(HIGH);

  // vibrate the shaft (ooh matron)
  if (USE_VIBRATION_MOTOR)
    digitalWrite(VIB_MOTOR, HIGH);
  
  // flash diamond led in a "bip bi beeeeep" pattern
  digitalWrite(TIP_LED_STALK, HIGH);
  delay(100);
  digitalWrite(TIP_LED_STALK, LOW);
  delay(150);
  digitalWrite(TIP_LED_STALK, HIGH);
  delay(75);
  digitalWrite(TIP_LED_STALK, LOW);
  delay(200);
  digitalWrite(TIP_LED_STALK, HIGH);
  delay(1000);

  // leds and vibration off
  digitalWrite(TIP_LED_STALK, LOW);
  setSideGemLeds(LOW);
  if (USE_VIBRATION_MOTOR)
    digitalWrite(VIB_MOTOR, LOW);
}
