classdef Utile
    %UTILES 이 클래스의 요약 설명 위치
    %   자세한 설명 위치
   
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

