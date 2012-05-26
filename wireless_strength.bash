#!/bin/bash

# Originally written by Steven Brown
# http://www.stevenbrown.ca


# CUSTOMIZE START ####################################################

SLEEPTIME=2 # Seconds between each poll
INTERFACE="wlan0"
DATETIME=`date +"%Y.%m.%d-%H:%M:%S"` # Date/Time output format

# CUSTOMIZE END ######################################################


echo "# Wireless Strength at $SLEEPTIME second intervals."
echo "# "`date +"%c"`

while true 
do
	s=`nm-tool | grep -e '^\s*\*'`
	# Now, s=something like:
	#    *networkid:     Infra, 00:13:46:1E:82:22, Freq 2437 MHz, Rate 54 Mb/s, Strength 100 WEP

	# Strip everything up to the number away, then get the number using awk
	s=${s/*[sS]trength /}
	s=`echo $s | awk '{print $1}'`

	# Get output to be a decimal, or zero
	output=`echo "scale=2;$s/100" | bc -l`

	echo -e $DATETIME"\t"$output
	sleep $SLEEPTIME

done

# GNUPLOT NOTES
#
# INPUT (timefmt)
 # +-------------+--------------------------------------------------------------+
 # |  Format     |                Explanation                                   |
 # +-------------+--------------------------------------------------------------+
 # |    %f       |   floating point notation                                    |
 # |    %e or %E |   exponential notation; an "e" or "E" before the power       |
 # |    %g or %G |   the shorter of %e (or %E) and %f                           |
 # |    %x or %X |   hex                                                        |
 # |    %o or %O |   octal                                                      |
 # |    %t       |   mantissa to base 10                                        |
 # |    %l       |   mantissa to base of current logscale                       |
 # |    %s       |   mantissa to base of current logscale; scientific power     |
 # |    %T       |   power to base 10                                           |
 # |    %L       |   power to base of current logscale                          |
 # |    %S       |   scientific power                                           |
 # |    %c       |   character replacement for scientific power                 |
 # |    %P       |   multiple of pi                                             |
 # +-------------+--------------------------------------------------------------+

# OUTPUT (format)
 # +-------------+--------------------------------------------------------------+
 # |  Format     |                Explanation                                   |
 # +-------------+--------------------------------------------------------------+
 # |    %a       |   abbreviated name of day of the week                        |
 # |    %A       |   full name of day of the week                               |
 # |    %b or %h |   abbreviated name of the month                              |
 # |    %B       |   full name of the month                                     |
 # |    %D       |   shorthand for "%m/%d/%y"                                   |
 # |    %H or %k |   hour, 0--24                                                |
 # |    %I or %l |   hour, 0--12                                                |
 # |    %p       |   "am" or "pm"                                               |
 # |    %r       |   shorthand for "%I:%M:%S %p"                                |
 # |    %R       |   shorthand for %H:%M"                                       |
 # |    %T       |   shorthand for "%H:%M:%S"                                   |
 # |    %U       |   week of the year (week starts on Sunday)                   |
 # |    %w       |   day of the week, 0--6 (Sunday = 0)                         |
 # |    %W       |   week of the year (week starts on Monday)                   |
 # +-------------+--------------------------------------------------------------+

