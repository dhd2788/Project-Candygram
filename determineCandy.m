function candy = determineCandy(image)
    
    % the color and location of the search bar where the XL candy goes over
    color = [231 243 223];
    loc = [895 453];
    
    % if the color of the pixel location on the search bar is similar to
    % what it would be without candy gains, set the candy gain to 0
    if similarColors(image(loc(2),loc(1),1), color(1)) == 1
        candy = 0;
    else
        candy = 1;
    end
end