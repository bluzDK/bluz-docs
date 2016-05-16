#Local Communication with Bluz

This tutorial will walk you through communicating locally with bluz. Local communication means data transferred directly from the gateway to bluz DK, without going through the Particle cloud.

Local communication can be used for a lot of tasks that don't require the cloud. For example, if you wanted a custom app to talk directly to bluz. Or if you were using a gateway but wanted the Particle board to do some work on behalf of bluz, such as posting HTTP requests or sending data over TCP/UDP.

Local communication can be used with or without the cloud, the two are parallel and not dependent on eachother.

For this tutorial, you will need:

- One bluz DK
- One power source (battery shield, battery, USB line, etc.)
- A bluz gateway or gateway shield with a Particle Core/Photon/Electron

##Programming the Particle Board
The code that runs on the Particle board that turns it into a gateway already has the proper function for handling custom data. There is a function called, intuitively enough, handle_custom_data, and this is where you would put code that handles local data from bluz.

In this example, we will have the gateway publish an event. This isn't the most interesting use case since bluz could also publish the event. However, if you wanted the Particle device to do more complicated tasks that bluz cannot do, such as sending TCP data, this is what you would need to do.

To implement this on the gateway side, simply implement this function in the Particle gateway shield code:

```C++
void handle_custom_data(uint8_t *data, int length) {
    //if you use BLE.send from any connected DK, the data will end up here
    if (length == 3) {
        Particle.publish("Local Communication With Bluz")
    }

}
```

Flash the full gateway sketch with this code to the Particle device that is plugged into the gateway shield.

##Programming bluz
In order for the gateway shield to receive data, bluz DK must send data. This can be acheived by using the BLE.sendData function.

To send data from a bluz DK and trigger the above publish, flash this sketch to your bluz DK board:

```C++
#define LED D7
#define TIME_BETWEEN_SENDS 2000

int timeLastSent = 0;
bool ledOn = false;

void setup() {
   pinMode(LED, OUTPUT);
}

void loop() {
    System.sleep(SLEEP_MODE_CPU);
    if (Particle.connected() && millis() - timeLastSent > 2000) {
        uint8_t data[3] = {0x01, 0x02, 0x03};
        BLE.sendData(data, sizeof(data));
        timeLastSent = millis();

        digitalWrite(LED, ledOn ? LOW : HIGH);
        ledOn = !ledOn;
    }
}
```

This code sends data locally to the gateway shield every two seconds. Notice that we are sending 3 bytes. If we sent more or less, the Publish from the gateway shield wouldn't work as it is expecting 3 bytes.

This sketch will toggle the LED on D7, every time it flips, you should see the event published from your Particle board.

##Running the example
Once you have flashed the code to both boards, turn on the gateway shield and let it connect. Then turn on your bluz DK with the above sketch, it will connect automatically and once it is online, you will start to the see the events published.
