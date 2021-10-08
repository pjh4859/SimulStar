
classdef SaveFiles
    %파일 입출력 클래스
    methods     ( Static = true )
        function BSCatalogData = Images(filepath)
            arguments
                filepath = '../BSCatalog/BSCatalog.txt';
            end
            if ispc()
                homedir = [getenv('HOMEDRIVE'), getenv('HOMEPATH')];
            else
                homedir = getenv('HOME');
            end
        end

        function BSCatalogData = Logs(filepath)
            arguments
                filepath = '../BSCatalog/BSCatalog.txt';
            end
            BSCatalogData = readmatrix(filepath);
        end
    end
end
