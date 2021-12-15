classdef TCPServer
    % TCP/IP 통신 서버
    % 이미지 매트릭스를 StarID 프로그램에 전달하기 위한 TCP/IP 통신 서버
    
    properties
        Property1
    end
    
    methods( Static = true )
        function t = CreateTCPServer(address,port)
            %TCPSERVER
            %   TCP/IP 서버를 생성하는 함수
            t = tcpserver(address,port);            
        end
        
        function outputArg = SendData(inputArg, ~)
            %SendData
            %   데이터를 TCP/IP 통신을 통해 보내는 함수
            outputArg = obj.Property1 + inputArg;
        end
    end
end