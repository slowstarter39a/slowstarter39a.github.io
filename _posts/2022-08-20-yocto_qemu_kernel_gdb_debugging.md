---
layout: single
title: \[Yocto\] QEMU kernel debugging with GDB
date : 2022-08-20 01:23:45 +0900
last_modified_at: 2022-08-21 23:07:07 +0900
categories: [gdb]
tags: [yocto qemu kernel gdb debugging]
comments: true
public : true
use_math : true
---

This is a post about aarch64 kernel debugging using qemu and gdb in yocto environment

# kernel configuration to debug kernel with gdb
 To include debugging information in the __vmlinux__ binary image,set __CONFIG_DEBUG_INFO__ to __y__. Usually it is __not set__ as default.
```
CONFIG_DEBUG_INFO=y
```

# kernel compilation option in the yocto environment
In __~~~temp/log.do_compile__ file, there is a compilation log as below. This information is used when specifying the path to the source code in gdb.

```bash
-fdebug-prefix-map=/mnt/sdb1/src/git/yocto/poky/build/tmp/work-shared/qemuarm64/kernel-source=/usr/src/kernel 
```
Look at the description about the __debug-prefix-map__ option [here](https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html)

  * This option is added by the code below.  
     In conf/bitbake.conf
      ```c
      KERNEL_SRC_PATH = "/usr/src/kernel"
      ```
      
     In conf/bitbake.conf
      ```c
      STAGING_KERNEL_DIR = "${TMPDIR}/work-shared/${MACHINE}/kernel-source"
      ```
      
     In classes/kernel-arch.bbclass
     ```
     KERNEL_CC = "${CCACHE}${HOST_PREFIX}gcc ${HOST_CC_KERNEL_ARCH} -fuse-ld=bfd ${DEBUG_PREFIX_MAP} -fdebug-prefix-map=${STAGING_KERNEL_DIR}=${KERNEL_SRC_PATH}"
     ```

# Run qemu
After building, run the command below in the build directory.  
__-s__ means __-gdb tcp::1234__. __-S__ means __Do not start CPU at startup(you must type 'c' in the monitor)__
```bash
runqemu qemuarm64 qemuparams="-s -S"
```

# Run gdb for aarch64
  1. Run gdb 
      ```
       $ ./aarch64-poky-linux-gdb
       ...
       ...
       For help, type "help".
       Type "apropos word" to search for commands related to "word".
       (gdb) 
      ```
  2.  Load symbol from vmlinux
      ```
      (gdb) add-symbol-file ~/src//git/yocto/poky/build/tmp/work/qemuarm64-poky-linux/linux-yocto/5.15.14+gitAUTOINC+72e4eafb6b_f77b2ba7d5-r0/linux-qemuarm64-standard-build/vmlinux
      ```
  3. Connect to a target machine
      ```
      (gdb) target remote:1234
      ```
  4. Set source path. Specify the path according to the __debug-prefix-map__ setting specified during compilation. Specify the path as an __absolute path__.
      ```
      (gdb) set substitute-path /usr/src/kernel /home/chuljeon39a/src/git/yocto/poky/build/tmp/work/qemuarm64-poky-linux/linux-yocto/5.15.14+gitAUTOINC+72e4eafb6b_f77b2ba7d5-r0/linux-qemuarm64-standard-build/source/
      ```
  5. Run layout subcommands 
      ```
      (gdb) layout asm
      (gdb) layout src
      (gdb) layout split
      ```
  6. set breakpoint at __start_kernel__
      ```
      (gdb) b start_kernel
      ```
  7. Continue program being debugged
      ```
      (gdb) c
      ```

      ![yocto_qemu_gdb_kernel_debug_1](/assets/images/yocto_qemu_gdb_kernel_debug_1.png){:width="100%"}

# Debugging using eclipse cdt
If you use eclipse cdt, you can debug more conveniently in the GUI environment.
  1. Execute eclipse
  2. In menu, __Run__ -> __Debug Configurations...__
  3. Choose __GDB QEMU Debugging__ and click the __right mouse button__. Then choose __New Configuration__.
  4. On __Main__ tab, set __Name__ and __C/C++ Application:__ to the path of vmlinux.
      ![eclipse_cdt_yocto_qemu_kernel_debugging_1](/assets/images/eclipse_cdt_yocto_qemu_kernel_debugging_1.png){:width="100%"}
  4. On __Debugger__ tab, set __GDB Client Setup__ to the path of GDB and set __Remote Target__ to localhost 1234.
      ![eclipse_cdt_yocto_qemu_kernel_debugging_2](/assets/images/eclipse_cdt_yocto_qemu_kernel_debugging_2.png){:width="100%"}
  5. On __Startup__ tab, set __Load Symbols and Executable__ to the path of vmlinux.  
     Set __Set breakpoint at:__ to __start_kernel__.
      ![eclipse_cdt_yocto_qemu_kernel_debugging_3](/assets/images/eclipse_cdt_yocto_qemu_kernel_debugging_3.png){:width="100%"}
  6. On __Source__ tab, set __Path Mapping__ to the paths that were set as debug-prefix-map during compilation.
      ![eclipse_cdt_yocto_qemu_kernel_debugging_4](/assets/images/eclipse_cdt_yocto_qemu_kernel_debugging_4.png){:width="100%"}
  7. Click __Apply__ and __Debug__
      ![eclipse_cdt_yocto_qemu_kernel_debugging_5](/assets/images/eclipse_cdt_yocto_qemu_kernel_debugging_5.png){:width="100%"}
  8. Click __resume(F8)__ button or press __'c'__ at __Debugger Console__ window. Then it stops at __start_kernel__
      ![eclipse_cdt_yocto_qemu_kernel_debugging_6](/assets/images/eclipse_cdt_yocto_qemu_kernel_debugging_6.png){:width="100%"}


## * To debug repeatedly,
  1. Run qemu
  2. Relaunch Debug  
     Do debugging
  3. Terminate gdb and qemu
  4. repeat 1 ~ 3
      ![eclipse_cdt_yocto_qemu_kernel_debugging_7](/assets/images/eclipse_cdt_yocto_qemu_kernel_debugging_7.png){:width="100%"}
