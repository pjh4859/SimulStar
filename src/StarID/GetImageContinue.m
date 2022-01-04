function GetImageContinue(timer,~,app)
%GETIMAGECONTINUE
%   이미지 연속적 생성
% TCP/IP 클라이언트가 열려있고, 받을 수 있는 데이터가 0보다 크면 실행.
    if isa(app.client,'tcpclient') == 1 && app.client.NumBytesAvailable > 0

        [app.StarMat, app.pixX, app.pixY, app.FoVx, app.FoVy,app.ThresholdMag] = TCPIPReadData(app.client);

        % 통신을 통해 들어온 픽셀수 FOV 값을 main에 넘기기 위해 스트럭쳐에집어넣음.
        app.Params.pixX = app.pixX;
        app.Params.pixY = app.pixY;
        app.Params.FoVx = app.FoVx;
        app.Params.FoVy = app.FoVy;
        app.Params.ThresholdMag = app.ThresholdMag;

        I = imshow(app.StarMat, 'parent', app.UIAxes);
        app.UIAxes.XLim = [0 I.XData(2)];
        app.UIAxes.YLim = [0 I.YData(2)];
        
        [SvectorFlag, PyFlag,Attitude] = main_StarID(app.StarMat, app.Threshold, app.UIAxes, app.Params);
        if PyFlag
            app.TextArea.Value = ShowCurrentStatus(Attitude);
            app.StarIDLamp.Color = [0 1 0];
            app.TextArea.FontColor = [1 0 0];
        else
            app.StarIDLamp.Color = [1 0 0];            
            app.TextArea.FontColor = [0 0 0];
        end
    end
end

