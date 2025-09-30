+++
title = "The Hyprland switch-focus-or-create-ws-script"
date = 2025-09-29
draft = false
template = "blog/page.html"
[taxonomies]
  tags = ["code", "cfg"]
[extra]
  toc = false
  display_published = true
  author = "mofrim"
+++

Already some time ago i hacked together this script for
windows/workspace-switching in my current *hyprland* setup. I have bound this to
the `$mainMod + h/l` . Why? I have one quite small laptop with a 12" display and
when working on it i felt like i wanted to have almost every window being as
large as possible. So i ended up putting every new window on a seperate workspace (a
bit like scrolling window-managers like *niri* would do). With this script, in
situations where there is no more window to the right on my current ws, a new ws
is created. If there are still windows to the right of the currently focused
windows the focus is switched as usual. This makes switching to new workspaces
much easier.

Maybe someone else can find this useful. Of course i searched for something
similar, but i couldn't find anything. So, here it is:


```sh
#!/usr/bin/env bash

# This is my switch-focus-or-create-ws-script. If there is no more window left
# or right of the current one will switch to the next workspace. So far, at
# least, when moving to the right, this leads to creation of new workspaces.

out="$(hyprctl dispatch movefocus $1)"
winno_on_cur_ws="$(hyprctl workspaces -j | \
	jq '.[] | select(.id == '$(hyprctl activeworkspace -j | jq '.id')')' | \
	jq '.windows')"

# `hyprctl dispatch movefocus r` prints "Nothing to focus to in direction r"
# when rightmost window is already reached. But we only want to switch to next
# ws if we have reached that rightmost win => `grep Nothing` must be empty. When
# reaching any fullscreened ws while cycling this leads to being "trapped"
# there, as trying to switch will only loop through all windows on that ws. This
# is desired behavior in my case.

if [ -z "$(echo $out | grep "Nothing")" ] && [ $winno_on_cur_ws -ne 0 ]; then
	exit
elif [ "$1" == "l" ]; then
	hyprctl dispatch workspace -1
elif [ "$1" == "r" ]; then
	hyprctl dispatch workspace +1
fi

```

copy the script to `~/.config/hypr/scripts/switch_win_ws.sh` & add the following
binding to your `hyprland.conf`:

```conf
bind = $mainMod, h, exec, ~/.config/hypr/scripts/switch_win_ws.sh l
bind = $mainMod, l, exec, ~/.config/hypr/scripts/switch_win_ws.sh r
```
