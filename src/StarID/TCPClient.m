function [client] = TCPClient(ServerAddress,port)
%TCPCLIENT 이 함수의 요약 설명 위치
%   자세한 설명 위치

client = tcpclient(ServerAddress,port);
end

