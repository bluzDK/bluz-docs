#CR2032 Battery Shield

![hero](/img/battery_shield.jpg)

The battery shield holds a CR2032 battery and can power a bluz DK through the 3V3 pin.

##Power Switch

A single switch placed behind the battery can power the board on/off.

##LED

The battery shield has an LED indicating that it is turned on. This LED can be turned off using the on-board jumper switch. Power will still be on,
but the LED will be off, preserving battery life.

##Headers
The battery shield is equipped with female, stackable headers. This means the shield can be plugged into a breadboard easily, or into other shields.

##Note on CR2032 Batteries
While CR2032 batteries are conventient, cheap, and small, they also have some drawbacks that should be noted.

A typical CR2032 runs at 3V and has about 200-240 mAh of capacity. However, this can be negatively affected and the battery life reduced if the battery is
subjected to adverse conditions. Notably, high current draw can significantly reduce the life of a CR2032 battery.

Typically, a battery is rated at it's highest capacity at a nominal current draw, which depending on the manufacturer, is usually around 0.25 mA. Pulsing the battery quickly
with higher current can affect this overall capacity. Even worse, sustained current drawn over a long period of time can quickly wear down a CR2032.

Ths is all subject to the manufacturer and conditions, but it is wise to keep sustained current to a minimum and pulse as infrequently as possible. Doing so will maximize
your battery life, whereas violating these guidelines can results in significantly reduced battery performance.

If you need a continusouly high current draw, you may want to look into other battery options to power your bluz DK.
