
n=1;
% for i = 1:100
%     for j=1:1000
%         if i ~= j
%             if i<j
%         n=n+1
%             end
%         end
%     end
% end

for i=1:100
    for j=i+1:1000
        n=n+1
    end
end