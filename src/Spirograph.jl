module Spirograph

using Plots

function lastly()
    plot!(aspectratio = 1, legend = false, axis = false, grid = false, ticks = false)
end

@inline inner_angle(a::Int, b::Int, t::Real)::Float64 = b * t / a

@inline function spot(a::Int, b::Int, offset::Real, t::Real)::Complex{Float64}
    θ = inner_angle(a, b, t)
    return im * ((a + b) * exp(θ * im) + offset * exp(t * im))
end

@inline stop_t(a::Int, b::Int) = 2 * π * (lcm(a, b) ÷ abs(b))

function spiro_points(a::Int, b::Int, offset::Real, step::Real)
    if a <= 0 || b == 0
        error(
            "Radius of fixed circle must be positive and radius of the rolling disk must be nonzero",
        )
    end
    T = stop_t(a, b) + step
    return [spot(a, b, offset, t) for t = 0:step:T]
end

_DEFAULT_STEP = 0.05

"""
    spirograph(a,b,offset;args...)
Draw a spirograph picture where
+ `a` is the radius of the fixed wheel,
+ `b` is the radius of the moving wheel, and
+ `offset` is the distance from the center of the moving wheel to the pen.

The optional `args` are passed to `plot`. 

## Example
`spirograph(20,-9,12,linecolor=:green)`
"""
function spirograph(a::Int, b::Int, offset::Real, step::Real = _DEFAULT_STEP; args...)
    pts = spiro_points(a, b, offset, step)
    plot(real(pts), imag(pts); args...)
    lastly()
end

"""
    spirograph!
Same as `spirograph` but does not clear the drawing screen first. This way spirograph
images can be combined.
"""
function spirograph!(a::Int, b::Int, offset::Real, step::Real = _DEFAULT_STEP; args...)
    pts = spiro_points(a, b, offset, step)
    plot!(real(pts), imag(pts); args...)
    lastly()
end

export spirograph, spirograph!
end # module
