%GETSPECIENAME Retrieves the name of a specie in a Pokemon Go screenshot of
%the appraisal screen
%   IMAGE = the image to read the data from. image must already be opened
function specie = getSpecieName(image)

    % define a region of interest for where to check for CP
    roi = [272 963 866-272 1054-963];

    % perform OCR on the section of the image with the CP value
    results = ocr(image, roi);
    
    % strip all weird characters that are found
    specie = regexp(results.Text,'\W*\w*','match');
    specie = string(specie(1));
    
    % the case of some characters sometimes gets misinterpreted as capital
    % handle that here
    specie = lower(specie);
    
    % now capitalize the first character using regex
    specie = convertStringsToChars(specie);
    idx=regexp([' ' specie],'(?<=\s+)\S','start')-1;
    specie(idx)=upper(specie(idx));
    
    % exception case for baltoy : often gets interpreted as "Bakoy"
    if string(specie) == "Bakoy"
        specie = 'Baltoy';
    end
    
end