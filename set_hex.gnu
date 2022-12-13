#set_hex sets a hexagon as an gnuplot object
#   Usage: call 'set_hex.gp' 'x' 'y' 'c'
#   Input parameters:
#       x, y        - hexagon position
#	c 	    - color

# Checking if we have enough input parameters
if (ARGC!=4) print 'set_hex needs 4 input parameters'; exit

# Getting the input parameters
x = ARG1
y = ARG2
c = ARG3
d = ARG4
# Initialize an object number
if (!exists("object_number")) object_number = 1;

# setting the hexagon
dd=d
a = dd*0.5773
b = a*2.0*1.23   #1.23 is correction and to elongate hexagon to fill spaces
		 # ideal regular hexagon should have b=2a
		 # one can modify this multiplication factor according to their needs
		 # to fill or empty the space between the hexagons
		 
set object object_number polygon from \
     x-d, y-a to \
     x+0, y-b to \
     x+d, y-a to \
     x+d, y+a to \
     x+0, y+b to \
     x-d, y+a to \
     x-d, y-a

# Set the color etc.
colr=hsv2rgb(0.2+c,0.3-c,1.0-c/3.0)
set object object_number fc rgb colr fillstyle solid transparent solid 0.85 noborder front

# Count the object number
object_number = object_number+1
