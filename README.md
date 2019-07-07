**THIS PROJECT IS NOT FINISHED**

## Build instructions

All this projects was tested on [Blue pill]](http://wiki.stm32duino.com/index.php?title=Blue_Pill) device and st-link v2

- Download stm32 cube software by the link https://www.st.com/en/embedded-software/stm32cube-mcu-mpu-packages.html and unpack it in src/stm32cubef1 folder (can be used any other folder - but is needed to change src/build.sh script)

- Prepare Docker image
In folder docker run the command:
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

- gdb configuration:
  ```
  target remote 172.17.0.2:3333
  monitor reset halt
  break main
  ```
  IP address is address for debugger server

## Gpio terminal commands syntax

```bash
gpio info
gpio A|B|C|D port [1-16] mode on|off
gpio A|B|C|D port [1-16] mode pwm freq [0-1000] [0-100]%
```
