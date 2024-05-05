function imgRGB = jpegDecoder(bitStr, imgDimensions, quality)

persistent dctMatrix idctMatrix;
dctMatrix = computeDCTMatrix();
idctMatrix = dctMatrix.';

persistent Q50L Q50C;
[Q50L, Q50C] = jpegQuantizationMatrices();
QLs = scaleQuantizationMatrix(Q50L, quality);
QCs = scaleQuantizationMatrix(Q50C, quality);

x = 1;
img = zeros(imgDimensions(1), imgDimensions(2), imgDimensions(3));
for c = 1:imgDimensions(3)
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
    
    for i = 1:8:imgDimensions(1)
        for j = 1:8:imgDimensions(2)
            zigzag = jpegHuffmanDecodeBlock(bitStr{x}, type);
            
            zigzag(1) = zigzag(1) + old_dc;
            old_dc = zigzag(1);
            
            B = zigzagToBlock(zigzag);
            
            G = B.*Qs;
            
            img(i:i+7, j:j+7, c) = idctMatrix * G * dctMatrix;
            x = x+1;
        end
    end
end

if imgDimensions(3) == 3
    imgRGB = convertYCbCrToRGB(img);
else
    imgRGB = uint8(img);
end
end