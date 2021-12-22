classdef SaveFiles
    %파일 저장 클래스
    methods     ( Static = true )
        function Images(filepath, Image)            
            % 이미지 저장 함수.
            % 현재 별 이미지를 저장한다.
            if ispc()
                homedir = [getenv('HOMEDRIVE'), getenv('HOMEPATH')];
            else
                homedir = getenv('HOME');
            end
            Path = filepath;
            if ~exist(Path)
                mkdir(Path);
            end
            Path = strcat(Path,'/StarImage.png');
            imwrite(Image, Path);
        end

        function Logs(filepath, Logfile)
            % 로그파일을 저장한다.
            
        end
    end
end
