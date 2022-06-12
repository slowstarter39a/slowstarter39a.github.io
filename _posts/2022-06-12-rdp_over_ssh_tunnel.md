---
layout: single
title: RDP over ssh tunnel
date : 2022-06-12 01:23:45 +0900
last_modified_at: 2022-06-12 15:47:50 +0900
categories: [rdp]
tags: [rdp ssh]
comments: true
public : true
use_math : true
---

# RDP over ssh tunnel using reminna
## After ssh connection in terminal, connect to localhost:59002 in reminna
  * run command in terminal
   ```bash
   ssh -L 59002:localhost:3389 -N -f -l <account_id> <server ip address>
   ```
  * connect to "localhost:59002" in reminna
![remmina_rdp_on_ssh_tunnel-server_setting_1](/assets/images/remmina_rdp_on_ssh_tunnel_server_setting_1.png){:width="80%"}
   

## Or Setting up an ssh tunnel only in reminna
  * Basic setting  
![remmina_rdp_on_ssh_tunnel-server_setting_2](/assets/images/remmina_rdp_on_ssh_tunnel_server_setting_2.png){:width="80%"}
  * SSH Tunnel setting   
![remmina_rdp_on_ssh_tunnel-server_setting_3](/assets/images/remmina_rdp_on_ssh_tunnel_server_setting_3.png){:width="80%"}
  * Set the authentication type according to the server configuration
      ## test
