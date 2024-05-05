function [bitStr, imgDimensions] = jpegEncoder(imgRGB, quality)

[imgHeight, imgWidth, imgColors] = size(imgRGB);
imgDimensions = [imgHeight, imgWidth, imgColors];

if ((quality < 1) || (quality > 100))
    error('Quality must be between 1 and 100.');
end

if imgColors == 3
    img = convertRGBToYCbCr(imgRGB);
else
    img = double(imgRGB);
end

persistent dctMatrix idctMatrix;
dctMatrix = computeDCTMatrix();
idctMatrix = dctMatrix.';

persistent Q50L Q50C;
[Q50L, Q50C] = jpegQuantizationMatrices();
QLs = scaleQuantizationMatrix(Q50L, quality);
QCs = scaleQuantizationMatrix(Q50C, quality);

x = 1;
bitStr = cell(1, prod(imgDimensions) / 64);
for c = 1:imgColors
    switch c
        case 1
            old_dc = 0;
            Qs = QLs;
            type = 'L';
        
        case 2
            old_dc = 0;
            Qs = QCs;
            type = 'C';
    end

    for i = 1:8:imgHeight
        for j = 1:8:imgWidth
            G = dctMatrix * img(i:i+7, j:j+7, c) * idctMatrix;
            
            B = round(G./Qs);
            
            zigzag = blockToZigzag(B);
            
            current_dc = zigzag(1);
            zigzag(1) = zigzag(1) - old_dc;
            old_dc = current_dc;
            
            bitStr{x} = jpegHuffmanEncodeBlock(zigzag, type);
            x = x+1;
        end
    end
end
end