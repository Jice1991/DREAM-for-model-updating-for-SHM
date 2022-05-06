function modelout=remodel(modelin)
%normalization
[i,j,k]=size(modelin);
for kk=1:k
    for jj=1:j
        max1=max(abs(modelin(:,jj,kk)));
        modelin(:,jj,kk)= modelin(:,jj,kk)./max1;
        if min(modelin(:,jj,kk))==-1
            modelin(:,jj,kk)=-modelin(:,jj,kk);
        end
    end
end
modelout=modelin;