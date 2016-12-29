#Beacon

_Requires v2.2.50 or higher_

This library allows you to turn bluz into various beacon types that can be used to trigger apps and other devices when they come into proximity.

## beacon(uint32_t major, uint32_t minor, uint8_t *UUID)

Starts advertising as a beacon with a major, minor, and UUID. This will put bluz into a state that is similar to popular beacon protocols used by major smartphone manufacturers

The advertising packet will include the major, minor, and UUID specified, as well as the RSSI of the device from 1 meter. The RSSI will be adjusted based on the power set from BLE.setTxPower()


`major` is the major value to be advertised

`minor` is the minor value to be advertised

`UUID` is the UUID to be advertised, should be exactly 16 bytes long


```C++
    uint16_t major = 765;
    uint16_t minor = 4321;
    uint8_t UUID[16] = {0xb1, 0xe2, 0x40, 0x40, 0xb1, 0xe2, 0x40, 0x40, 0xb1, 0xe2, 0x40, 0x40, 0xb1, 0xe2, 0x40, 0x40};

    void setup() {
        BLE.beacon(major, minor, UUID);
    }
```

