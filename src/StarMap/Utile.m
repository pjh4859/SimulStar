classdef Utile
    % 여러가지 UTILES
    % # 구성 목록
    % 1. ConstrainUint16: 두개의 인수를 받아 더하는데, 16비트의 최대값을 넘게되면 65535 로 고정한다.
    % 2. method1: 임시 메소드
   
    methods     ( Static = true )
        function returnValue = ConstrainUint16(inputArg1,inputArg2)            
            returnValue = inputArg1 + inputArg2;
            if returnValue > 65535
                returnValue = 65535;
            end
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 이 메서드의 요약 설명 위치
            %   자세한 설명 위치
            outputArg = obj.Property1 + inputArg;
        end
    end
end

