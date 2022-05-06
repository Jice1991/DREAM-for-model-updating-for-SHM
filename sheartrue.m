
%%
%shear building
clear;clc;
global H E L P B
Ns=20; % No. measurement
nn=2; % No. frequency
mm=2;% No. mode shape
npar=2; % no. story
H=0.6;E0=3.3e10;L=10;P=2500;B=0.4;

thetaE=ones(1,npar);mu=0.05;
for i=1:npar
thetaE(i)=1+0*i;
end

for i=1:npar
   true(:,i)=normrnd(thetaE(i),mu,Ns,1);
end
A=B*H; % area
I=B*H*H*H/12; % moment of inertial
LL=ones(1,npar);  
LL(:)=L/npar; % length of each story  

% stiffness  and mass matrix
K=zeros(npar,npar);
k=zeros(npar+1,1);
M=zeros(npar,npar);
for j=1:Ns
 for R=1:npar
    E=true(j,R)*E0;
    k(R)=shear_Stiffness(E,I,LL(R));
    K=shear_KAssembly(K,k,R);
    m=shear_Mass(P,A,LL(R));
    M=shear_MAssembly(M,m,R);
end

% find eigenvalue and eigenvector
[V,D]=eig(K,M);
F=diag(sqrt(D))./(2*pi);
% normalization
V1=[V(:,1)./V(1,1) V(:,2)./V(1,2) ];
freqtrue(:,j)=F(1:nn);
modeltrue1(:,:,j)=V1(:,1:mm);
end

modeltrue=remodel(modeltrue1);
s1=var(freqtrue',1);
for j=1:mm
    for i=1:Ns
        aa(:,i)=modeltrue(:,j,i);
    end
    mu=mean(aa')';
    mu=repmat(mu,1,Ns);
    kk=aa-mu;
    for i=1:Ns
        kkk(i)=(norm(kk(:,i)))^2;
    end
    s2(j)=sum(kkk)/Ns;
end
save freqtrue 
save modeltrue
save s1 
save s2
freqmu=mean(freqtrue,2);
for jj=1:nn
    subplot(4,3,jj)
    plot(1:Ns,freqtrue(jj,:)','-bo',[0,Ns],[freqmu(jj) freqmu(jj)],'r--','linewidth',2)
end  
legend('Measurement','Mean')

