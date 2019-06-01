**THIS PROJECT IS NOT FINISHED**


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
  * programm project to device and start debugger server
  ```bash
  ./build.sh -p blinky -f -d
  ```
- Open gdb in correct env:
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
