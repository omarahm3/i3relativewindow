# i3relativewindow

# What?

This is a simple bash script which its only goal is to toggle a window and move it to a position relative to the focused workspace monitor. This is designed to work for dual monitors too, positions must be in percentage format since its going to be shown relatively

# Why?

- I wanted a quick access general purpose terminal everywhere and anywhere
- I wanted to toggle an i3 floating window relatively to the current focused monitor
- I was bored and needed a ton of sleep, so i `bash`ed (ehm..)
- I didn't want to use python or i3wm IPC
- Because why not?!

# Prerequisites

- [jq](https://stedolan.github.io/jq/download/)

# How?

```bash
mv i3relativewindow.sh ~/.local/bin/i3relativewindow # Or to your favorite bin location
chmod +x i3relativewindow
```

## Arguments

Arguments must be passed in this order

1. instance: Your window instance name
2. window X: Window X position in percentage 
3. window Y: Window Y position in percentage 
4. window width: Window configured width
4. window height: Window configured height

for example:

```bash
i3relativewindow quick-terminal 50 50 500 500
```

## Example

Check [example](./example) directory for an example i3wm config
