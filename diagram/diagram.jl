using SimpleDrawing, Plots, Clines
#resize_gr_window()

C = Circle(0,0,15)
D = Circle(23,0,8)

newdraw()
draw(C,linewidth=2); draw(D,linewidth=2); 

x = 15*cos(pi/6)
y = 15*sin(pi/6)

draw_vector(x,y,linecolor=:black)
annotate!(x/2,y/2+1,"a")


x = 8*cos(pi/6)
y = 8*sin(pi/6)
draw_vector(x,y,23,0,color=:black)

annotate!(x+19,y/2+0.7,"b")

#draw_point(23+offset,0,marker=4,color=:red,linecolor=:white)

offset = 6
draw(Circle(23+offset+.2,0,.2),fill=true,linecolor=:red,color=:red)


draw_vector(offset,0,23,0,linecolor=:red)
annotate!(26,-0.5,"offset",annotationfontsize=10)

draw_point(0,0,color=:black,marker=4)
draw_point(23,0,color=:black,marker=4)


finish()