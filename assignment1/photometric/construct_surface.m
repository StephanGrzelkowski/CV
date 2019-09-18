function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface


if nargin == 2
    path_type = 'column';
end

switch path_type
    case 'column'
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
        
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        
        height_map = column_integration(p, q);
       
        % =================================================================
               
    case 'row'
        
        % =================================================================
        % YOUR CODE GOES HERE
        height_map = row_integration(p, q);
        
        % =================================================================
          
    case 'average'
        
        % =================================================================
        % YOUR CODE GOES HERE

        height_map = (column_integration(p,q) + row_integration(p,q) ) ./ 2;
        % =================================================================
end


end

function height_map = column_integration(p,q)
%column_integrations construct the surface function represented as height_map
%using the column major algorithm
%   p : measures value of df / dx
%   q : measures value of df / dy
%
%   height_map: the reconstructed surface

%per allocate
[h, w] = size(p);
height_map = zeros(h, w);

%for each row
for it_r = 1 : h
    %calculate the initial height value (starting with 0
    if it_r > 1
        height_map(it_r, 1) = height_map(it_r - 1, 1) + q(it_r - 1, 1);
    end
    %iterate to the right (over columns)
    for it_c = 2 : w
        height_map(it_r, it_c) =  height_map(it_r, it_c - 1) + p(it_r, it_c -1);
    end
end
end 

function height_map = row_integration(p,q)
%row_integrations construct the surface function represented as height_map
%using the row major algorithm
%   p : measures value of df / dx
%   q : measures value of df / dy
%
%   height_map: the reconstructed surface

%pre-allocate
[h, w] = size(p);
height_map = zeros(h, w);

%for each column
for it_c = 1 : w
    %calculate the initial height value (starting with 0)
    if it_c > 1
        height_map(1, it_c) = height_map( 1,it_c - 1) + p(1, it_c);
    end
    %iterate to downwards (over rows) adding q values 
    for it_r = 2 : h
        height_map(it_r, it_c) =  height_map(it_r - 1, it_c) + q(it_r - 1, it_c);
    end
end
end
