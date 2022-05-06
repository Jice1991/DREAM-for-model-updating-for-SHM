% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
function K=shear_KAssembly(K,k,j) 
for i=1:j
    for ii=1:j
    if i==ii
        K(i,ii)=k(i)+k(i+1);
    end
    if i==ii+1
        K(i,ii)=-k(i);
    end
    if ii==i+1
        K(i,ii)=-k(ii);
    end
    end
end
K=K;
        


