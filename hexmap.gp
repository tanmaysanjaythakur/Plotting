reset
unset key

set term pdfcairo size 14.7,3
set output 'E31hexmap.pdf'

####Read data
#setting range is necessary for dummy plot
set xrange [4:8.95]
set yrange [1:1.9]
#set xtics 4,0.1,8.4
set size ratio -1


#half the distance between centers of 2 hexagons
d=0.0499

filename="fort.4444"
#backquotes do not block macro but double quotes do, hence manually writing filename
mini="`awk '{if($6<min){min=$6;line=$6}}END{print min}' fort.4444 `"
ratmin="`awk '{if($6<min){min=$6;rat=$4;dif=$3}}END{print rat}' fort.4444 `"
difmin="`awk '{if($6<min){min=$6;rat=$4;dif=$3}}END{print dif}' fort.4444 `"
tt="{/Symbol D}E (meV) for V0=125meV, size 25x25nm^2"
ttt= sprintf("%s, max {/Symbol D}E=%s (meV) at %s,%s", tt,mini,ratmin[1:4],difmin[1:4])

set title ttt 
set table "data.dat"
add_hex(x,y,c) = sprintf(\
    'call "set_hex.gnu" "%f" "%f" "%f" "%f";',x,y,c,d)
CMD = ''
#dummyplot to put hexagons
plot filename u 1:(CMD=CMD.add_hex($4,$3,$6))
eval(CMD)
unset table

set clip

set palette defined ( \
    -0.242  '#FF8989',\
     0.0    '#F1FFBD',\
     0.05   '#E0FBC6',\
     2.0    '#797979',\
     4.75   '#262626')

set cbtics("-0.24" -0.24, " 0.0" 0, "1.0" 1,"4.7" 4.7)

plot filename u 4:3:6 w p pt 7 ps 0.1 lc palette
