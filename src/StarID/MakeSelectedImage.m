function MakeSelectedImage(UIAxes, StarCenter, DeterminedStarMap)
%MAKESELECTEDIMAGE
%   골라진 피라미드 별 4개의 위치를 표시해주는 함수.

racX = 30;
racY = 30;
hold(UIAxes, 'on');
[~,cols] = size(DeterminedStarMap);
combi = nchoosek(DeterminedStarMap(:,1:(cols/2)),2);


for i= 1:(cols/2)
    rectangle(UIAxes, 'Position', [StarCenter(DeterminedStarMap(i),1) - racX/2, StarCenter(DeterminedStarMap(i),2) - racY/2 , ...
        racX, racY],'EdgeColor','y','Curvature',[1 1]);
end

for i=1:size(combi,1)
    plot(UIAxes,[StarCenter(combi(i,1),1), StarCenter(combi(i,2),1)],...
        [StarCenter(combi(i,1),2), StarCenter(combi(i,2),2)],'-.y');
end

end

