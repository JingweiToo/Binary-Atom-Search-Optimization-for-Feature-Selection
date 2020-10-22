function [sFeat,Sf,Nf,curve]=jBASO(feat,label,N,T,alpha,beta,HO)

fun=@jFitnessFunction; 
D=size(feat,2); 
X=jInitialPopulation(N,D); V=zeros(N,D); Vmax=6;
for i=1:N
  for d=1:D
    V(i,d)=-Vmax+(Vmax-(-Vmax))*rand();
  end
end
A=zeros(N,D); curve=inf; t=1; fit=zeros(1,N); fitG=inf; 
%---Iteration start-------------------------------------------------------
while t <= T
  for i=1:N
    fit(i)=fun(feat,label,X(i,:),HO);
    if fit(i) < fitG
      fitG=fit(i); Xgb=X(i,:);
    end
  end
  fitB=min(fit); fitW=max(fit); 
  Kbest=ceil(N-(N-2)*sqrt(t/T));   
  M=exp(-(fit-fitB)./(fitW-fitB));
  M=M./sum(M);
  [~,idxM]=sort(M,'descend');
  G=exp(-20*t/T); E=zeros(N,D); 
  for i=1:N      
    XK(1,:)=sum(X(idxM(1:Kbest),:),1)/Kbest;
    dist=norm(X(i,:)-XK(1,:),2);   
    for ii=1:Kbest
      j=idxM(ii);
      Po=jLJPotential(X(i,:),X(j,:),t,T,dist);
      dist2=norm(X(i,:)-X(j,:),2);
      for d=1:D
        E(i,d)=E(i,d)+rand()*Po*((X(j,d)-X(i,d))/(dist2+eps));
      end
    end
    for d=1:D
      E(i,d)=alpha*E(i,d)+beta*(Xgb(d)-X(i,d));
      A(i,d)=E(i,d)/M(i); 
    end
  end
  for i=1:N
    for d=1:D
      Acce=A(i,d)*G;
      VB=rand()*V(i,d)+Acce;
      VB(VB > Vmax)=Vmax; VB(VB < -Vmax)=-Vmax; V(i,d)=VB;
      S=1/(1+exp(-2*V(i,d)));
      K1=(1/3)*rand(); K2=(1/3)+(1/3)*rand();
      if S <= K1
        X(i,d)=0;
      elseif S > K1 && S <= K2
        X(i,d)=1;
      else
        X(i,d)=Xgb(d); 
      end
    end
  end
  curve(t)=fitG; 
  fprintf('\nIteration %d Best (BASO)= %f',t,curve(t)) 
  t=t+1;
end
Pos=1:D; Sf=Pos(Xgb==1); Nf=length(Sf); sFeat=feat(:,Sf); 
end


function Potential=jLJPotential(X1,X2,t,T,D)
h0=1.1; u=1.24; 
r=norm(X1-X2,2);
n=(1-(t-1)/T).^3;
g=0.1*sin((pi/2)*(t/T));
Hmin=h0+g; Hmax=u;
if r/D < Hmin
  H=Hmin;
elseif r/D > Hmax
  H=Hmax;  
else
  H=r/D;
end           
Potential=n*(12*(-H)^(-13)-6*(-H)^(-7)); 
end