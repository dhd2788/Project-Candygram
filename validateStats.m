function valid = validateStats(specie, cp, ivs, specieNames, baseStats, cpModifier)
    
    valid = 0;

    % find the specie in the table
    idx = find(strcmp(specie,specieNames));
    
    bases = baseStats(idx,:);
    
    % there's 100 possible CP values given a pokemon's IV's. To avoid using
    % excessive calculations, we use binary search to find a valid CP
    l = 0;
    [r n]= size(cpModifier);
    r = r - 1;
    
    while l <= r
        % get middle element of current half
        m = floor((l+r)/2);
        
        % formula to calculate CP from level and IV's. this is what we're
        % searching for
        currCp = floor(((bases(1) + ivs(1)) * sqrt(bases(2) + ivs(2)) * sqrt(bases(3) + ivs(3)) * (cpModifier(m)*cpModifier(m))) / 10);
        
        if currCp < cp
            l = m + 1;
        elseif currCp > cp
            r = m - 1;
        else
            valid = 1;
            break;
        end
    end
end