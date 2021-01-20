function cp = getCP(image)
    % initialize to -1 for error checking
    cp = -1;
    
    % define a region of interest for where to check for CP
    roi = [356 208 647-356 311-208];
    
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
    if cp > 9000
        cp = cp - 9000;
    end
    
end