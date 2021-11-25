function MakeStarCenterImage(UIAxes,StarCenter)
%MAKESTARCENTERIMAGE 
%   별 중심좌표를 이용해 별 지도에 표시하는 함수.

[row,col] = size(StarCenter);
racX = 24;
racY = 24;

for i= 1:row
    rectangle(UIAxes, 'Position', [StarCenter(i,1) - racX/2, StarCenter(i,2) - racY/2 , racX, racY],'EdgeColor','r');
end

end

