--
-- Adapted from
-- Tweener's easing functions (Penner's Easing Equations)
-- and http://code.google.com/p/tweener/ (jstweener javascript version)
--

-- For all easing functions:
-- t = elapsed time
-- b = begin
-- c = change == ending - beginning

local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local abs = math.abs
local asin = math.asin

local easing = {
	Linear = {},
	Quad = {},
	Cubic = {},
	Quart = {},
	Quint = {},
	Sine = {},
	Exponential = {},
	Circular = {},
	Elastic = {},
	Back = {},
	Bounce = {},
}

local linear = function(t, b, c)
	return c * t + b
end

easing.Linear.In = linear
easing.Linear.Out = linear
easing.Linear.InOut = linear
easing.Linear.OutIn = linear

easing.Quad.In = function(t, b, c)
	return c * pow(t, 2) + b
end

easing.Quad.Out = function(t, b, c)
	return -c * t * (t - 2) + b
end

easing.Quad.InOut = function(t, b, c)
	t = t * 2
	if t < 1 then
		return c / 2 * pow(t, 2) + b
	else
		return -c / 2 * ((t - 1) * (t - 3) - 1) + b
	end
end

easing.Quad.OutIn = function(t, b, c)
	if t < 1 / 2 then
		return easing.Quad.Out(t * 2, b, c / 2)
	else
		return easing.Quad.In((t * 2) - 1, b + c / 2, c / 2)
	end
end

easing.Cubic.In = function(t, b, c)
	return c * pow(t, 3) + b
end

easing.Cubic.Out = function(t, b, c)
	t = t - 1
	return c * (pow(t, 3) + 1) + b
end

easing.Cubic.InOut = function(t, b, c)
	t = t * 2
	if t < 1 then
		return c / 2 * t * t * t + b
	else
		t = t - 2
		return c / 2 * (t * t * t + 2) + b
	end
end

easing.Cubic.OutIn = function(t, b, c)
	if t < 1 / 2 then
		return easing.Cubic.Out(t * 2, b, c / 2)
	else
		return easing.Cubic.In((t * 2) - 1, b + c / 2, c / 2)
	end
end

easing.Quart.In = function(t, b, c)
	return c * pow(t, 4) + b
end

easing.Quart.Out = function(t, b, c)
	t = t - 1
	return -c * (pow(t, 4) - 1) + b
end

easing.Quart.InOut = function(t, b, c)
	t = t * 2
	if t < 1 then
		return c / 2 * pow(t, 4) + b
	else
		t = t - 2
		return -c / 2 * (pow(t, 4) - 2) + b
	end
end

easing.Quart.OutIn = function(t, b, c)
	if t < 1 / 2 then
		return easing.Quart.Out(t * 2, b, c / 2)
	else
		return easing.Quart.In((t * 2) - 1, b + c / 2, c / 2)
	end
end

easing.Quint.In = function(t, b, c)
	return c * pow(t, 5) + b
end

easing.Quint.Out = function(t, b, c)
	t = t - 1
	return c * (pow(t, 5) + 1) + b
end

easing.Quint.InOut = function(t, b, c)
	t = t * 2
	if t < 1 then
		return c / 2 * pow(t, 5) + b
	else
		t = t - 2
		return c / 2 * (pow(t, 5) + 2) + b
	end
end

easing.Quint.OutIn = function(t, b, c)
	if t < 1 / 2 then
		return easing.Quint.Out(t * 2, b, c / 2)
	else
		return easing.Quint.In((t * 2) - 1, b + c / 2, c / 2)
	end
end

easing.Sine.In = function(t, b, c)
	return -c * cos(t * (pi / 2)) + c + b
end

easing.Sine.Out = function(t, b, c)
	return c * sin(t * (pi / 2)) + b
end

easing.Sine.InOut = function(t, b, c)
	return -c / 2 * (cos(pi * t) - 1) + b
end

easing.Sine.OutIn = function(t, b, c)
	if t < 1 / 2 then
		return easing.Sine.Out(t * 2, b, c / 2)
	else
		return easing.Sine.In((t * 2) - 1, b + c / 2, c / 2)
	end
end

easing.Exponential.In = function(t, b, c)
	if t == 0 then
		return b
	else
		return c * pow(2, 10 * (t - 1)) + b - c * 0.001
	end
end

easing.Exponential.Out = function(t, b, c)
	if t == 1 then
		return b + c
	else
		return c * 1.001 * (-pow(2, -10 * t) + 1) + b
	end
end

easing.Exponential.InOut = function(t, b, c)
	if t == 0 then
		return b
	end
	if t == 1 then
		return b + c
	end
	t = t * 2
	if t < 1 then
		return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005
	else
		t = t - 1
		return c / 2 * 1.0005 * (-pow(2, -10 * t) + 2) + b
	end
end

easing.Exponential.OutIn = function(t, b, c)
	if t < 1 / 2 then
		return t.Exponential.Out(t * 2, b, c / 2)
	else
		return t.Exponential.In((t * 2) - 1, b + c / 2, c / 2)
	end
end

easing.Circular.In = function(t, b, c)
	return (-c * (sqrt(1 - pow(t, 2)) - 1) + b)
end

easing.Circular.Out = function(t, b, c)
	t = t - 1
	return (c * sqrt(1 - pow(t, 2)) + b)
end

easing.Circular.InOut = function(t, b, c)
	t = t * 2
	if t < 1 then
		return -c / 2 * (sqrt(1 - t * t) - 1) + b
	else
		t = t - 2
		return c / 2 * (sqrt(1 - t * t) + 1) + b
	end
end

easing.Circular.OutIn = function(t, b, c)
	if t < 1 / 2 then
		return easing.Circular.Out(t * 2, b, c / 2)
	else
		return easing.Circular.In((t * 2) - 1, b + c / 2, c / 2)
	end
end

easing.Elastic.In = function(t, b, c) --, a, p)
	if t == 0 then
		return b
	end

	if t == 1 then
		return b + c
	end

	local p = 1 * 0.3
	local s

	s = p / 4

	t = t - 1

	return -(c * pow(2, 10 * t) * sin((t * 1 - s) * (2 * pi) / p)) + b
end

easing.Elastic.Out = function(t, b, c) --, a, p)
	if t == 0 then
		return b
	end

	if t == 1 then
		return b + c
	end

	local p = 0.3
	local s
	s = p / 4

	return c * pow(2, -10 * t) * sin((t - s) * (2 * pi) / p) + c + b
end

easing.Elastic.InOut = function(t, b, c) --, a, p)
	if t == 0 then
		return b
	end

	t = t * 2

	if t == 2 then
		return b + c
	end

	local p = 0.45
	local a = 0
	local s

	if not a or a < abs(c) then
		a = c
		s = p / 4
	else
		s = p / (2 * pi) * asin(c / a)
	end

	if t < 1 then
		t = t - 1
		return -0.5 * (a * pow(2, 10 * t) * sin((t - s) * (2 * pi) / p)) + b
	else
		t = t - 1
		return a * pow(2, -10 * t) * sin((t - s) * (2 * pi) / p) * 0.5 + c + b
	end
end

easing.Elastic.OutIn = function(t, b, c) --, a, p)
	if t < 1 / 2 then
		return easing.Elastic.Out(t * 2, b, c / 2)
	else
		return easing.Elastic.In((t * 2) - 1, b + c / 2, c / 2)
	end
end

easing.Back.In = function(t, b, c) --, s)
	local s = 1.70158
	return c * t * t * ((s + 1) * t - s) + b
end

easing.Back.Out = function(t, b, c) --, s)
	local s = 1.70158
	t = t - 1
	return c * (t * t * ((s + 1) * t + s) + 1) + b
end

easing.Back.InOut = function(t, b, c) --, s)
	local s = 2.5949095
	t = t * 2
	if t < 1 then
		return c / 2 * (t * t * ((s + 1) * t - s)) + b
	else
		t = t - 2
		return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
	end
end

easing.Back.OutIn = function(t, b, c) --, s)
	if t < 1 / 2 then
		return easing.Back.Out(t * 2, b, c / 2)
	else
		return easing.Back.In((t * 2) - 1, b + c / 2, c / 2)
	end
end

easing.Bounce.Out = function(t, b, c)
	if t < 1 / 2.75 then
		return c * (7.5625 * t * t) + b
	elseif t < 2 / 2.75 then
		t = t - (1.5 / 2.75)
		return c * (7.5625 * t * t + 0.75) + b
	elseif t < 2.5 / 2.75 then
		t = t - (2.25 / 2.75)
		return c * (7.5625 * t * t + 0.9375) + b
	else
		t = t - (2.625 / 2.75)
		return c * (7.5625 * t * t + 0.984375) + b
	end
end

easing.Bounce.In = function(t, b, c)
	return c - easing.Bounce.Out(1 - t, 0, c) + b
end

easing.Bounce.InOut = function(t, b, c)
	if t < 1 / 2 then
		return easing.Bounce.In(t * 2, 0, c) * 0.5 + b
	else
		return easing.Bounce.Out(t * 2 - 1, 0, c) * 0.5 + c * 0.5 + b
	end
end

easing.Bounce.OutIn = function(t, b, c)
	if t < 1 / 2 then
		return easing.Bounce.Out(t * 2, b, c / 2)
	else
		return easing.Bounce.In((t * 2) - 1, b + c / 2, c / 2)
	end
end

return easing
