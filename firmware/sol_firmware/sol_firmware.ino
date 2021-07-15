#include <Audio.h>
#include <MPU6050_tockn.h>
#include <Wire.h>
#include <SPI.h>
#include <SD.h>
#include <SerialFlash.h>

// On the Teensy 4.1, I2C wiring is SDA on pin 18, SCL on pin 19
MPU6050 mpu6050(Wire);

// GUItool: begin automatically generated code
AudioPlaySdWav           playSdWav1;     //xy=193,208
AudioAnalyzePeak         peak1;          //xy=435,254
AudioOutputI2S           i2s1;           //xy=525,137
AudioConnection          patchCord1(playSdWav1, 0, i2s1, 0);
AudioConnection          patchCord2(playSdWav1, 0, peak1, 0);
AudioConnection          patchCord3(playSdWav1, 1, i2s1, 1);
// GUItool: end automatically generated code


const uint8_t SDCARD_CS_PIN = BUILTIN_SDCARD;
const uint8_t SDCARD_MOSI_PIN = 11;  // not actually used
const uint8_t SDCARD_SCK_PIN = 13;  // not actually used
const uint8_t TIP_LED_STALK_PIN = 32;
const uint8_t GEM_LED_PINS[] = {31, 30, 29};
const uint8_t VIB_MOTOR_PIN = 28;

bool USE_VIBRATION_MOTOR = true;

// moving average data for accelerations
float maFilterBuf[10] = {0};
int nextIdx = 0;
long lastBlazeTime;

/*
 * For the Adafruit MAX98357 I2S Class-D Mono Amp module I had to set the gain
 * to 6dB as default 9 was distorted for 0.5w 8ohm speaker.

From docs, how to adjust gain:
 * GAIN is, well, the gain setting. You can have a gain of 3dB, 6dB, 9dB, 12dB or 15dB.

15dB if a 100K resistor is connected between GAIN and GND
12dB if GAIN is connected directly to GND
9dB if GAIN is not connected to anything (this is the default)
6dB if GAIN is conneted directly to Vin
3dB if a 100K resistor is connected between GAIN and Vin

I2S wiring:
Pin 20 (LRCLK1) on Teensy 4.1 goes to LRC on MAX98357
Pin 21 (BCLK1) on Teensy goes to BCLK on MAX98357
Pin 7 (OUT1A) on Teensy goes to DIN on MAX98357
 */

void setup() {
  // Init USB serial port for debugging
  Serial.begin(9600);

  Wire.begin();

  mpu6050.begin();
  //mpu6050.calcGyroOffsets(true); // don't need to do this
  // if just reading raw accel sensor

  // pin setup
  pinMode(GEM_LED_PINS[0], OUTPUT);
  pinMode(GEM_LED_PINS[1], OUTPUT);
  pinMode(GEM_LED_PINS[2], OUTPUT);
  pinMode(TIP_LED_STALK_PIN, OUTPUT);
  pinMode(VIB_MOTOR_PIN, OUTPUT);

  AudioMemory(8);

  SPI.setMOSI(SDCARD_MOSI_PIN);
  SPI.setSCK(SDCARD_SCK_PIN);
  if (!(SD.begin(SDCARD_CS_PIN))) {
    // stop here, but print a message repetitively
    while (1) {
      Serial.println("Unable to access the SD card");
      delay(500);
    }
  }

  playSdWav1.play("THEME.WAV");
  delay(200);
  // spin while the intro sound plays
  while (playSdWav1.isPlaying()) {
    float highestAmplitudeSinceLastRead = peak1.read();
    // gate amp into 3 bands - first no leds, second side gems,
    // third tip gem. The numbers are slightly wav file dependent
    // to make the lights dance with the music.
    if (highestAmplitudeSinceLastRead > 0.45) {
      setSideGemLeds(HIGH);
      digitalWrite(TIP_LED_STALK_PIN, HIGH);
    } else if (highestAmplitudeSinceLastRead > 0.35) {
      setSideGemLeds(HIGH);
      digitalWrite(TIP_LED_STALK_PIN, LOW);
    } else {
      setSideGemLeds(LOW);
      digitalWrite(TIP_LED_STALK_PIN, LOW);
    }
    delay(50);
  }
  setSideGemLeds(LOW);
  digitalWrite(TIP_LED_STALK_PIN, LOW);

  lastBlazeTime = millis();
}

void loop() {
  mpu6050.update();

  float Ax = mpu6050.getAccX();
  float Ay = mpu6050.getAccY();
  float Az = mpu6050.getAccZ();
  float accelMag = sqrt((Ax * Ax) + (Ay * Ay) + (Az * Az));

  // Something's not right with my setup. Reading mostly 0.98 from
  // accel (=gravity, good), but sporadically thre will be 1-5 very low / 0
  // readings. Also sometimes 2.67 spikes.
  // crap hardware? loose connections? line noise? crap software lib?
  // To work around this issue in short term, I've created
  // a moving average filter of 10 points for acceleration vector
  // magnitude, and added a 1 second threshold, so the sound
  // doesn't keep being triggered (gives time for MA filter to settle).
  // TODO: put in fancy gesture classification ML system

  maFilterBuf[nextIdx] = accelMag;
  nextIdx = ++nextIdx % 10;
  Serial.println(nextIdx);
  float averageAccelMag = 0;
  for (int i = 0; i < 10; i++)
  {
    averageAccelMag += maFilterBuf[i];
  }
  averageAccelMag = averageAccelMag/10;

  Serial.print("current accel reading: ");
  Serial.print(accelMag);
  Serial.print(", Av reading: ");
  Serial.println(averageAccelMag);

  // don't play sound within second of previous
  if (averageAccelMag > 1.5 && millis() - lastBlazeTime > 1000) {
    doBlaze();
  }
}

void setSideGemLeds(uint8_t highOrLow) {
  for (int ledIdx = 0; ledIdx < 3; ledIdx++)
  {
    digitalWrite(GEM_LED_PINS[ledIdx], highOrLow);
  }
}

void doBlaze() {
  // play the blaze sound
  playSdWav1.play("BLAZE.WAV");

  // while Elena says "Blaze!"
  // pulse side tear gem leds round in circles
  setSideGemLeds(LOW);
  for (int i = 0; i < 5; i++) {
    for (int ledIdx = 0; ledIdx < 3; ledIdx++)
    {
      digitalWrite(GEM_LED_PINS[ledIdx], HIGH);
      delay(50);
      digitalWrite(GEM_LED_PINS[ledIdx], LOW);
    }
  }
  // light all side gems
  setSideGemLeds(HIGH);

  // vibrate the shaft (ooh matron)
  if (USE_VIBRATION_MOTOR)
    digitalWrite(VIB_MOTOR_PIN, HIGH);
  
  // flash diamond led in a "bip bi beeeeep" pattern
  digitalWrite(TIP_LED_STALK_PIN, HIGH);
  delay(100);
  digitalWrite(TIP_LED_STALK_PIN, LOW);
  delay(150);
  digitalWrite(TIP_LED_STALK_PIN, HIGH);
  delay(75);
  digitalWrite(TIP_LED_STALK_PIN, LOW);
  delay(200);
  digitalWrite(TIP_LED_STALK_PIN, HIGH);
  delay(1000);

  // leds and vibration off
  digitalWrite(TIP_LED_STALK_PIN, LOW);
  setSideGemLeds(LOW);
  if (USE_VIBRATION_MOTOR)
    digitalWrite(VIB_MOTOR_PIN, LOW);

  lastBlazeTime = millis();
}
