function similar = similarColors(color1, color2, varargin)

    defaultThreshold = 5;
    
    p = inputParser;
    validScalarPosNum = @(x) isnumeric(x) && isscalar(x) && (x > 0);
    validVector = @(x) isvector(x);
    addRequired(p, 'color1', validVector);
    addRequired(p, 'color2', validVector);
    addOptional(p, 'threshold', defaultThreshold, validScalarPosNum);
    parse(p,color1,color2,varargin{:});
    
    threshold = p.Results.threshold;

    % find the distance between the two colors
    distance = 0;
    for i = 1:3
        % convert from uint8 to single in case of negatives
        distance = distance + abs(single(color1(i)) - single(color2(i)));
    end
    
    % if the distance between the two colors is small, it's probably noise,
    % so return true. otherwise return false
    if distance < threshold
        similar = 1;
    else
        similar = 0;
    end
    
end