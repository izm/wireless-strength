set xdata time
set timefmt "%Y.%m.%d-%H:%M:%S"

set format x "%a %I%p"
set format y "%g %%"

set xlabel "Time"
set ylabel "Link Quality"

set grid
set xtics nomirror rotate by -45

plot [][0:100] "wireless_strength.data" using 1:($2*100) title "Wireless Strength" with lines

set terminal png size 1024, 400
set output "wireless_strength.png"
replot

set terminal x11
set output 

