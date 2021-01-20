function [atk def sta] = determineIVs(image)
    
    color0 = [226 226 226];
    color1to14 = [239 146 25];
    color15 = [225 128 121];
    
    % rows(1) = attack row
    % rows(2) = defense row
    % rows(3) = stamina row
    rows = [1738 1841 1945];
    
    % first digit is location to check for IV = 1, etc
    columns = [146 164 189 212 236 265 284 309 332 355 384 403 428 453];
    
    % default to -1 for error checking. first value is attack, etc
    results = [-1 -1 -1];
    
    % determine the 0-15 value of the IV
    for i = 1:3
        % start by checking the exceptions (0 and 15)
        if similarColors(image(rows(i), columns(1), :), color0) == 1
            results(i) = 0;
        elseif similarColors(image(rows(i), columns(3), :), color15) == 1
            results(i) = 15;
        
        % if neither of those work, read from the right side
        else
            for j = 14:-1:1
                if similarColors(image(rows(i), columns(j), :), color1to14) == 1
                    results(i) = j;
                    break;
                end
            end
        end
        
    end
    
    % convert restults into individual named variables
    atk = results(1);
    def = results(2);
    sta = results(3);
    
end