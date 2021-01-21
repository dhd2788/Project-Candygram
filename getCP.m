function cp = getCP(image)
    
    %% Get CP
    % define a region of interest for where to check for CP
    roi = [356 208 647 311];
    white = [255 255 255];
    black = [0 0 0];
        
    % change the last two parameters of region of interest to size of box
    % instead of coordinates for the OCR function
    roi(3) = roi(3)-roi(1);
    roi(4) = roi(4)-roi(2);
    
    % perform OCR on the section of the image with the CP value
    results = ocr(image, roi);
    
    cp = results.Text;
    
    % convert O's to zeros, as those often get misinterpreted
    cp = strrep(cp,'O','0');
    cp = strrep(cp,'o','0');
    
    % ignore all non-digit characters
    cp = regexp(cp, '\d', 'match');
    
    % convert to string
    cp = strjoin(string(cp),'');
    
    % if it's over 9000, it interpreted the P in CP as a 9
    if double(cp) > 9000
        cp = string(double(cp) - 9000);
    end
    
    %% validate CP
    % validate the CP. if invalid, make the region of interest more
    % readable by changing all non-white pixels to black
    for i = roi(2):roi(4)
        for j = roi(1):roi(3)
            if similarColors(squeeze(image(i,j,:)), white, 'threshold',20) == 0
                image(i,j,:) = black;
            end
        end
    end
    
end