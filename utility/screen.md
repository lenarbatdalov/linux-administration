# screen
```
sudo apt install screen

При создании новой сессии screen можно задать ей имя
screen -S name-of-screen

Посмотреть список запущенных сессий можно командой
screen -ls

Чтобы перейти в нужную сессию, следует указать параметру -r её id или название
screen -r 23505
```

# shortcut
```
Ctrl+a c        Create a new window (with shell).
Ctrl+a "        List all windows.
Ctrl+a 0        Switch to window 0 (by number).
Ctrl+a A        Rename the current window.
Ctrl+a S        Split current region horizontally into two regions.
Ctrl+a |        Split current region vertically into two regions.
Ctrl+a tab      Switch the input focus to the next region.
Ctrl+a Ctrl+a   Toggle between the current and previous windows
Ctrl+a Q        Close all regions but the current one.
Ctrl+a X        Close the current region.

Ctrl+a d        отключиться от сеанса
```

# настройки
~/.screenrc
```zsh
# Turn off the welcome message
startup_message off

# Disable visual bell
vbell off

# Set scrollback buffer to 10000
defscrollback 10000

# Customize the status line
hardstatus alwayslastline
hardstatus string '%{= kG}[ %{G}%H %{g}][%= %{= kw}%?%-Lw%?%{r}(%{W}%n*%f%t%?(%u)%?%{r})%{w}%?%+Lw%?%?%= %{g}][%{B} %m-%d %{W}%c %{g}]'
```

### screen keyboard shortcuts
./screen.png

# Bind F11 and F12 (NOT F1 and F2) to previous and next screen window
bindkey -k F1 prev
bindkey -k F2 next

# Also for ctrl-alt right and left arrows
# Note disable in window manager to allow through
bindkey ^[[1;7D prev
bindkey ^[[1;7C next

startup_message off

# Window list at the bottom.
hardstatus alwayslastline
hardstatus string "%-w%{= BW}%50>%n %t%{-}%+w%<"

# From Stephen Shirley
# Don't block command output if the terminal stops responding
# (like if the ssh connection times out for example).
nonblock on

# Allow editors etc. to restore display on exit
# rather than leaving existing text in place
altscreen on

# Enable 256-color mode when screen is started with TERM=xterm-256color
# Taken from: http://frexx.de/xterm-256-notes/
#
# Note that TERM != "xterm-256color" within a screen window. Rather it is
# "screen" or "screen-bce"
#
# terminfo and termcap for nice 256 color terminal
# allow bold colors - necessary for some reason
attrcolor b ".I"
# tell screen how to set colors. AB = background, AF=foreground
#termcapinfo xterm-256color 'Co#256:AB=\E[48;5;%dm:AF=\E[38;5;%dm'

# save more scrollback
defscrollback 30000

