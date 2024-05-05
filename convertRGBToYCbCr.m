function imgYCbCr = convertRGBToYCbCr(imgRGB)
[M, N, nColors] = size(imgRGB);
if nColors ~= 3
    warning('Image must be RGB');
end

if isinteger(imgRGB)
    imgRGB = double(imgRGB);
end

persistent mRGB2YCbCr;
mRGB2YCbCr = [0.299 0.587 0.114; -0.1687 -0.3313 0.5; 0.5 -0.4187 -0.0813];

imgRGB = permute(imgRGB, [3, 1, 2]);
imgYCbCr = zeros(size(imgRGB));
for m = 1:M
    for n = 1:N
        imgYCbCr(:, m, n) = mRGB2YCbCr * imgRGB(:, m, n) + [0 128 128].';
    end
end
imgYCbCr = permute(imgYCbCr, [2, 3, 1]);
end