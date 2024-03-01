---
layout: single
title: RDP over ssh
date : 2022-06-12 01:23:45 +0900
last_modified_at: 2024-03-01 10:56:36 +0900
categories: [rdp]
tags: [rdp ssh]
comments: true
public : true
use_math : true
---

# RDP over ssh using reminna
## After ssh connection in terminal, connect to localhost:59002 in reminna
  * run command in terminal
   ```bash
   ssh -L 59002:localhost:3389 -N -f -l <account_id> <server ip address>
   ```
  * connect to "localhost:59002" in reminna
![remmina_rdp_on_ssh_tunnel-server_setting_1](/assets/images/remmina_rdp_on_ssh_tunnel_server_setting_1.png){:width="80%"}

  * the ssh command can be set in "Behavior" tab in remmina
![remmina_rdp_on_ssh_tunnel-server_setting_2](/assets/images/remmina_rdp_on_ssh_tunnel_server_setting_2.png){:width="80%"}
