## Software Timers

_Requires v2.0.50 or higher_

Software Timers provide a way to have timed actions in your program.  The Nordic SDK provides the ability to have up to 10 Software Timers at a time with a minimum resolution of 1 millisecond.  It is common to use millis() based "timers" though exact timing is not always possible (due to other program delays).  Software timers are more reliable method for running timed actions using callback functions.  Please note that Software Timers are "chained" and will be serviced sequencially when several timers trigger simultaneously, thus requiring special consideration when writing callback functions.

```cpp
// EXAMPLE

void print_every_second()
{
    static int count = 0;
    Serial1.println(count++);
}

Timer timer(1000, print_every_second);

void setup()
{
    Serial1.begin(9600);
    timer.start();
}
```

Timers may be started, stopped, reset within a user program or an ISR.  They may also be "disposed", removing them from the (max. 10) active timer list.

The timer callback is similar to an interrupt - it shouldn't block. However, it is less restrictive than an interrupt. If the code does block, the system will not crash - the only consequence is that other software timers that should have triggered will be delayed until the blocking timer callback function returns.

// SYNTAX

`Timer timer(period, callback, one_shot)`

- `period` is the period of the timer in milliseconds  (unsigned int)
- `callback` is the callback function which gets called when the timer expires.
- `one_shot` (optional, since 0.4.9) when `true`, the timer is fired once and then stopped automatically.  The default is `false` - a repeating timer.


### Class member callbacks

_Since 0.4.9_

A class member function can be used as a callback using this syntax to create the timer:

`Timer timer(period, callback, instance, one_shot)`

- `period` is the period of the timer in milliseconds  (unsigned int)
- `callback` is the class member function which gets called when the timer expires.
- `instance` the instance of the class to call the callback function on.
- `one_shot` (optional, since 0.4.9) when `true`, the timer is fired once and then stopped automatically.  The default is `false` - a repeating timer.


```
// Class member function callback example

class CallbackClass
{
public:
     void onTimeout();
}

CallbackClass callback;
Timer t(1000, &CallbackClass::onTimeout, callback);

```


### start()

Starts a stopped timer (a newly created timer is stopped). If `start()` is called for a running timer, it will be reset.

`start()`

```C++
// EXAMPLE USAGE
timer.start(); // starts timer if stopped or resets it if started.

```

### stop()

Stops a running timer.

`stop()`

```C++
// EXAMPLE USAGE
timer.stop(); // stops a running timer.

```

### changePeriod()

Changes the period of a previously created timer. It can be called to change the period of an running or stopped timer.

`changePeriod(newPeriod)`

`newPeriod` is the new timer period (unsigned int)

```C++
// EXAMPLE USAGE
timer.changePeriod(1000); // Reset period of timer to 1000ms.

```


### reset()

Resets a timer.  If a timer is running, it will reset to "zero".  If a timer is stopped, it will be started.

`reset()`

```C++
// EXAMPLE USAGE
timer.reset(); // reset timer if running, or start timer if stopped.

```

### startFromISR()
### stopFromISR()
### resetFromISR()
### changePeriodFromISR()

`startFromISR()`
`stopFromISR()`
`resetFromISR()`
`changePeriodFromISR()`

Start, stop and reset a timer or change a timer's period (as above) BUT from within an ISR.  These functions MUST be called when doing timer operations within an ISR.

```C++
// EXAMPLE USAGE
timer.startFromISR(); // WITHIN an ISR, starts timer if stopped or resets it if started.

timer.stopFromISR(); // WITHIN an ISR,stops a running timer.

timer.resetFromISR(); // WITHIN an ISR, reset timer if running, or start timer if stopped.

timer.changePeriodFromISR(newPeriod);  // WITHIN an ISR, change the timer period.
```

### dispose()

`dispose()`

Stop and remove a timer from the (max. 10) timer list, freeing a timer "slot" in the list.

```C++
// EXAMPLE USAGE
timer.dispose(); // stop and delete timer from timer list.

```

### isActive()

_Since 0.5.0_

`bool isActive()`

Returns `true` if the timer is in active state (pending), or `false` otherwise.

```C++
// EXAMPLE USAGE
if (timer.isActive()) {
    // ...
}
```
