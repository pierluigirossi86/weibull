# Finding weibull parameters in a for components of a system with survival analysis in R

**1. Il dataset**

l'analisi riguarda un dataset (WeibullDataSet.csv nella cartella) contenente rapporti di guasto di un piccolo sistema composto da una parte elettronica e una parte meccanica. La rottura di una soltanto di esse causa già il guasto del sistema nel complesso. 

<a href="https://www.codecogs.com/eqnedit.php?latex=\large&space;R_{sistema}(t)=R_{elettronico}(t)*R_{meccanico}(t)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\large&space;R_{sistema}(t)=R_{elettronico}(t)*R_{meccanico}(t)" title="\large R_{sistema}(t)=R_{elettronico}(t)*R_{meccanico}(t)" /></a>

La modalità di guasto del sistema in oggetto non consente un'analisi approfondita sulle singole modalità di guasto dei componenti che lo compongono: per risalire ai parametri affidabilistici del sistema, occorre andare a ritroso dalla densità di guasto ottenuta da 10.000 test. 

![Guasti](https://github.com/pierluigirossi86/weibull/blob/master/Guasti%20al%20tempo%20t.png)

Per definizione da dati storici, si conosce che sia la parte meccanica che la parte elettronica del sistema seguono la distribuzione di Weibull: 

<a href="https://www.codecogs.com/eqnedit.php?latex=\LARGE&space;f(t)=\frac{\beta}{\alpha}(\frac{t}{\alpha})^{(\beta-1)}\exp{(-((t)/\alpha)^{\beta})}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\LARGE&space;f(t)=\frac{\beta}{\alpha}(\frac{t}{\alpha})^{(\beta-1)}\exp{(-((t)/\alpha)^{\beta})}" title="\LARGE f(t)=\frac{\beta}{\alpha}(\frac{t}{\alpha})^{(\beta-1)}\exp{(-((t)/\alpha)^{\beta})}" /></a>

L'affidabilità dei componenti è data da:

<a href="https://www.codecogs.com/eqnedit.php?latex=\LARGE&space;f(t)=\exp{(-((t)/\alpha)^{\beta})}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\LARGE&space;R(t)=\exp{(-((t)/\alpha)^{\beta})}" title="\LARGE f(t)=\exp{(-((t)/\alpha)^{\beta})}" /></a>

I valori di beta sono minori di 1 per i componenti elettronici, maggiori di 1 per i componenti meccanici. Se uguale ad 1, la distribuzione diventa una distribuzione esponenziale a tasso di guasto costante (t/alfa). 
Per valori di alfa=t invece l'affidabilità assume sempre valore di exp(-1), ossia 0.3687. 
Il tasso di guasto segue la seguente formula:

<a href="https://www.codecogs.com/eqnedit.php?latex=\LARGE&space;\lambda(t)=\frac{\beta}{\alpha}(\frac{t}{\alpha})^{(\beta-1)}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\LARGE&space;\lambda(t)=\frac{\beta}{\alpha}(\frac{t}{\alpha})^{(\beta-1)}" title="\LARGE f(t)=\frac{\beta}{\alpha}(\frac{t}{\alpha})^{(\beta-1)}" /></a>

Densità, tasso e affidabilità sono legati dalla seguente relazione: 

<a href="https://www.codecogs.com/eqnedit.php?latex=\large&space;f(t)=\lambda(t)*R(t)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\large&space;f(t)=\lambda(t)*R(t)" title="\large f(t)=\lambda(t)*R(t)" /></a>

l'inaffidabilità corrisponde all'integrale della densità al tempo t-esimo: 

<a href="https://www.codecogs.com/eqnedit.php?latex=\large&space;F(t)=\int&space;f(t)dt" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\large&space;F(t)=\int&space;f(t)dt" title="\large F(t)=\int f(t)dt" /></a>

Il tasso di guasto di un componente elettronico è maggiore per tempi bassi e scende col tempo (mortalità infantile). 
Il tasso di guasto di un componente meccanico è minore per tempi bassi e sale col tempo (invecchiamento).

**2. Individuare il tasso di guasto del componente elettronico nel sistema**

Il componente elettronico, data l'elevata affidabilità della parte meccanica nei primi tempi t, sarà l'unico responsabile dei guasti registrati nel sistema. Con un primo script l'obiettivo sarà quindi quello di individuare un valore ottimale di alfa e beta per il componente elettronico, operando per formule inverse mettendo a sistema due valori di affidabilità in due tempi t e t+1. Verrà utilizzato il dataset chiamato "Weibull Electronic Data", in formato csv. 

**3. Individuare il tasso di guasto del componente meccanico nel sistema con il metodo di Montecarlo**

Una volta individuato alfa e beta per il componente elettronico, con un nuovo script verranno individuati i valori di alfa e beta per il componente meccanico attraverso il metodo di Montecarlo. Dopo diverse iterazioni si arriva ad un risultato accettabile con un basso grado di incertezza. 

![Risultato](https://github.com/pierluigirossi86/weibull/blob/master/Plot%20PNG%20fit%20dati.png)

