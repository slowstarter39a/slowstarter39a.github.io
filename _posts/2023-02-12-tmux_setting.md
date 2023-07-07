---
layout: single
title: tmux setting
date : 2023-02-12 01:23:45 +0900
last_modified_at: 2023-07-08 07:52:44 +0900
categories: [tmux]
tags: [tmux]
comments: true
public : true
use_math : true
---

tmux는 하나의 터미널 창에서 여러개의 터미널을 생성하여 사용할 수 있게 해주는 툴이다. tmux는 많은 옵션을 가지고 있는데, 그중 기본적인 사용방법을 아래에 정리하였다.

# session
tmux를 실행하면 세션이 생성되며, 세션은 tmux가 실행하는 가장 큰 실행단위이다.

## session 생성 방법
session을 생성하면 기본적으로 윈도우가 하나 생성된다.
```
tmux
tmux new [-s <session name>]
tmux new [-s <session name>] [-n <window name>]
tmux new-session [-s <session name>] [-n <window name>]

```
## session attach/detach 방법
생성된 session을 터미널창에서 detach 하고, 다른 터미널창에 attach 할 수 있다. 
```
tmux detach [-s target-session]
tmux attach [-t target-session]
ctrl + b, d //detach the current client
ctrl + b, D //Choose a client to detach
```

## session list 보기
```
tmux ls
```
<br/>
# window
세션은 여러개의 윈도우로 구성될 수 있으며, 주로 사용되는 단축키는 아래와 같다..
```
ctrl+b, c     //윈도우 생성
ctrl+d        //윈도우 종료
ctrl+b, w     //윈도우 리스트에서 윈도우 선택
ctrl+b, n     //다음 윈도우
ctrl+b, p     //이전 윈도우
ctrl+b, l     //마지막 윈도우
ctrl+b, 0-9   //윈도우를 번호로 선택
ctrl+b,f      //윈도우를 이름으로 선택
ctrl_b,: move-window [-s src-window] [-t  dst-window]  //다른 세션으로 옮기기 -t dst-session:dst-window 으로 지정 가능
ctrl+b,: swap-window [-s src-window] [-t dst-window]   // 세션 swap
ctrl+b,: clear-history  // history clear
```

## window base-index 변경 방법
default 는 0이며, 1로 변경하려면 아래처럼 설정하면 된다.
```
set base-index 1
```

## window number 정렬하는 방법
아래 커맨드를 실행할 경우, 세션 내의 모든 윈도우가 순서대로 정렬된다.
```
move-window -r
```
<br/>
## pane
하나의 윈도우는 여러개의 pane으로 구성될 수 있다.
```
ctrl+b,”       //pane을 가로로 분할
ctrl+b,%       //pane을 세로로 분할
ctrl+b,q       //pane 번호를 보여주어  숫자로 이동할 수 있다
ctrl+b, o      //다음 pane 선택
ctrl+b, <방향키>  //다음 키로 pane 선택
ctrl+d          //pane 종료
ctrl+b,: command  //커맨드 입력
```

# 기타
set -g mouse on을 한 상태에서 마우스 스크롤을 하면 copy mode 동작이 된다. 
copy mode는 ctrl+b [를 눌러 진입할 수 있다.
이 상태에서 system clipboard를 이용하여 복사하기/붙여넣기를 하려면 shift 키를 누르고 마우스로 영역을 선택하여 복사하기/붙여넣기를 한다.  
```
ctrl+b,[        //copy mode, 마우스 스크롤 후, shift 키를 눌러 영역 선택/복사
[ESC],q         //copy mode에서 빠져나오기
```

system clipboard를 사용하지 않고, tmux buffer를 이용하여 복사하기/붙여넣기를 할 수 있다.
```
ctrl+b,[        //copy mode, 마우스 스크롤 또는 copy-mode-vi키 모드를 설정한 경우 vi command로 영역 설정을 할 수 있다.
[ESC],q         //copy mode에서 빠져나오기
ctrl+b,]        //copy mode, tmux buffer의 내용을 붙여넣기 한다.
```
tmux buffer는 system clipboard와는 별개의 것이어서, tmux buffer를 tmux 외부에서 실행된 어플리케이션에 붙여넣기 하려면 system clipboard로 옮겨주도록 설정을 하여야 하며, xclip를 이용하여 해당 기능을 설정할 수 있다.(아래 설정 파일 참고)


<br/>
## 기본 설정 파일
~/.tmux.conf
```
set -g default-terminal "tmux-256color"        
set -g mouse on
set -g base-index 1
set-option -g mode-keys vi
setw -g pane-base-index 1
set -g history-limit 999999                                            #scroll limit 설정
set-window-option -g window-status-current-style fg=white,bg=red       #현재 윈도우 컬러
set-window-option -ga window-status-activity-style fg=blue,bg=white    #활성 윈도우 컬러
set -g monitor-activity on                                             #활성 윈도우 모니터
bind-key -n MouseDrag1Status swap-window -d -t=                        #status bar 마우스 드래그로 윈도우 이동

#윈도우를 생성하면서 경로를 현재 경로로 지정
bind c new-window -c "#{pane_current_path}"                    #윈도우를 생성하면서 경로를 현재 경로로 지정
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
bind-key y set-window-option synchronize-panes

bind-key -T copy-mode-vi v send-keys -X begin-selection                # 복사할 영역 지정
bind-key -T copy-mode-vi y send-keys -X copy-pipe "xclip -i -sel clip" # tmux buffer에 복사 후, system clipboard로 복사

#:new-window -a                  #현재 윈도우의 다음 인덱스로 새로운 윈도우를 생성.
#move-window -a -t 3             #현재 윈도우를 인덱스 3의 다음인덱스(4)로 이동. -a는 after의 의미
#move-window -b -t 3             #현재 윈도우를 인덱스 3의 이전인덱스(2)로 이동. -b는 before의 의미

```

## 기본 설정 파일 load
```
tmux source-file ~/.tmux.conf
```
