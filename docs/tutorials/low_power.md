#Low Power Optimizations

One of the major advantages of bluz is its low power Bluetooth LE radio. This allows bluz to run with much lower power consumption than
a WiFi board, but to get the best possible battery life bluz will require a little tweaking of the parameters.

There are several major pieces that determine how much current bluz will draw, they are:

- The RGB LED
- The BLE radio
- The CPU

This tutorial will explain how to maximize battery life from bluz through careful settings of parameters and code optimization.

##RGD LED
This one is pretty straight forward: the longer the RGB LED stays on the more power it draws. In normal operation, the RGB LED blinks
100mSec every 1 second, so it will consume a fair amount of power pretty quickly. Simply turning it off will save you a good deal of battery
capacity:

```
void setup() {
    RGB.control(true);
    RGB.color(0, 0, 0);
}
```

##CPU
There are two major ways to reduce the time the CPU is active, through Sleep Mode and Peripherals control

###Sleep Mode
The CPU of bluz is an ARM Cortx-M0 processor that runs at 16MHz. The CPU is capable of very low power sleep modes that allow it to
lower power consumption when it isn't required. To enter this mode, you use the command:

```
System.sleep(SLEEP_MODE_CPU);
```

This will put the CPU into a mode where it is essentially turned off and waiting for interrupts to wake it up. These interrupts can come from
two places: the BLE radio and the system firmware. For example, the system firmware has a software timer that wakes up the CPU every 100mSec
to check for Particle cloud data, set the RGB LED, and verify system state.

The best way to keep the CPU in sleep mode is call this command as often as possible and try not to block entry to it. Commands like delay()
will not allow the CPU to enter sleep mode, and instead make the CPU "sit and spin", chewing up clock cycles and burning through battery life.

Optimized code will instead check time flags to perform tasks on specified intervals, or use Software Timers. For example, this code will consume
a lot of power while it is running:

```
loop() {
    //BAD! delaying 5 seconds like this means the CPU isn't in sleep mode!!
    delay(5000);
    Particle.publish("Send Event");
    System.sleep(SLEEP_MODE_CPU);
}

```

However, this code will maximize the time the CPU is asleep and perform the same task:

```
int timeLastPublish = 0;
int timeBetweenPublishes = 5000;

loop() {
    //if it is time to send the event, send it!
    if (millis() - timeLastPublish > timeBetweenPublishes) {
        Particle.publish("Send Event");
        timeLastPublish = millis();
    }
    //otherwise, we sleep a lot, which is great!
    System.sleep(SLEEP_MODE_CPU);
}

```

Alternatively, you can use Software Timers to do the same thing:

```
//set a timer
bool publish = false;
Timer timer(5000, processTimer);

loop() {
    //when the timer triggers, send the event
    if (publish) {
        Particle.publish("Send Event");
        publish = false;
    }
    //otherwise, we sleep a lot, which is great!
    System.sleep(SLEEP_MODE_CPU);
}

void processTimer() {
    publish = true;
}

```

###Peripherals
Some peripherals require the CPU to be powered on. Turning them on, without deactivating them, will now allow the CPU to enter Sleep Mode even
if you call the sleep command. These peripherals are:

- UART
- PWM (analogWrite)
- Servo

If these peripherals are started, and not explicitly stopped, the CPU will not sleep.

For example, this code will force the CPU to always be on:

```
void setup() {
    //Starting Serial, but we never stop!
    Serial1.begin(9600);
    Serial1.println("Starting!");
}

void loop() {
    // Oh No! The CPU won't enter sleep mode since the Serial Peripheral is running!
    System.sleep(SLEEP_MODE_CPU);
}

```

Instead, make sure to not use the Peripheral, or turn it off explicitly if you really need it. For example, this is much better:

```
void setup() {
    //Starting Serial
    Serial1.begin(9600);
    Serial1.println("Starting!");

    //Turning it off when done!
    Serial.end();
}

void loop() {
    // Yay! The CPU will now sleep
    System.sleep(SLEEP_MODE_CPU);
}

```

##BLE Radio

There are several factors that can reduce the power consumption of the BLE Radio.

###Transmit Power
The Bluetooth LE Radio on bluz will transmit at a fixed and specified power. Reducing the transmit power that bluz uses will increase battery life,
but also decrease the range it can work over. Therefore, it is important to "tune" bluz to your use case. To do this, you can alter
the transmit power of bluz with the following command: [setTxPower()](../reference/ble.md#settxpower)

As RF propogation is fully dependent on surroundings, it is important to test out and try various transmit powers for your use case to tune it
properly. You want to make sure your device will have enough range, but keeping the transmit power too high will simply decrease battery life.

If your use case requires the gateway and bluz boards to be in the same room, or even adjacent rooms, it could be beneficial to turn down
the transmit power. You can use the bluz apps for iOS and Android to measure the RSSI from the device in you environment.

###Connection Interval
One of the largest effects on the battery is how often the BLE Radio transmits, this is defined by the connection interval.

![large](/img/connection_interval.png)

The Bluetooth LE central and peripheral need to sync themselves from time to time to share data. The connection interval is the time between these
  events, and it is crucial in battery performance. The radios must wake up each connection interval.

No data can be shared between the central and peripheral until a connection interval, so it has a high impact on throughput and latency. Keeping
the value low is beneficial if those are major considerations. If, however, throughput and latency are not major priorities, it is better to
keep the connection interval high, thereby reducing the amount of time the radio is transmitting and increasing battery life.

It is important to understand how connection parameters are set. When a central (gateway) connects to a peripheral (bluz DK), the connection
interval is negotiated. First, bluz DK will suggest times to the gateway. The gateway will then specify the exact connection interval, either inside
this suggested boundary or not. So the gateway is the device that sets it, not bluz DK.

Every central can set this differently. For example, iPhones don't allow the programmer control over this value, it is buried in the stack. On the Nordic
SDK, however, the value can be specified. So the bluz gateways can be told which values to chose.

To specify the suggested settings on bluz DK, you can use the [setConnectionParameters](../reference/ble.md#setconnectionparametersminimum-maximum)
command. This will specify what bluz DK will suggest to the gateway when it connects.

Specifying the connection parameters on the bluz DK side are not enough if you are using a bluz gateway. Luckily, it is easy to set them on the
bluz Gateway as well, this is part of the code you flash to the Photon/Electron/P1 that is on-board. The function to do this is
[set_connection_parameters](../reference/bluz_gateway.md#set_connection_parameters).

In general, if you are using bluz gateways, you only need to set it on the gateway side. If, however, you are using a different gateway
(Raspberry Pi, iPhone/Android, Mac, etc.) then it is recommended to set the desired connection intervals on bluz DK.

##Conclusion
This tutorial covers a lot of material that you can use to increase battery life on bluz DK. Out of the box, a lot of these optimizations aren't
used to create a better user experience (it would be a little hard to tell what is happening for new users if the RGB LED was off!).

Once you are comfortable with bluz and the different states, it is good to play around with all these settings so you can get the highest possible
battery life from bluz. After all, that's why we made it!







