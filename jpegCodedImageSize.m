function [bpp] = jpegCodedImageSize(bitStr, imgDimensions)

numBits = 0;
for ii = 1:numel(bitStr)
    block = bitStr{ii};
    for jj = 1:numel(block)
        numBits = numBits + numel(block{jj});
    end
end

numBits = numBits + 2 * 8 * 160 * (1 + (imgDimensions(3) == 3));

numBits = numBits + 2 * 8 * 12 * (1 + (imgDimensions(3) == 3));

numBits = numBits + 8 * 64 * (1 + (imgDimensions(3) == 3));

bpp = numBits / (imgDimensions(1) * imgDimensions(2));
end