function b = huffmanDecimalToBinary(d)
if (d >= 0)
    b = dec2bin(d);
else
    b = dec2bin(abs(d));
    b = char(int32(not(b - '0')) + int32('0'));
    minNumBits = floor(log2(abs(d))) + 1;
    b = b(end - minNumBits + 1 : end);
end
end