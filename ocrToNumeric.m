function string = ocrToNumeric(string)
    % convert O's to zeros, as those often get misinterpreted
    string = strrep(string,'O','0');
    string = strrep(string,'o','0');
    
    % ignore all non-digit characters
    string = regexp(string, '\d', 'match');
    
    % convert to string
    string = strjoin(string(string),'');
end