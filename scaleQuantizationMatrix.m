function Qs = scaleQuantizationMatrix(Q, quality)
if ((quality < 1) || (quality > 100))
    error('quality must be between 1 and 100.');
end

if (quality <= 50)
    scaleFactor = 50/quality;
else
    scaleFactor = 2 - quality/50;
end

Qs = max(round(Q .* scaleFactor), 1);
end