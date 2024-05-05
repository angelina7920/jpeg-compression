function [block] = jpegHuffmanDecodeBlock(bitStr, type)
persistent huff_lac huff_cac;
[~, huff_lac, ~, huff_cac] = huffman_codes();

switch type
    case 'L'
        huff_ac = huff_lac;
        zrl = '11111111001';
        
    case 'C'
        huff_ac = huff_cac;
        zrl = '1111111010';
    
    otherwise
        error('Type must be L (luminance) or C (chromince).');
end

x = 2;
block = zeros(1, 64);

if strcmp(bitStr{2}, '0')
    if strcmp(bitStr{1}, '00')
        block(1) = 0;
    else
        block(1) = -1;
    end
else
    block(1) = huffmanBinaryToDecimal(bitStr{2});
end

i = 3;
while i < length(bitStr)
    if strcmp(bitStr{i}, zrl)
        x = x+14;
        i = i+1;
    end
    [run, ~] = find(strcmp(huff_ac, bitStr{i}));
    block(x+run-1) = huffmanBinaryToDecimal(bitStr{i+1});
    x = x+run;

    i = i+2;
end
end