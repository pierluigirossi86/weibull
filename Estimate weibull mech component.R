#import dataset

WeibullStats <- read.csv("C:/Users/Pigiasus/Desktop/WeibullStats.csv")

#generazione data frame dei dati importati tramite file csv
affidab <-data.frame("t"=WeibullStats[1],"guasti"=WeibullStats[2],"F(t)"=WeibullStats[3],"R(t)"=WeibullStats[4]);

#generazione data frame dati che verranno trovati dal metodo di Montecarlo
affmontecarlo<-data.frame();
datasetmontecarlo<-data.frame();
#inizio di un ciclo for per tutti i 365 valori di t nel dataframe
t <- 1;

for(j in affidab[,1])
{
  #selezionare il valore di affidabilita per il tempo t nel set di dati
  reliabDATA=affidab[t,4];
  print(j)
  #calcolo affidabilita parte nota del sistema, elettronica
  alfaEL<-58;
  betaEL<-0.86;
  reliabEL<-exp(-((t/alfaEL)^betaEL));
  
  #crezione di un dataframe temporaneo per i valori ottenuti per ciascun tempo t mediante metodo di Montecarlo
  dataiterazione<-data.frame();
  
  #metodo di Montecarlo con 1000 iterazioni per ogni tempo t
  for(i in c(1:1000))
  {
    alfamec <- runif(1, 68.7, 71.5); #generazione di un numero casuale che diventa valore di alfa
    betamec <- runif(1, 3.9, 4.8); #generazione di un numero casuale che diventa valore di beta
    reliabMEC <- exp(-1*((t/alfamec)^betamec)); #calcolo affidabilita parte meccanica del sistema con i valori generati
    relSIST <- reliabMEC*reliabEL; #affidabilita del sistema
    unreliabSIST<-1-relSIST; #inaffidabilita del sistema
    #if((abs(alfamec) != Inf) & (abs(betamec) != Inf)) {
    risultato<-data.frame(t, alfamec, betamec, reliabMEC, relSIST, unreliabSIST); #dataframe di risultato
    dataiterazione<-rbind.data.frame(dataiterazione,risultato);
    #}
  }
  
  #occorre limitare il dataset generato con Montecarlo in un range di valori credibili in base al dataset di prova
  limitazionerisultati <- subset(dataiterazione, relSIST>=0 & relSIST>(reliabDATA-0.01) & relSIST<(reliabDATA+0.01));
  datasetmontecarlo <-rbind.data.frame(datasetmontecarlo ,limitazionerisultati);
  minalfamec<-min(limitazionerisultati$alfamec);
  maxalfamec<-max(limitazionerisultati$alfamec);
  minbetamec<-min(limitazionerisultati$betamec);
  maxbetamec<-max(limitazionerisultati$betamec);  
  validparams<-data.frame(t,minalfamec,maxalfamec,minbetamec,maxbetamec);
  #limitati i risultati credibili, vengono salvati i valori individuati di alfa e beta per il componente meccanico
  affmontecarlo <- rbind.data.frame(affmontecarlo, validparams);
 
  #terminate le operazioni al tempo t, incremento t di una unita
  t<-(t+1);
}

#Calcolare il valore medio compreso tra gli estremi che soddisfano l'intero dataset
medialfa<-(max(affmontecarlo$minalfamec)+min(affmontecarlo$maxalfamec))/2;
mediabeta<-(max(affmontecarlo$minbetamec)+min(affmontecarlo$maxbetamec))/2;

#determinare il sottoinsieme, nell'intervallo di tempo maggiormente determinante, in base ai valori medi ottenuti
valorimigliori<-subset(datasetmontecarlo, t>60 & t<80 & alfamec>(medialfa-0.1) & alfamec<(medialfa+0.1) & betamec>(mediabeta-0.1) & betamec<(mediabeta+0.1))
summary(valorimigliori)
