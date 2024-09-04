function CreatePolygon(x, y, vertices, size, rotation)
    vert = {}
    currentSpan = (CIRC)/ vertices
    for i = 1, vertices do
        vert[i*2 - 1] = (math.sqrt(size)*math.cos(currentSpan * (i-1) + rotation)) + x
        vert[i*2] = (math.sqrt(size)*math.sin(currentSpan * (i-1) + rotation)) + y
    end
    return vert
end