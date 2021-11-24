function [StarMat,PixX,PixY] = TCPIPReadData(client)
%TCPIPGETDATA 
%   TCP/IP 클라이언트를 통해 이미지 매트릭스를 받고, 다시 원래 배열로 복구
while (client.NumBytesAvailable > 0)
    temp = read(client,2,"uint16");
    PixX = temp(1);
    PixY = temp(2);
    tempStarMat = read(client,cast(PixX,'uint32')*cast(PixY,'uint32'),"uint8");
end
% temp = read(client,2,"uint16");
% tempStarMat = read(client,client.NumBytesAvailable,"uint8");
% PixX = temp(1);
% PixY = temp(2);
StarMat = reshape(tempStarMat,[PixX,PixY]);

end

