using SimpleDrawing, Plots, ProgressMeter

"""
    mechanism(a,b,offset,t)

Draw a picture of the spirograph mechanism. Draw with `spirograph` first, then follow
with `mechanism` using the same parameters.
"""
function mechanism(a::Int, b::Int, offset::Real, t::Real = 0)
    draw_circle(0, 0, a, linecolor = :black)
    θ = Spirograph.inner_angle(a, b, t)
    x = a + b
    z = (a + b) * exp(im * θ) * im
    draw_circle(z, abs(b), linecolor = :black)
    pen = Spirograph.spot(a, b, offset, t)
    draw_segment(z,pen,color=:black)
    draw_point(pen, color = :red, linecolor = :red, marker = 3, linewidth = 0)
    finish()
end


function spiro_movie(a, b, offset, step = Spirograph._DEFAULT_STEP)
    zvals = Spirograph.spiro_points(a, b, offset, step)
    T = Spirograph.stop_t(a, b)
    tvals = collect(0:step:T)
    npts = length(zvals)
    x = real(zvals)
    y = imag(zvals)

    bound = 0 
    if b>0
        bound = a+b+max(abs(offset), b)
    else
        bound = a + max(abs(offset)-abs(b), 0)
    end 

    PM = Progress(npts)

    movie = @animate for j = 1:npts
        newdraw()
        draw_rectangle(-bound, -bound, bound, bound, linecolor = :white)
        xx = x[1:j]
        yy = y[1:j]
        plot!(xx, yy, linecolor = :blue)
        mechanism(a, b, offset, tvals[j])
        next!(PM)
        finish()
    end
    return movie

end