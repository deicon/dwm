p10() {
    # check if P10 Headphones are connected
    connected="$((bt-device --info P10))"
    if [ connected = 1 ]; then
       echo -e "P10"
    else
       echo -e ""
    fi
}

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
  echo -e "💻 $cpu% cpu"
}

xsetroot -name "$(cpu) | $(mem) | $(pkg) | $(dte)"
