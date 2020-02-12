## Project desription

This project contains build environment for stm32 devices, build scripts on scons, and programs for blue pill board:
- blinky - it is blinking by board led. It is example from stm32Cube with changes for new build system and board
- termgpio - board configured as USB CDC device with simple shell, that allows to configure board qpio in output mode in low and hi lewel, and also in pwm mode

## Build instructions

All this projects was tested on [Blue pill]](http://wiki.stm32duino.com/index.php?title=Blue_Pill) device and st-link v2

- Download stm32 cube software by the link https://www.st.com/en/embedded-software/stm32cube-mcu-mpu-packages.html and unpack it in src/stm32cubef1 folder (can be used any other folder - but is needed to change src/build.sh script)

- Prepare Docker image
In folder `docker` run the command:
```bash
docker build -t stm_operate .  
```
- In src directory call to
  * build project:
  ```bash
  ./build.sh -p blinky
  ```
  * clean project
  ```bash
  ./build.sh -p blinky -c
  ```
  * programming project to device and start debug server
  ```bash
  ./build.sh -p blinky -f -d
  ```
- Open gdb in correct environment:
  ```bash
  ./build.sh -p blinky -g
  ```
  this command opens two servers
  * telnet on 4444 port
  * gdb on 3333 port

- gdb example configuration. Correct ip address you can find in shell, where debugger is working:
  ```
  target remote 172.17.0.2:3333
  monitor reset halt
  break main
  ```
  IP address is address for debugger server

## Gpio terminal commands syntax

Full commands list:
```
        help|?
        gpio info
        pwm info
        gpio A|B|C|D port [0-15] mode on|off
        gpio A|B|C|D port [0-15] mode pwm [0-100]%
        pwm tim [1-3] freq <int>

```

- `help|?` - prints list of all commands
- `gpio info` - prints information about all gpio port configuration
- `pwm info` - prints info about timers freq and connected to this TIM ports
- `gpio A|B|C|D port [0-15] mode on|off` - set gpio X.x to hi or low state
- `gpio A|B|C|D port [0-15] mode pwm [0-100]%` - switch port to pwm mode and set duty in persents
  frequency is configuring for timer
- `pwm tim [1-3] freq <int>` - set freq in Hz for appropriate timer. Good values from 1 to 1000 Hz. Other frequency can make strage results

## Notes

For unlocking flash in first time:
- start debugger 
  ```
  ./build.sh -p termgpio -d 
  ```
- Connect to OCD via telnet
  ```
  telnet 172.17.0.2  4444
  ```
- Run commands in debugger
  ```
  reset init
  stm32f1x unlock 0
  ```
