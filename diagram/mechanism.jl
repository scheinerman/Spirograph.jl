using SimpleDrawing, Plots

"""
    mechanism(a,b,offset)

Draw a picture of the spirograph mechanism. Draw with `spirograph` first, then follow
with `mechanism` usint the same parameters.
"""
function mechanism(a::Int, b::Int, offset::Real)
    draw_circle(0, 0, a, linecolor = :black)
    draw_point(0, 0, color = :black, marker = 2)

    x = a + b
    draw_circle(x, 0, abs(b), linecolor = :black)
    draw_point(x, 0, color = :black, marker = 2)

    draw_segment(x, 0, x + offset, 0, linecolor = :black)
    draw_point(x + offset, 0, color = :red, linecolor = :red, marker = 3, linewidth = 0)

    finish()
end
