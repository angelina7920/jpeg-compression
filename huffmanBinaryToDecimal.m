function dec = huffmanBinaryToDecimal(binStr, varargin)
if isempty(varargin)
    zerosize = false;
else
    zerosize = varargin{1};
end

if (strcmp(binStr,'0'))
    if (zerosize)
        dec = 0;
    else
        dec = -1;
    end
else
    if (binStr(1) == '1')
        dec = bin2dec(binStr);
    else
        dec = -1 * bin2dec(char(not(int32(binStr) - int32('0')) + '0'));
    end
end
end