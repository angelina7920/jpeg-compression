function dctMatrix = computeDCTMatrix()
dctMatrix = zeros(8, 8);
colIncrement = 2;
dctMatrix(1, :) = sqrt(2)/4;
for rowIndex = 2:8
    factor = rowIndex - 1;
    for colIndex = 1:8
        dctMatrix(rowIndex, colIndex) = 0.5 .* cos(factor*pi/16);
        factor = factor + colIncrement;
    end
    colIncrement = colIncrement + 2;
end
end