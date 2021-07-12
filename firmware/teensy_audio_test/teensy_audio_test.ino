#include <Audio.h>
#include <Wire.h>
#include <SPI.h>
#include <SD.h>
#include <SerialFlash.h>

// GUItool: begin automatically generated code
AudioPlaySdWav           playSdWav1;     //xy=193,208
AudioOutputI2S           i2s1;           //xy=404,208
AudioConnection          patchCord1(playSdWav1, 0, i2s1, 0);
AudioConnection          patchCord2(playSdWav1, 1, i2s1, 1);
// GUItool: end automatically generated code

#define SDCARD_CS_PIN    BUILTIN_SDCARD
#define SDCARD_MOSI_PIN  11  // not actually used
#define SDCARD_SCK_PIN   13  // not actually used

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
  Serial.begin(9600);

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
  delay(500);
  // spin while the intro sound plays
  while (playSdWav1.isPlaying()) {
    delay(100);
  }
}

void loop() {
  playSdWav1.play("BLAZE.WAV");
  delay(5000);
}
