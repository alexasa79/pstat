#!/bin/bash

print_stats() {
	stat=$(cat $1)
	IFS=' ' read -ra ar <<< "$stat"

	echo Information for thread $(basename $(dirname $1))

	echo "    PID:                                     ${ar[0]}"
	echo "    comm:                                    ${ar[1]}"
	echo "    state:                                   ${ar[2]}"
	echo "    Parent PID:                              ${ar[3]}"
	echo "    Parent GID:                              ${ar[4]}"
	echo "    Session ID:                              ${ar[5]}"
	echo "    TTY:                                     ${ar[6]}"
	echo "    Process group PID:                       ${ar[7]}"
	printf "    Flags:                                   %#x\n" ${ar[8]}
	echo "    Minor faults without disk access:        ${ar[9]}"
	echo "    Minor faults with delay:                 ${ar[10]}"
	echo "    Major faults without disk access:        ${ar[11]}"
	echo "    Major faults with delay:                 ${ar[12]}"
	echo "    User mode time (jiffies):                ${ar[13]}"
	echo "    System time (jiffies):                   ${ar[14]}"
	echo "    Children wait time (jiffies):            ${ar[15]}"
	echo "    System children wait time (jiffies):     ${ar[16]}"
	echo "    Priority:                                ${ar[17]}"
	echo "    Nice level:                              ${ar[18]}"
	echo "    Number of threads:                       ${ar[19]}"
	echo "    Time to next SIGALARM (jiffies):         ${ar[20]}"
	echo "    Start time (jiffies):                    ${ar[21]}"
	echo "    Virtual memory size (bytes):             ${ar[22]}"
	echo "    RSS size (bytes):                        ${ar[23]}"
	echo "    Soft limit on RSS size (bytes):          ${ar[24]}"
	printf "    Start code:                              %#x\n" ${ar[25]}
	printf "    End code:                                %#x\n" ${ar[26]}
	printf "    Start stack:                             %#x\n" ${ar[27]}
	printf "    ESP value:                               %#x\n" ${ar[28]}
	printf "    EIP value:                               %#x\n" ${ar[29]}
	printf "    Pending signals:                         %#x\n" ${ar[30]}
	printf "    Blocked signals:                         %#x\n" ${ar[31]}
	printf "    Ignored signals:                         %#x\n" ${ar[32]}
	printf "    Caught signals:                          %#x\n" ${ar[33]}
	echo "    Channel:                                 ${ar[34]}"
	echo "    Number of swapped pages:                 ${ar[35]}"
	echo "    Cumulative swapped pages with children:  ${ar[36]}"
	echo "    Exit signal:                             ${ar[37]}"
	echo "    Current processor:                       ${ar[38]}"
	echo "    RT priority:                             ${ar[39]}"
	echo "    Scheduling policy:                       ${ar[40]}"

	echo ""
}

if [ "$#" -ne "1" ]; then
	echo "Usage: pstat <PID>"
	exit 0
fi

for thread in /proc/$1/task/*; do
	print_stats $thread/stat
done

