
classdef SaveFiles
    %파일 입출력 클래스
    methods     ( Static = true )
        function Images(filepath, Image)            
            if ispc()
                homedir = [getenv('HOMEDRIVE'), getenv('HOMEPATH')];
            else
                homedir = getenv('HOME');
            end
            Path = filepath;
            Path = strcat(Path,'/StarImage.png');
            imwrite(Image, Path);
        end

        function Logs(filepath, Logfile)
            
        end
    end
end
