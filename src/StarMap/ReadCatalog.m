classdef ReadCatalog 
%파일 입출력 클래스
    methods     ( Static = true )        
        function BSCatalogData = cell(filepath)
            % 셀 형태로 읽기
            arguments
                filepath = '../BSCatalog/BSCatalog.txt';
            end
            opts = delimitedTextImportOptions('DataLines',3,'Delimiter',' ','ConsecutiveDelimitersRule', 'join');
            BSCatalogData = readcell(filepath,opts);
            BSCatalogData(:,1) = [];
        end
        
        function BSCatalogData = array(filepath)
            % 어레이 형태로 읽기
            arguments
                filepath = '../BSCatalog/BSCatalog.txt';
            end
            BSCatalogData = readmatrix(filepath);    
        end
    end
end




