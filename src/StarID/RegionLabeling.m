function [ labels, ObjNum ] = RegionLabeling( data, Threshold)
%anodeg_bwlable binary image labeling
% Labels a binary image through 8-point connectivity without the need 
% for any toolboxes. 
ChangeThreshold = 1;



[x,y] = size(data);
% expand dataset to avoid crash when searching:
data = [zeros(1,y+2);[zeros(x,1) data zeros(x,1)]];
[x,y] = size(data);

while ChangeThreshold
    ChangeThreshold = 0;

    labels = zeros(size(data));
    nextlabel = 1;
    linked = [];

for i = 2:x                       % for each row
    for j = 2:y-1                 % for each column
        if data(i,j) >= Threshold % not background
            % find binary value of neighbours
            neighboursearch = [data(i-1,j-1), data(i-1,j), data(i-1,j+1),data(i,j-1)];
            % for 4-connectivity, replace with:
%             neighboursearch = [data(i-1,j),data(i,j-1)];
            
            % search for neighbours with binary value 1
            [~,n,neighbours] = find(neighboursearch >= Threshold);
            
            % if no neighbour is allready labeled: assign new label
            if isempty(neighbours)
                linked{nextlabel} = nextlabel; %#ok<*AGROW>
                labels(i,j) = nextlabel;
                nextlabel = nextlabel+1;                
            
            % if neighbours is labeled: pick the lowest label and store the
            % connected labels in "linked"
            else
                neighboursearch_label = [labels(i-1,j-1), labels(i-1,j), labels(i-1,j+1),labels(i,j-1)];
%                 neighboursearch_label = [labels(i-1,j), labels(i,j-1)];

                L = neighboursearch_label(n);
                labels(i,j) = min(L);
                for k = 1:length(L)
                    label = L(k);
                    linked{label} = unique([linked{label} L]);
                end 
                linked{label} = sort(linked{label});
            end
        end
    end
end
% 약 픽셀 수의 0.4% 이상 linked 어레이가 생기면 Threshold 를 더 높여서 linked 를 줄임
% 구간을 나누어서 linked 어레이가 너무 많으면 Threshold 를 1이 아닌 2씩 증가시킴.
if (numel(linked) > x*y/250) && (numel(linked) <= x*y/100)
    ChangeThreshold = 1;
    Threshold = Constrain(Threshold + 1, 255);
    if Threshold == 255
        ChangeThreshold = 0;
    end
elseif (numel(linked) > x*y/100)
    ChangeThreshold = 1;
    Threshold = Constrain(Threshold + 2, 255);
    if Threshold == 255
        ChangeThreshold = 0;
    end
end

end
% remove the previous expansion of the image
labels = labels(2:end,2:end-1);


%% join linked areas


% for each link, look through the other links and look for common labels.
% if common labels exist they are linked -> replace both link with the 
% union of the two. Repeat until there is no change in the links.
% 숫자가 많아지면 엄청난 컴퓨팅 타임을 소비하기에 수정 필요(못하것음 ㅠㅠ)
change2 = 1;
while change2 == 1
    change = 0;
    for i = 1:length(linked)
        for j = 1:length(linked)
            if i ~= j
                if sum(ismember(linked{i},linked{j}))>0 && sum(ismember(linked{i},linked{j})) ~= length(linked{i})
                    change = 1;
                    linked{i} = union(linked{i},linked{j});
                    linked{j} = linked{i};
                end
            end
        end
    end
    
    if change == 0
        change2 = 0;
    end
    
end

if size(linked,1) ~= 0
    % removing redundat links
    linked = unique(cellfun(@num2str,linked,'UniformOutput',false));
    linked = cellfun(@str2num,linked,'UniformOutput',false);

    K = length(linked);
    templabels = labels;
    labels = zeros(size(labels));

    % label linked labels with a single label:
    for k = 1:K
        for l = 1:length(linked{k})
            labels(templabels == linked{k}(l)) = k;
        end
    end
end

ObjNum = max(labels, [], 'all');
%% 별보다 작은 픽셀의 물체 빼기.
% 노이즈같이 너무 적은 픽셀을 가진 별은 제거.


%% 별이라 판단되지 않는 물체 제거.
% 노이즈같이 너무 적은 픽셀을 가진 물체와 
% 달같이 너무 많은 수의 픽셀을 가진 물체 빼기.

%%% 수정가능성 있음.

XPixCount = 0;
XPixArr = [];

% 물체의 픽셀 갯수를 가늠해 라벨을 0으로 변환.
for z = 1:ObjNum
    if (numel(find(labels == z)) > (x/100)*(y/100)) || (numel(find(labels == z)) < (2)*(2))
        XPixArr = [XPixArr, z];
        labels(labels == z) = 0;        
    end
%     if numel(find(labels == z)) < (2)*(2)
%         XPixArr = [XPixArr, z];
%         labels(labels == z) = 0;        
%     end
end

% 빠진 물체때문에 사라진 라벨링 넘버를 맞춰줌.
for z2 = XPixArr
    tempArr = find(labels > z2 - XPixCount);
    labels(tempArr) = labels(tempArr) - 1;
    XPixCount = XPixCount + 1;
end

% 오브젝트 갯수 수정.
ObjNum = ObjNum - numel(XPixArr);

end  


function output = Constrain(input, value)
    if input > value
        output = value;
    else
        output = input;
    end

end
