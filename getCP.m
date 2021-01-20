function cp = getCP(image)
    
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
    if double(cp) > 9000
        cp = string(double(cp) - 9000);
    end
    
end