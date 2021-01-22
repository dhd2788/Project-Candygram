function [] = candygram()

    % TODO read in configuration file
    
    username = "Kiwi#1000";
    
    imageFiles = dir("images/*.jpg");
    
    % grab data for stat validation
    validation_data = load('validation_data.mat');
    specieNames = validation_data.names;
    baseStats = validation_data.stats;
    cpModifier = validation_data.cp;
    
    % only interested in the number of images (x)
    [x y] = size(imageFiles);
    %m = zeros(x, 8);
    
    for i = 1:2:length(imageFiles)
        
        % image containing specie, CP, and IV information
        appraisal = imread("images/" + imageFiles(i).name);
        
        % image containing the candy output. should always be immediately
        % after the specie info image, so its index is always i+1
        candyOutput = imread("images/" + imageFiles(i+1).name);
        
        % get the date the pokemon was transferred
        dateVal = imageFiles(i).name(12:19); % trim the parts of the string that aren't relevant
        date = datetime(dateVal, 'InputFormat', 'yyyyMMdd', 'Format', 'yyyy-MM-dd');
        
        % start with CP
        cp = getCP(appraisal, 0);
        
        % get specie name
        specie = getSpecieName(appraisal);
        
        % grab the IV's
        [atk def sta] = determineIVs(appraisal);
                
        % if invalid, the CP was probably read wrong, so we want to black
        % out the pixels around the text and try again
        if validateStats(specie, cp, [atk def sta], specieNames, baseStats, cpModifier) == 0
            cp = getCP(appraisal, 1);
        end
        
        % check if valid again. if still invalid, note it as such in the
        % results
        if validateStats(specie, cp, [atk def sta], specieNames, baseStats, cpModifier) == 0
            cp = "FAILED TO READ CP";
        end
        
        % now grab the amount of candy obtained by checking the next image
        candy = determineCandy(imread("images/" + imageFiles(i+1).name));
        
        m(floor(i/2)+1,:) = [username string(date) specie string(cp) string(atk) string(def) string(sta) string(candy)];
    end
    
    % TODO: export as spreadsheet
    
end