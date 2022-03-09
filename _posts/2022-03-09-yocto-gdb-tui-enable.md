---
layout: single
title: \[Yocto\] Enabling GDB TUI mode
date : 2022-03-09 01:23:45 +0900
last_modified_at: 2022-03-09 22:24:34 +0900
categories: [gdb]
tags: [yocto gdb]
comments: true
public : true
use_math : true
---


# reference
[https://docs.yoctoproject.org/](https://docs.yoctoproject.org/)
<br/>
<br/>

# Enabling GDB TUI mode on yocto project

The gdb related bb files are located in the ~/meta/recipes-devtools/gdb folder.<br/>
 ex)
 - gdb_11.b.bb is for gdb on target device
 - gdb-cross_11.1.bb is for gdb on host(for remote debugging)

The following is in gdb-common.inc file.

```
...
PACKAGECONFIG[tui] = "--enable-tui,--disable-tui"
...
```

So, in your layer, add append file(s) to your layer as shown below.
```bash
recipes-devtools/
└── gdb
    ├── gdb-%.bbappend       // for gdb-cross-architecture
    └── gdb_%.bbappend       // for gdb on target device
```
    
Add the code below to each append file to add "--enable-tui" option.

```
PACKAGECONFIG:append = " tui "
```

For "gdb-cross-architecture", refer to the link below to build and use.
[debugging with gdb on yocto project](https://docs.yoctoproject.org/singleindex.html#debugging-with-the-gnu-project-debugger-gdb-remotely)
