#!/bin/sh

# Read hostname
read -r host < /proc/sys/kernel/hostname

# Read uptime
IFS=. read -r s _ < /proc/uptime
d=$((s / 86400))
h=$((s / 3600 % 24))
m=$((s / 60 % 60))
s=$((s % 60))
uptime=""

# Construct uptime string
if [ "$d" -gt 0 ]; then
    uptime="$d day"
    [ "$d" -gt 1 ] && uptime="${uptime}s"
    uptime="${uptime}, $h hour"
    [ "$h" -gt 1 ] && uptime="${uptime}s"
elif [ "$h" -gt 0 ]; then
    uptime="$h hour"
    [ "$h" -gt 1 ] && uptime="${uptime}s"
    uptime="${uptime}, $m minute"
    [ "$m" -gt 1 ] && uptime="${uptime}s"
elif [ "$m" -gt 0 ]; then
    uptime="$m minute"
    [ "$m" -gt 1 ] && uptime="${uptime}s"
    uptime="${uptime}, $s second"
    [ "$s" -gt 1 ] && uptime="${uptime}s"
else
    uptime="$s second"
    [ "$s" -gt 1 ] && uptime="${uptime}s"
fi

## DEFINE COLORS

bold='[1m'
red='[31m'
yellow='[33m'
blue='[34m'
grey='[90m'
reset='[0m'

user="${reset}${bold}${yellow}"   # user
arch="${bold}${blue}"
time="${reset}${grey}"

## OUTPUT

cat <<EOF
 ${arch}  /\   ${time}${uptime}${reset}
 ${arch} /  \  ${user}${USER}${red}@${reset}${arch}${host}${reset}
EOF
