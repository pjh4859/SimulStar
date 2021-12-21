function TCPIP_ConnectionChangedFcn(server,event,app)
%TCPIP_ConnectionChangedFcn
%   TCP/IP 통신상태가 바뀌면 실행되는 콜백 함수.
if server.Connected
    app.ConnectLamp.Color = [0 1 0];
else
    app.ConnectLamp.Color = [1 0 0];
end

end

