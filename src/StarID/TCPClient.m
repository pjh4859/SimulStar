function [client] = TCPClient(ServerAddress,port)
%TCPCLIENT tcpip client를 생성
%    tcpip client를 생성

client = tcpclient(ServerAddress,port); 
% configureCallback(client,'terminator',@TCPIP_TerminatorCallbackFnc);

end

