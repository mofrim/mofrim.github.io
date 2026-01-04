+++
title = "IDidIt No.1: Audible"
date = 2026-01-04
draft = false
template = "blog/page.html"
[taxonomies]
  tags = ["foss", "did"]
[extra]
  toc = false
  display_published = true
  author = "mofrim"
+++

I didit! 

... aber ich schäme mich ein bisschen, dass ich diesen Schritt erst jetzt gegangen bin: ich habe erst heute mein Audible & Amazon-Konto gelöscht 🫣

Allem Scham zum Trotz schreibe ich jetzt hier davon, auf dass sich evtl. andere trauen den gleichen Schritt Richtung digitale Unabhängigkeit zu gehen. Lange, viel zu lange, hielt mich der folgende Gedanke ab: Wenn ich mein Konto lösche sind ja auch all die Hörbücher weg, die ja eigentlich mir gehören!

Nun ja, wo ein Wille, da ein Skript! So here we go:

1) Loggt euch auf der Audible-Webseite ein
2) Ladet alle Hörbücher, die ihr noch behalten wollt (im AAX-Format) herunter
3) Installiert euch [audible-cli](https://github.com/mkb79/audible-cli) und [aaxtomp3](https://github.com/KrumpetPirate/AAXtoMP3)
4) Konfiguriert `audible-cli` für euren Account ([https://github.com/mkb79/audible-cli?tab=readme-ov-file#-quickstart](https://github.com/mkb79/audible-cli?tab=readme-ov-file#-quickstart))
5) Lasst in dem selben Ordner in dem auch alle aax-Dateien sind dieses Skript durchlaufen:

   ```sh
    #!/usr/bin/env bash

    # quit on any error
    set -e

    files=$(ls *.aax 2> /dev/null)
    token=$(audible activation-bytes)
    echo -e "\e[33m----{got token: $token}-----\e[0m\n"
    for i in $files
    do
      echo -e "\e[33m----{converting file: $i}-----\e[0m"
      aaxtomp3 --authcode $token $i
      echo -e "\e[33m----{converting file: $i done}-----\e[0m\n\n"
    done

   ```
  Am Ende habt ihr alle eure EIGENEN Hörbücher schön, sauber in einer Ordner-Struktur, als MP3 portabel auf allen Geräten abspielbar, für alle Ewigkeiten gesichert und müsst der Amazon-Heuschrecke nicht mehr Geld in den Rachen werfen. 


