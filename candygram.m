candygram;

function [] = candygram()

    username = "Kiwi#1000";
    date = "Screenshot_20210117-194540_Pokmon_GO.jpg";
    specie = "null";
    cp = 0;
    atk = -1;
    def = -1;
    sta = -1;
    candy = -1;
    
    imageFiles = dir("images/*.jpg");
    
    % only interested in the number of images (x)
    [x y] = size(imageFiles);
    %m = zeros(x, 8);
    
    for i = 1:2:length(imageFiles)
        
        % image containing specie, CP, and IV information
        ivOutput = imread("images/" + imageFiles(i).name);
        
        % image containing the candy output. should always be immediately
        % after the specie info image, so its index is always i+1
        candyOutput = imread("images/" + imageFiles(i+1).name);
        
        % get the date the pokemon was transferred
        dateVal = imageFiles(i).name(12:19); % trim the parts of the string that aren't relevant
        date = datetime(dateVal, 'InputFormat', 'yyyyMMdd', 'Format', 'yyyy-MM-dd');
        
        % start by grabbing the IV's
        [atk def sta] = determineIVs(ivOutput);
        
        % now grab the amount of candy obtained by checking the next image
        candy = determineCandy(imread("images/" + imageFiles(i+1).name))
        
        m(floor(i/2)+1,:) = [username string(date) specie string(cp) string(atk) string(def) string(sta) string(candy)];
    end
    
end