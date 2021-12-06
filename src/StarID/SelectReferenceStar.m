function [r] = SelectReferenceStar(i,j,k,StarNum)
%SELECTREFERENCESTAR
%   i,j,k 3개의 별 이외에 Refference Star r 을 골라냄.
    r = randi(StarNum,1);
while(r == i || r == j || r == k)
    r = randi(StarNum,1);
end

end

