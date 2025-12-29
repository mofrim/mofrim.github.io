+++
title = "Painfully migrating to a new matrix account"
date = 2025-12-28
draft = false
template = "blog/page.html"
[taxonomies]
  tags = ["foss"]
[extra]
  toc = false
  display_published = true
  author = "mofrim"
+++
Ouff!

After the 2 cloudflare-outages this year, which led to me not being able to
access any of my matrix-chats (as i my account was @matrix.org) i was happy to
having found a new matrix-homeserver @fsfe.org since i became a supporter this
year. But...

***How painful can it be to migrate to a new account?!***

I mean, the data is all there. But as i am trying to be a dev myself i fully
understand that certain feature are just not top-priority for the
matrix-element-team. So, here is what i did following
[this](https://finnes.dev/blog/2024/10-06-migrate-your-existing-matrix-account-the-harder-but-safe-way/)
lovely tutorial by someone who went through the same painful experience before
me.

1) Create new account `@blabla:newhome.org` (old account: `@blabla:oldhome.org`).
2) In direct message rooms, or rooms where you are allowed to enter `/`-commands
   at the msg-prompt enter `/invite @blabla:oldhome.org Account Migration`
   logged in in your old account. This simply makes inviting you new self
   faster, imho. If you are not allowed to execute commands you have to click an
   invitation or copy the room link and open it in another Matrix instance where
   you logged in with your new account.
3) After accepting the invitation from your new account, in direct msg / or
   rooms where your old account is admin run `/op @blabla:fsfe.org 100`
4) Make your old account leave the rooms where the new account now has
   successfully joined by running `/part` or clicking on **Leave Room**.
5) Sadly, the DM (DirectMessages) chats will now be group chats, as there temporarily have been
   more than 2 participants. In order to fix that run `/devtools` copy the
   internal room link, go to `Explore account data -> m.direct`. There you might find
   json that looks like this:

   ```json
    {
      "@blabla:newhome.org": [],
      "@blabla:oldhome.org": [
        "!BzgPnypAbKBhxTLlFI:matrix.org"
      ]
    }
   ```
   According to the [Matrix
   Spec](https://spec.matrix.org/v1.4/client-server-api/#mdirect) the `m.direct`
   spec is a map storing information about which rooms are considered DM-rooms.
   So all we need to do here is add the room ID of the DM-chat to the list of
   DM-rooms belonging to the newhome-account. Say,
   `!TzgPyzpAbKbhxTplfI:matrix.org` is the current DM-chat-roomlink then the
   result after editing should look like this (also did cleanup the oldhome
   stuff):

   ```json
    {
      "@blabla:newhome.org": [
        "!TzgPyzpAbKbhxTplfI:matrix.org",
        "!BzgPnypAbKBhxTLlFI:matrix.org"
      ]
    }
   ```
   This is about it. `TODO:` I would really love to write a script for that. Or some
   other tool making this simpler. Maybe some day 🐧


