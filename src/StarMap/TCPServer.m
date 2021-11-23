classdef TCPServer
    % TCP/IP 통신 서버
    % 이미지 매트릭스를 StarID 프로그램에 전달하기 위한 TCP/IP 통신 서버
    
    properties
        Property1
    end
    
    methods( Static = true )
        function t = CreateTCPServer(address,port)
            %TCPSERVER 이 클래스의 인스턴스 생성
            %   자세한 설명 위치
            t = tcpserver(address,port);            
        end
        
        function outputArg = SendData(inputArg, t)
            %METHOD1 이 메서드의 요약 설명 위치
            %   자세한 설명 위치
            outputArg = obj.Property1 + inputArg;
        end
    end
end