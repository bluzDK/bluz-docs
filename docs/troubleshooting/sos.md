#SOS Codes

SOS codes will show on the RGB LED of bluz if there is an error. The code will give you an indication of the problem at hand.

An SOS code will always display as red on the RGB and will follow this pattern

- 3 quick flashes ('S')
- 3 slow flashes ('O')
- 3 quick flashes ('S')
- A number of flashes which represents the error code

This will repeat twice, then bluz will reboot. The error code flashed corresponds to the following errors:

Code    | Description
---     | ---
4       | Out of memory exception. Either the system is out of memory or a system service has attempted to exceed its limit
7       | Invalid parameter was passed to a system service
8       | System tried to enter an invalid state
9       | Invalid length or a parameter passed to the system