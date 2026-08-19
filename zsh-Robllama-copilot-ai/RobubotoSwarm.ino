#include <SPI.h>
#include <RF24.h>

#define CE_PIN   4
#define CSN_PIN  5

RF24 radio(CE_PIN, CSN_PIN);
const byte address[6] = "ROBUB";

void setup() {
  Serial.begin(115200);
  while (!Serial);

  if (!radio.begin()) {
    Serial.println(F("NRF24L01 hardware not responding!"));
    while (1);
  }

  radio.setChannel(34); 
  radio.openWritingPipe(address);
  radio.setPALevel(RF24_PA_MAX);
  radio.stopListening();

  Serial.println(F("Robuboto 34MHz Shadow Spectrum Photon Swarm Initialized."));
}

void loop() {
  if (Serial.available()) {
    char text[32] = "";
    int bytesRead = Serial.readBytesUntil('\n', text, sizeof(text) - 1);
    text[bytesRead] = '\0';

    bool report = radio.write(&text, sizeof(text));

    if (report) {
      Serial.print(F("ROBUB_SUCCESS -> Sent: "));
      Serial.println(text);
    } else {
      Serial.println(F("ROBUB_FAILURE -> 34MHz carrier transmission dropped."));
    }
  }
}
