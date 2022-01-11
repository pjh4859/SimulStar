
N = 1001;
Num = [1:N-1];
Rot = zeros(N-1,1);
L = sqrt(N*pi);
for i=1:N-1
    z(i) = 1-(2*i+1)/N;
    phi(i) = acos(z(i));
    theta(i) = L*phi(i);
    x(i) = sin(phi(i))*cos(theta(i));
    y(i) = sin(phi(i))*sin(theta(i));
    [azimuth(i),elevation(i),r(i)] = cart2sph(x(i),y(i),z(i));
    azimuth(i) = azimuth(i)*180/pi;
    elevation(i) = elevation(i)*180/pi;    
end
M = [Num', x', y', z'];
M2 = [Num', azimuth', elevation', Rot]; 


filepath = '../TrackingFile/';
filepath1 = strcat(filepath, 'TrackingFile2.txt');
filepath2 = strcat(filepath, 'TrackingFile3.txt');
writematrix(M,filepath1,'Delimiter','tab');
writematrix(M2,filepath2,'Delimiter','tab');
