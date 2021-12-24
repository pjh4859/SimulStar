function [StarMat,PixX,PixY,FoVx,FoVy,ThresholdMag] = TCPIPReadData(client)
%TCPIPGETDATA 
%   TCP/IP 클라이언트를 통해 이미지 매트릭스를 받고, 다시 원래 배열로 복구
% while (client.NumBytesAvailable > 0)
if (client.NumBytesAvailable > 0)
    temp = read(client,2,"uint16");
    PixX = temp(1);
    PixY = temp(2);
    temp2 = read(client,2,'uint8');
    FoVx = temp2(1);
    FoVy = temp2(2);
    temp3 = read(client,1,'single');
    ThresholdMag = temp3(1);
    tempStarMat = read(client,cast(PixX,'uint32')*cast(PixY,'uint32'),"uint8");
% end
end
StarMat = reshape(tempStarMat,[PixY,PixX]);
% flush(client);
end

    