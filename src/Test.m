
n=1
for i = 1:9096
    if (t(i,2)<=40 && t(i,3)<=40 && t(i,3)>=0)
        arr(n,:) = [t(i,2), t(i,3)];
        n=n+1;
    end
end
