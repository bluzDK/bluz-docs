#Bluz DK

![hero](/img/new_board.jpg)

Bluz DK is the main development board. It contains an ARM Cortex-M0 that runs at 16MHz, 32K Ram, 256K Flash, and a load of hardware peripherals (UART, SPI, I2C, etc.)

Bluz is also outfitted with 2Mb (256KB) external SPI flash. This is used to store backup firmware, system flags, and to download new over the air firmware images.

And, of course, it contains the Bluetooth LE radio and stack, giving bluz it's power-sipping wireless performance.

##Pinout
![Bluz DK](/img/bluz_pinout.png)

The above diagram shows the pinouts for bluz. Bluz is meant to have the same footprint as the Core/Photon, therefore it can be used with existing shields and accessories.
However, there are a few notable exceptions:

* A6 and A7 cannot read analog data even though they are still labeled A6 and A7 (which was done for compatible code). There simple weren't enough ADC pins on the nrf51.
* The pin between RST and GND is used here for SWD programming. On the Photon, this is VBAT while on the Core it is 3.3V*.
* PWM is not limited to specific pins, however it can only be enabled on 4 at a time.
* The RGB LED does not "breathe", it blinks. There simple aren't enough PWM capable pins (there would have only been one left for the user).
* While the defaults for SPI, UART, and I2C are the same as the Core/Photon, they can be reconfigured to any pins.
* Total current draw across all pins should not exceed 15mA.
* There is no USB connector, all programming must be done wirelessly, or alternatively through UART, and the device must be powered directly to the pins.


##Tech Specs
<p>Hardware</p>
<ul>
    <li>Nordic Semiconductor nRF51822 SoC</li>
    <li>ARM Cortex M0, 16MHz</li>
    <li>32KB RAM, 256KB FLASH</li>
    <li>Bluetooth LE 4.1</li>
    <li>10 bit ADC</li>
    <li>256KB External FLASH</li>
    <li>3.0V-6V (3.3V compatible)</li>
</ul>
<p>Power Consumption</p>
<ul>
    <li>Connected/Standby: 60uA</li>
    <li>Transmitting Max: 18mA</li>
</ul>
<p>Typical Range (subject to environment):</p>
<ul>
    <li>Indoors: 60-100 feet</li>
    <li>Outdoors: 150-200 feet</li>
</ul>
<p>Software</p>
<ul>
    <li>Spark Web IDE</li>
    <li>Wiring (same as Arduino)</li>
    <li>Native C/C++ Programming</li>
    <li>GCC ARM</li>
    <li>Assembly (if you're that bold)</li>
</ul>
<p>Cloud</p>
<ul>
    <li>Spark Connected</li>
    <li>IFTTT Integrated</li>
    <li>IPv6 Support</li>
    <li>Remote programmable through Spark Cloud</li>
    <li>Control via REST API</li>
</ul>


