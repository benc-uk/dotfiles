#!/bin/bash

declare -i time=60
declare -i delay=5
declare -i count=5
declare -i okCount=0
declare -i elapsed=0

# Display usage
usage(){
echo -e "\e[38;5;80m╔══════════════════════════════════════════════════════════════╗"
echo -e "║   🌍 \e[97murl-check.sh \e[38;5;104mCheck URL endpoint for HTTP responses 🚀\e[38;5;80m   ║"
echo -e "╚══════════════════════════════════════════════════════════════╝"
echo -e "\n\e[31mParameters:\e[37m"
echo -e "     -u, --url       \e[33mURL to check (required)\e[37m"
echo -e "     [-t, --time]    \e[33mMaximum number of seconds to poll for \e[38;5;250m(default: 60)\e[37m"
echo -e "     [-d, --delay]   \e[33mDelay in seconds between requests \e[38;5;250m(default: 5)\e[37m"
echo -e "     [-c, --count]   \e[33mHow many successes to receive before exiting \e[38;5;250m(default: 5)\e[37m"
echo -e "     [-h, --help]    \e[33mShow this help text\e[37m"
}

OPTS=`getopt -o u:t:d:c:h --long url:,time:,delay:,count:,help -n 'parse-options' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; usage; exit 1 ; fi
eval set -- "$OPTS"

while true; do
  case "$1" in
    -u | --url ) url="$2"; shift; shift;;
    -t | --time ) time="$2"; shift; shift;;
    -d | --delay ) delay="$2"; shift; shift;;
    -c | --count ) count="$2"; shift; shift;;
    -h | --help ) HELP=true; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [[ ${HELP} = true ]] || [ -z ${url} ];  then
  usage
  exit 0
fi

if (( $delay * $count > $time)); then
  echo -e "\e[31m### Error! The time ($time) provided is too short given the delay ($delay) and count ($count)\e[0m"
  exit 1
fi

echo -e "\n\e[38;5;39m### Polling '$url' $max times, delaying $delay secs, for $count OK results"
if [ ! -z $string ]; then 
  echo -e "### Will check for '$string' in the body of the results"
fi
echo -e "\e[0m"

while true
do
  if (( $elapsed >= $time )) ; then
    break
  fi
  timestamp=$(date "+%Y/%m/%d %H:%M:%S")
  urlstatus=$(curl -o /dev/null --silent --write-out '%{http_code}' "$url")

  if [ $urlstatus -eq 000 ]; then 
    echo -e "### $timestamp: \e[38;5;134mSite not found or other error\e[0m"
  else
    echo -e "### $timestamp: \e[38;5;134m$urlstatus\e[0m"

    if (( $urlstatus >= 200 )) && (( $urlstatus < 300 )) ; then
      ((okCount=okCount + 1))
      if (( $okCount >= $count )); then
        break
      fi
    fi
  fi
  sleep $delay
  ((elapsed=elapsed + delay))
done

if [ $okCount -ge $count ]; then
  echo -e "\n\e[38;5;40m### Result: $url is UP! 🤩\e[30m"
  exit 0
else
  echo -e "\n\e[38;5;202m### Result: $url is DOWN! 😢\e[30m"
  exit 1
fi
