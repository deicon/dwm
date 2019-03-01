#!/bin/bash
compton --config ~/.config/compton/compton.conf &
# 0: +*HDMI-2 3440/798x1440/335+0+0  HDMI-2
# 1: +HDMI-1-0 1920/510x1080/290+3440+0  HDMI-1-0
sleep 5
# activate second window
xrandr --output HDMI-1-0 --auto --right-of HDMI-2 &
# setting the last background images
nitrogen --restore&

gnome-terminal&

dte() {
   dte="$(date +"%A, %B %d - %H:%M")"
   echo -e "⌚$dte"
}

mem() {
   mem=$(free | awk '/Speicher/ {printf "%d Mib/%d Mib\n", $3 / 1024, $2 / 1024 }')
   echo -e "∥∥$mem"
}

pkg() {
   pkginst="$(apt list --installed | wc -l)"
   countgupd="$(apt list --upgradable | wc -l)"
   pkgupd=$((countgupd - 1))
   echo -e "Pkgs: ✔ $pkginst | ↺ $pkgupd "
}

cpu(){
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "💻 $cpu% cpu"
}


while (true); do
   xsetroot -name "$(cpu) | $(pkg) | $(mem) | $(date)"
   sleep 10s
done
