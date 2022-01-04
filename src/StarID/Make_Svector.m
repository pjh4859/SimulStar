function [Kvector,outputArg1] = Make_Svector(FoVx, FoVy, ThresholdMag)
%MAKE_KVECTOR
%   FOV와 별의 밝기등급에 대한 K-vector 가 없으면 생성함.

% % Determine where your m-file's folder is.
% folder = fileparts(which('Make_Kvector.m')); 
% % Add that folder plus all subfolders to the path.
% addpath(genpath(folder));
if isdeployed
    filepath = './BSCatalog/';
    filename = "Kvector_FoVx"+FoVx+"FoVy"+FoVy+"Mag"+ThresholdMag+".txt";
    filename2 = "Svector_FoVx"+FoVx+"FoVy"+FoVy+"Mag"+ThresholdMag+".txt";
    filename3 = "Kvector_a1a0_FoVx"+FoVx+"FoVy"+FoVy+"Mag"+ThresholdMag+".txt";
else
    filepath = '../BSCatalog/';
    filename = "Kvector_FoVx"+FoVx+"FoVy"+FoVy+"Mag"+ThresholdMag+".txt";
    filename2 = "Svector_FoVx"+FoVx+"FoVy"+FoVy+"Mag"+ThresholdMag+".txt";
    filename3 = "Kvector_a1a0_FoVx"+FoVx+"FoVy"+FoVy+"Mag"+ThresholdMag+".txt";
end

Svector = [];
Tempvector = [];
Kvector = [];
NumberMatch = {}; 
NumberMatch2 = {}; 

if isfile(filepath+filename)
    outputArg1 = 0;
else
    % Kvector가 없을 경우
    % wait bar
%     f = msgbox({'Making K-vector...';'Please wait...'}, 'Message','warn');
    tic;
    waitbar_h = waitbar(0,'Making K-vector Please wait...');
    outputArg1 = 1;
    if ~exist(filepath)
        mkdir(filepath);
    end
    if isdeployed
        BSCatalogpath = ""+"BSCatalog.txt";
    else
        BSCatalogpath = filepath+"BSCatalog.txt";
    end
    BSCatalogData = readmatrix(BSCatalogpath);    
    FoV = sqrt(double(FoVx)^2 + double(FoVy)^2);
    
    n=1;
    
    for i=1:size(BSCatalogData,1)        
        % wait bar 생성.
        waitbar_str = sprintf('%s\n%s',['Making K-vector Please wait...Time Elapsed: ',datestr(datenum(0,0,0,0,0,toc),'HH:MM:SS')]);  
            elapsedPercent = i/size(BSCatalogData,1);
            waitbar(elapsedPercent, waitbar_h , waitbar_str);
        for j=1:size(BSCatalogData,1)            
            if i ~= j
                if i < j
                    RA_Star1 = BSCatalogData(i,2);
                    DEC_Star1 = BSCatalogData(i,3);
                    RA_Star2 = BSCatalogData(j,2);
                    DEC_Star2 = BSCatalogData(j,3);
                    %       별의 벡터 구하기.
                    [x1,y1,z1] = sph2cart(RA_Star1*pi/180, DEC_Star1*pi/180,1);
                    [x2,y2,z2] = sph2cart(RA_Star2*pi/180, DEC_Star2*pi/180,1);

                    StarVector1 = [x1,y1,z1];
                    StarVector2 = [x2,y2,z2];

                    %       두 별의 벡터 내적.
                    StarDot = dot(StarVector1, StarVector2);
                    %       두 별의 밝기 읽기.
                    Magnitude1 = BSCatalogData(i,4);
                    Magnitude2 = BSCatalogData(j,4);
                    %       두 별의 밝기등급 제한
                    if (Magnitude1 <= ThresholdMag && Magnitude2 <= ThresholdMag)
                        %       내적을 이용해서 두 별의 각거리가 FoV 내부에 있는지 확인.
                        if (StarDot >= cosd(FoV))
                            % Svector의 형상 
                            % [두 별의 cos각, i인덱스, j인덱스]
                            Svector(n,1) = StarDot;
                            Svector(n,2) = i;
                            Svector(n,3) = j;
                            % 여기서는 각 행마다 i 와 j 에 해당하는 별의 카탈로그상의 번호를 저장했는데,
                            % 다른 방식으로는 아얘 번호에 다른 파일을 만들어서 저장해놓을 수 있겠음. 
                            % 그 편이 파일의 용량 크기를 많이 줄일 수 있을 듯.
                            % NumberMatch의 형상
                            % [i 또는 j 인덱스번호, 카탈로그의 별 번호]
                            % 할 까 했는데, 생각해보니 그냥 i랑 j 인덱스가 별 카탈로그의 줄 수였음. 
%                             NumberMatch{n} = [i,BSCatalogData(i,1)];
%                             NumberMatch2{n} = [j,BSCatalogData(j,1)];
%                             Svector(n,4) = BSCatalogData(i,1);
%                             Svector(n,5) = BSCatalogData(j,1);
                            n = n+1; 
                        end
                    end 
                end
            end
        end
        
    end
    %wait bar 끄기
    close(waitbar_h);
    clear waitbar_h;
%   아무 별도 해당되지 않을 경우 예외처리.
    if (~size(Svector,1))
        Svector = [NaN,NaN,NaN,NaN,NaN];
    end   
    
%     Svector 의 1번 열에 대해 오름차순으로 정렬.
    Tempvector = sortrows(Svector, 1);
    
    [Kvector, a1, a0] = Make_Kvector(Tempvector);
    aArr = [a1,a0];
    
    writematrix(Kvector,filepath+filename,'Delimiter','tab');
%     writematrix(Tempvector,filepath+filename2,'Delimiter','tab');
    writematrix(aArr,filepath+filename3,'Delimiter','tab');    
    close('all');
    
end
%     disp(outputArg1);
end
