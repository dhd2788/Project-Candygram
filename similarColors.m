function similar = similarColors(color1, color2)

    % find the distance between the two colors
    distance = 0;
    for i = 1:3
        % convert from uint8 to single in case of negatives
        distance = distance + abs(single(color1(i)) - single(color2(i)));
    end
    
    % if the distance between the two colors is small, it's probably noise,
    % so return true. otherwise return false
    if distance < 5
        similar = 1;
    else
        similar = 0;
    end
    
end