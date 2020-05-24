#estrazione dal dataset di affidabilita dei primi valori (t tra 1 e 15 giorni) 
#in quanto i maggiormente dipendenti dal componente elettronico

weibull <-data.frame("t"=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15), "reliability"=c(0.9736, 0.9509, 0.93, 0.9103, 0.8917, 0.874, 0.857, 0.8406, 0.8248, 0.8095, 0.7946, 0.7801, 0.766, 0.7522, 0.7388), "alfacalc"=0, "betacalc"=0);
#linearizzare la funzione weibull esponenziale Reliability = exp(-(t/alfa)^beta), quindi Ln(Reliability)=-(t/alfa)^beta
logar <-log(weibull$reliability)
#ciclo di verifica tra valori contigui (t, t+1)
#se ln(R(t1))=-(t1/alfa)^beta, e Ln(R(t2))=-(t2/alfa)^beta, allora:
#-Ln(R(t1))=(t1/alfa)^beta
#t1/alfa = (-Ln(R(t1)))^(1/beta)
#alfa = ((-Ln(R(t1)))^(1/beta)/t1)^-1
x<-1;
while(x<length(weibull[,1]))
{
  t1<-weibull[x,1];
  t2<-weibull[x+1,1];
  p1<-logar[x];
  p2<-logar[x+1];
  betacalc<-log((p1/p2),base=t1/t2);
  weibull[x,4]<-betacalc;
  alfacalc<-(((-logar[x])^(1/betacalc))/x)^(-1);
  weibull[x,3]<-alfacalc;
  x <- x+1;
  }
#limitare ai primi 14 valori in quanto l'ultimo non avrebbe un n+1 valore con cui essere confrontato
listalfa<-weibull$alfacalc[1:14]
listabeta<-weibull$betacalc[1:14]
#relazione sul risultato ottenuto
summary(listalfa)
summary(listabeta)