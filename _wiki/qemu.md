---
layout: single
title: qemu 사용 방법
date : 2020-01-15 01:33:04 +0900
last_modified_at: 2020-02-03 00:44:34 +0900
categories: [qemu]
tags: [qemu]
comments: true 
public : true
parent : vim
permalink : /wiki/qemu/
--- 


--- 
# reference
  * [https://wiki.qemu.org/Main_Page](https://wiki.qemu.org/Main_Page) 
  * [https://www.qemu.org](https://www.qemu.org)
  * [https://qemu.weilnetz.de/doc/qemu-doc.html#Commands](https://qemu.weilnetz.de/doc/qemu-doc.html#Commands)
<br />
<br />

# qemu 
QEMU 는 어떤 특정 machine 또는 cpu에 대한 emulator 기능을 제공하는 가상화
소프트웨어이다. 예를 들면, arm core용 부트로더나 커널 또는 그 외의 프로그램 동작을 확인해 보려면 arm core가 내장된 Hw보드에 직접 바이너리를 Load하여 확인해보거나, 또는 qemu를 이용하여 실제 HW 보드가 없이도 어느정도 동작 확인이 가능하다. 가상 환경이므로, 실제 HW 입출력등의 동작을 확인하는 것에는 제약이 따른다. 
 크게 qemu-system-\<target machine\>와 qemu-\<target machine> 형태의 프로그램이 있는데, 여기서는 실제
 사용해본 qemu-system-arm과 qemu-arm에 대해서 소개하겠다.
## qemu-system-arm
 qemu-system-arm은 arm machine용 emulator이다. arm toolchain으로 bootloader나
 linux kernel을 빌드 후, qemu-system-arm으로 동작 시켜 볼 수 있다. qemu에서
 지원되는 보드와 cpu list는 아래 커맨드로 확인해 볼 수 있다.
  * qemu 에서 지원하는 board list

    ```bash 
    $ qemu-system-arm --machine help
    Supported machines are:
    akita                Sharp SL-C1000 (Akita) PDA (PXA270)
    ast2500-evb          Aspeed AST2500 EVB (ARM1176)
    borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270)
    canon-a1100          Canon PowerShot A1100 IS
    cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
    collie               Sharp SL-5500 (Collie) PDA (SA-1110)
    connex               Gumstix Connex (PXA255)
    cubieboard           cubietech cubieboard
    highbank             Calxeda Highbank (ECX-1000)
    imx25-pdk            ARM i.MX25 PDK board (ARM926)
    integratorcp         ARM Integrator/CP (ARM926EJ-S)
    kzm                  ARM KZM Emulation Baseboard (ARM1136)
    lm3s6965evb          Stellaris LM3S6965EVB
    lm3s811evb           Stellaris LM3S811EVB
    mainstone            Mainstone II (PXA27x)
    midway               Calxeda Midway (ECX-2000)
    musicpal             Marvell 88w8618 / MusicPal (ARM926EJ-S)
    n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
    n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)
    netduino2            Netduino 2 Machine
    none                 empty machine
    nuri                 Samsung NURI board (Exynos4210)
    palmetto-bmc         OpenPOWER Palmetto BMC (ARM926EJ-S)
    raspi2               Raspberry Pi 2
    realview-eb          ARM RealView Emulation Baseboard (ARM926EJ-S)
    realview-eb-mpcore   ARM RealView Emulation Baseboard (ARM11MPCore)
    realview-pb-a8       ARM RealView Platform Baseboard for Cortex-A8
    realview-pbx-a9      ARM RealView Platform Baseboard Explore for Cortex-A9
    romulus-bmc          OpenPOWER Romulus BMC (ARM1176)
    sabrelite            Freescale i.MX6 Quad SABRE Lite Board (Cortex A9)
    smdkc210             Samsung SMDKC210 board (Exynos4210)
    spitz                Sharp SL-C3000 (Spitz) PDA (PXA270)
    sx1                  Siemens SX1 (OMAP310) V2
    sx1-v1               Siemens SX1 (OMAP310) V1
    terrier              Sharp SL-C3200 (Terrier) PDA (PXA270)
    tosa                 Sharp SL-6000 (Tosa) PDA (PXA255)
    verdex               Gumstix Verdex (PXA270)
    versatileab          ARM Versatile/AB (ARM926EJ-S)
    versatilepb          ARM Versatile/PB (ARM926EJ-S)
    vexpress-a15         ARM Versatile Express for Cortex-A15
    vexpress-a9          ARM Versatile Express for Cortex-A9
    virt-2.6             QEMU 2.6 ARM Virtual Machine
    virt-2.7             QEMU 2.7 ARM Virtual Machine
    virt-2.8             QEMU 2.8 ARM Virtual Machine
    virt                 QEMU 2.9 ARM Virtual Machine (alias of virt-2.9)
    virt-2.9             QEMU 2.9 ARM Virtual Machine
    xilinx-zynq-a9       Xilinx Zynq Platform Baseboard for Cortex-A9
    z2                   Zipit Z2 (PXA27x)
    $
    ```

  * qemu에서 지원하는 cpu list
    ```bash
    $ qemu-system-arm --machine none --cpu help
    Available CPUs:
      arm1026
      arm1136
      arm1136-r2
      arm1176
      arm11mpcore
      arm926
      arm946
      cortex-a15
      cortex-a7
      cortex-a8
      cortex-a9
      cortex-m3
      cortex-m4
      cortex-r5
      pxa250
      pxa255
      pxa260
      pxa261
      pxa262
      pxa270-a0
      pxa270-a1
      pxa270
      pxa270-b0
      pxa270-b1
      pxa270-c0
      pxa270-c5
      sa1100
      sa1110
      ti925t
    $
    ```
  * qemu에서 지원하는 보드를 사용하면, qemu가 board에 대한 정보(uart, memory등)를 가지고 있어서, 좀 더 실제 보드에 가깝게 동작확인이 가능하다.
  * 만약 확인하려는 보드가 qemu에서 지원되는 보드가 아니라면, 유사한 machine을 선택한다(vexpress-a9/a15, virt 등). 다만 이 경우에는 빌드한 바이너리와 machine type이 맞지 않으므로, peripheral(uart등)의 동작은 확인 할 수 없다. 
    ex) if vexpress-a9, if ram size is 1GB, and elf is u-boot,
    ```bash
    $ qemu-system-arm --machine vexpress-a9 -m 1G -kernel u-boot
    ```
  * new machine을 qemu supported board list에 추가하는 방법은 추후에 업데이트 할 예정이다. 
  * 일반적으로 사용하는 커맨드라인 파라미터는 아래와 같다 
    ```bash
    qemu-system-arm -M versatilepb -nographic -kernel u-boot -s -S  -m 1G
    ```
    * -M : machine
    * -m : ram size 지정
    * -nographic : no graphie mode 지정
    * -kernel : elf file 지정
    * -s : -gdb tcp::1234 for gdb debugging 
    * -S : do not start as startup(use 'c' to start execution). startup code에서 멈춰 있음. gdb에서 c를 해주어야 시작함.
  * --cpu \<cpu\>를 사용하면 지정한 cpu대로 동작이 되는 듯 하다. 당연히 바이너리도 빌드 할때 cpu 설정을  맞추어서 빌드 하여야 한다. 
  * 이 외에 다른 커맨드라인 파라미터들에 대해서는 아래 링크를 참조한다.
    * [https://qemu.weilnetz.de/doc/qemu-doc.html#Commands](https://qemu.weilnetz.de/doc/qemu-doc.html#Commands)


## qemu-arm
 qemu-arm 은 user space용 emulator이다. 호스트 PC에서 arm toolchain으로 hello world!  프로그램을 작성하고 직접 실행해 볼 수 잇다. 
  * ex) hello_world.c

     ```c
    #include <stdio.h>
    int main(void)
    {
    	printf("Hello World!\n");
    	return 0;
    }
    ```

  * 컴파일할때는 몇가지 옵션이 있다.
    * -g : produce debugging information. build된 바이너리에 디버깅 정보가 포함되도록 한다. gdb로 디버깅을 할 경우 컴파일 할 때 -g 를 사용하여야 한다. 
    * -static : shared library에 대한 다이나믹 링킹을 허용하지 않고, 필요한 공유 라이브러리의 내용들을 build된 바이너리에  포함되도록 한다. -static 옵션을 사용하지 않으면, arm-linux-gnueabi-gdb로 remote 디버깅 시, 공유 라이브러리등을 잘 찾지 못해서 디버깅이 잘 되지 않는다. 정확한 원인은 좀 더 연구를 해봐야 한다. -static을 사용할 경우, 바이너리의 크기가 커지는 단점이 있지만 테스트 용도로 사용한다면 -static 옵션을 사용하는것이 간편하다. 

  * -g -static 옵션을 추가하여 빌드 하고 qemu-arm 으로 실행한 결과이다. 
    ```bash
    $ arm-linux-gnueabi-gcc -o hello_world hello_world.c -g -static
    $ file hello_world
    hello_world: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, BuildID[sha1]=a6aa73e1651aa51c0006d004c817cb2acd45d9d0, not stripped, with debug_info
    $ qemu-arm ./hello_world
    Hello World!
    $
    ```

  * -static 옵션은 사용하지 않고, -g 옵션만 추가하여 빌드 하고 qemu-arm 으로 실행한 결과이다. -static 옵션을 사용하지 않으면, qemu-arm을 실행할때, -L 옵션으로 "elf interpreter prefix" 경로를 지정해 주어야 한다. 그렇지 않으면, "/lib/ld-linux-armhf.so.3" 관련 에러가 발생한다.

    ```bash
    $ arm-linux-gnueabihf-gcc -o hello_world hello_world.c -g
    $ file hello_world
    hello_world: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 2.6.32, BuildID[sha1]=06569dfce299146d05c79b0f1a4e31c49cd01ec9, not stripped, with debug_info
    $ qemu-arm hello_world
    /lib/ld-linux-armhf.so.3: No such file or directory
    $ qemu-arm -L /home/jchsonez/bin/cross_toolchain/2017_05_arm_linux_gnueabihf/arm-linux-gnueabihf/libc/ ./hello_world
    Hello World!
    $ 
    ```

  * -g -static 옵션을 추가하여 빌드하고, gdb 디버깅을 하려면, qemu-arm 을 실행할 때 "-g 5039" 를 추가하여 실행한다. 
    ```bash
    qemu-arm -g 5039 ./hello_world
    ```

  * gdb를 실행하고 아래와 같이 gdb command를 실행한다.
    ```bash
    $ arm-linux-gnueabihf-gdb
    GNU gdb (Linaro_GDB-2017.05) 7.12.1.20170417-git
    Copyright (C) 2017 Free Software Foundation, Inc.
    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
    and "show warranty" for details.
    This GDB was configured as "--host=x86_64-unknown-linux-gnu --target=arm-linux-gnueabihf".
    Type "show configuration" for configuration details.
    For bug reporting instructions, please see:
    <http://www.gnu.org/software/gdb/bugs/>.
    Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.
    For help, type "help".
    Type "apropos word" to search for commands related to "word".
    /home/jchsonez/.gdbinit:1: Error in sourced command file:
    No symbol table is loaded.  Use the "file" command.


    (gdb) file hello_world
    Reading symbols from hello_world...done.


    (gdb) target remote:5039
    Remote debugging using :5039
    _start () at ../sysdeps/arm/start.S:79
    79	../sysdeps/arm/start.S: No such file or directory.


    (gdb) b main
    Breakpoint 1 at 0x104a0: file hello_world.c, line 22.


    (gdb) c
    Continuing.
    
    Breakpoint 1, main () at hello_world.c:22
    22		printf("Hello World!\n");
    (gdb) 
    ```
  * 위의 예제에서 한가지 문제가 있는데, Breakpoint 1에서 break 된 후 더 이상 ni 또는 si 명령이 제대로 수행되지 않고, 에러가 발생한다. 원인은 잘 모르고, 임시 해결책으로는 "del 1"로 breakpoint 1을 제거하고, ni 나 si 명령을 실행하면 제대로 동작한다. 

