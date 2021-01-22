function [names stats cp] = tableToMatrix(baseStats, cpModifier)
    
    names = [""];
    stats = [];
    [x y] = size(baseStats);
    
    for i = 1:x
        names(i) = string(baseStats{i,1});
        stats(i,:) = baseStats{i,2:4};
    end
    
	[x y] = size(cpModifier);
    cp = [];
    for i = 1:x
        cp(i) = cpModifier{i,2};
    end
    
    names = names';
    cp = cp';
    
end