function [Kvector, a1, a0] = Make_Kvector(Svector)
%MAKE_KVECTOR
% Make_Svector 함수로부터 Svector를 입력받아 Kvector를 만들어 반환하는 함수.
% D = [S(m) - S(1)]/(m-1)
% a1 = mD/(m-1) , a0 = S(1) - a1 - D/2
% cos(theta) = a1*k + a0
m = size(Svector,1);
Sm = Svector(m,1);
S1 = Svector(1,1);
D = (Sm - S1)/(m-1);
a1 = m*D/(m-1);
a0 = S1 - a1 - D/2;

Tempvector = Svector(:,1);
Kvector(1,1) = 0;

for k = 2:m
    CheckCos = a1*k + a0;
    L = nnz(Tempvector <= CheckCos);
    Kvector(k,1) = L;
end
% Kvector의 형상 
% [k 값, i인덱스, j인덱스]
Kvector(:,2:3) = Svector(:,2:3);

end

