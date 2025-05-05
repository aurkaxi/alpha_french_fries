#include <SoftwareSerial.h>
SoftwareSerial BT(0, 1);  // TX, RX

// === PIN MAP ===
// Output: 8 bits total
//   PORTD6 - Pin 6  (bit 0)
//   PORTD7 - Pin 7  (bit 1)
//   PORTB0 - Pin 8  (bit 2)
//   PORTB1 - Pin 9  (bit 3)
//   PORTB2 - Pin 10 (bit 4)
//   PORTB3 - Pin 11 (bit 5)
//   PORTB4 - Pin 12 (bit 6)
//   PORTB5 - Pin 13 (bit 7)

// Input: 3 bits


// === STATE TRACKING ===
byte lastOutput = 0xFF;  // Force update on first run
byte lastInput = 0xFF;   // Force input send on first loop

void setup() {
  BT.begin(9600);  // HC-06 default baud rate
  Serial.begin(57600);

  // === Set output bits (Pin 6 and 7 of Port D) ===
  DDRD |= 0b11000000;  // Set pins 6 and 7 of PORTD as output

  // === Set output bits (Pins 0 to 5 of Port B) ===
  DDRB |= 0b00111111;  // Set pins 0 to 5 of PORTB as output
}

void loop() {
  // === Read from HC-06 ===
  if (BT.available()) {
    byte incoming = BT.read();
    if (incoming != lastOutput) {
      setOutputPins(incoming);
      lastOutput = incoming;
    }
  }

  // === Read input and send back ===
  byte currentInput = readInputPins();
  if (currentInput != lastInput) {
    BT.write(currentInput);
    lastInput = currentInput;
  }
}

// === Set Output Pins Using PORTB and PORTD ===
void setOutputPins(byte value) {
  // First 2 bits to PORTD6 and PORTD7
  PORTD = (PORTD & 0b00111111) | ((value & 0b00000011) << 6);

  // Remaining 6 bits to PORTB0–5
  PORTB = (PORTB & 0b11000000) | ((value >> 2) & 0b00111111);
}

// === Read A0–A2 as 3-bit binary from PINC ===
byte readInputPins() {
  return 0b00000101;
}
