function cp = getCP(image, darkenPixels)
    
    % define a region of interest for where to check for CP
    roi = [356 215 647 300];
    white = [255 255 255];
    black = [0 0 0];
        
    % change the last two parameters of region of interest to size of box
    % instead of coordinates for the OCR function
    %roi(3) = roi(3)-roi(1);
    %roi(4) = roi(4)-roi(2);
    
    textbox = image(roi(2):roi(4), roi(1):roi(3),:);
    
    % if the function calls to darken pixels, this code block will change
    % all pixels that are not near white to black to allow easier reading
    % for OCR. This often causes more problems than it solves, but in the
    % cases that CP validation fails, this usually fixes the problem. it's
    % also incredibly slow and should not be called often
    if darkenPixels == 1
        
        se = strel('disk',12);
        textbox = imtophat(textbox, se);
        contrastAdjusted = imadjust(rgb2gray(textbox));
        
        %bwbox = rgb2gray(textbox);
        %edges = edge(bwbox, 'canny');
        
%         for i = 2:roi(4)-roi(2)-1
%             for j = 2:roi(3)-roi(1)-1
%                 if edges(i,j) == 1
%                     textbox(i,j,:) = 0;
%                     textbox(i-1,j,:) = 0;
%                     textbox(i,j-1,:) = 0;
%                     textbox(i+1,j,:) = 0;
%                     textbox(i,j+1,:) = 0;
%                 end
%             end
%         end
        
%         for i = roi(2):roi(4)
%             for j = roi(1):roi(3)
%                 if similarColors(squeeze(image(i,j,:)), white, 'threshold',20) == 0
%                     image(i,j,:) = black;
%                 end
%             end
%         end
    end
    
    

    
    % perform OCR on the section of the image with the CP value
    results = ocr(textbox);
    
    cp = results.Text;
    
    % convert O's to zeros and Z's to twos, as those often get misinterpreted
    cp = strrep(cp,'O','0');
    cp = strrep(cp,'o','0');
    cp = strrep(cp,'Z','2');
    cp = strrep(cp,'z','2');
    cp = strrep(cp,'©','0');
    
    % ignore all non-digit characters
    cp = regexp(cp, '\d', 'match');
    
    % convert to string
    cp = strjoin(cp,'');
    
    % if it's over 9000, it interpreted the "P" in "CP" as a 9
    if str2double(cp) > 9000
        cp = string(str2double(cp) - 9000);
    end
    
    imshow(textbox);
        
    
end