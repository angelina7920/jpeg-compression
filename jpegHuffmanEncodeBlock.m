function [bitStr] = jpegHuffmanEncodeBlock(block, type)
persistent huff_ldc huff_lac huff_cdc huff_cac;
[huff_ldc, huff_lac, huff_cdc, huff_cac] = huffman_codes();

switch type
    case 'L'
        huff_dc = huff_ldc;
        huff_ac = huff_lac;
        zrl = '11111111001';
        eob = '1010';
    
    case 'C'
        huff_dc = huff_cdc;
        huff_ac = huff_cac;
        zrl = '1111111010';
        eob = '00';
    
    otherwise
        error('Type must be L (luminance) or C (chromince).');
end

bitStr = {};
b = huffmanDecimalToBinary(block(1));

if block(1) == 0
    bitStr{end+1} = huff_dc{1};
else
    bitStr{end+1} = huff_dc{1+strlength(b)};
end
bitStr{end+1} = b;

zeros = 0;
for i = 2:length(block)
    if block(i) == 0
        zeros = zeros+1;
    else
        if zeros > 15
            streak = floor(zeros/15);
            for z=1:streak
                bitStr{end+1} = zrl;
            end
            zeros = streak+1;
        end
        b = huffmanDecimalToBinary(block(i));
        bitStr{end+1} = huff_ac{1+zeros, strlength(b)};
        bitStr{end+1} = b;
        zeros = 0;
    end
end

bitStr{end+1} = eob;
end