module Spirograph

using SimpleDrawing, Plots


@inline inner_angle(a::Int, b::Int, t::Real)::Float64 = b * t / a

@inline function spot(a::Int, b::Int, offset::Real, t::Real)::Complex{Float64}
    θ = inner_angle(a, b, t)
    return a * exp(θ * im) + (offset) * exp(t * im)
end

@inline stop_t(a::Int, b::Int) = 2 * π * lcm(a, b)

function spiro_points(a::Int, b::Int, offset::Real, step::Real)
    T = stop_t(a, b)
    return [spot(a, b, offset, t) for t = 0:step:T]
end

"""
    spirograph(a,b,offset;args...)
Draw a spirograph picture where
+ `a` is the radius of the fixed wheel
+ `b` is the radius of the moving wheel
+ `offset` is the distance from the center of the inner wheel to the pen

The optional `args` are passed to `plot`. 

## Example
`spirograph(20,-9,12,linecolor=:green)`
"""
function spirograph(a::Int, b::Int, offset::Real, step::Real = 0.01; args...)
    pts = spiro_points(a, b, offset, step)
    newdraw()
    plot(real(pts), imag(pts); args...)
    finish()
end

"""
    spirograph!
Same as `spirograph` but does not clear the drawing screen first. This way spirograph
images can be combined.
"""
function spirograph!(a::Int, b::Int, offset::Real, step::Real = 0.01; args...)
    pts = spiro_points(a, b, offset, step)
    plot!(real(pts), imag(pts); args...)
    finish()
end

export spirograph, spirograph!
end # module
