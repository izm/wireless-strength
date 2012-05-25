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
	s=`iwconfig $INTERFACE | grep -i quality`
	# Now, s=something like: "  Link Quality=40/70 Signal level=-70 dBm"

	i=`expr index "$s" "="` # Index of "=", right after "Link Quality"
	s=${s:i} # Strip all that stuff away
	l=`expr index "$s" " "` # End of number substring
	s=${s:0:l-1} # Strip all the end stuff away

	# Get output to be a decimal, or zero
	output=`echo "scale=2;$s" | bc -l`
	if [ `expr index $output "."` -eq 0 ]; then
		output=0
	fi

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

