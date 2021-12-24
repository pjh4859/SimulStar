function [Unique] = UniqueSol(MatchPyramid)
%UNIQUESOL
%   배열이 한 줄인지 확인.
Unique = 0;
if size(MatchPyramid,1) == 1    
    Unique = 1;
end
end