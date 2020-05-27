# Finding weibull parameters in a for components of a system with survival analysis in R

**1. Il dataset**

l'analisi riguarda un dataset (WeibullDataSet.csv nella cartella) contenente rapporti di guasto di un piccolo sistema composto da una parte elettronica e una parte meccanica. La rottura di una soltanto di esse causa già il guasto del sistema nel complesso, quindi non è possibile indagare sulle ragioni del guasto ex post. Bisognerà analizzare i dati e capire quanto incide sull'affidabilità del sistema (R, come reliability, del sistema) la parte meccanica e quanto incide la parte elettronica. 

<a href="https://www.codecogs.com/eqnedit.php?latex=\large&space;R_{sistema}(t)=R_{elettronico}(t)*R_{meccanico}(t)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\large&space;R_{sistema}(t)=R_{elettronico}(t)*R_{meccanico}(t)" title="\large R_{sistema}(t)=R_{elettronico}(t)*R_{meccanico}(t)" /></a>

La modalità di guasto del sistema in oggetto non consente un'analisi approfondita sulle singole modalità di guasto dei componenti che lo compongono: per risalire ai parametri affidabilistici del sistema, occorre andare a ritroso dalla densità di guasto ottenuta da 10.000 test. 

![Guasti](https://github.com/pierluigirossi86/weibull/blob/master/Guasti%20al%20tempo%20t.png)

Per definizione da dati storici, si conosce che sia la parte meccanica che la parte elettronica del sistema seguono la distribuzione di Weibull, la cui densità di probabilità è definita come segue: 

<a href="https://www.codecogs.com/eqnedit.php?latex=\LARGE&space;f(t)=\frac{\beta}{\alpha}(\frac{t}{\alpha})^{(\beta-1)}\exp{(-((t)/\alpha)^{\beta})}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\LARGE&space;f(t)=\frac{\beta}{\alpha}(\frac{t}{\alpha})^{(\beta-1)}\exp{(-((t)/\alpha)^{\beta})}" title="\LARGE f(t)=\frac{\beta}{\alpha}(\frac{t}{\alpha})^{(\beta-1)}\exp{(-((t)/\alpha)^{\beta})}" /></a>

Nella distribuzione di Weibull il parametro alfa corrisponde al fattore di scala, ed è strettamente legato alla vita caratteristica del componente. Il parametro beta è invece definito fattore di forma. L'affidabilità dei componenti è data da:

<a href="https://www.codecogs.com/eqnedit.php?latex=\LARGE&space;f(t)=\exp{(-((t)/\alpha)^{\beta})}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\LARGE&space;R(t)=\exp{(-((t)/\alpha)^{\beta})}" title="\LARGE f(t)=\exp{(-((t)/\alpha)^{\beta})}" /></a>

Componenti elettronici: assumono qualunque valore positivo di alfa, mentre beta assume valori compresi tra 0 e 1. 

<a href="https://www.codecogs.com/eqnedit.php?latex=\large&space;\forall&space;\alpha_{el}&space;\in&space;\mathbb{R^{&plus;}},&space;0<&space;\beta_{el}&space;<&space;1" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\large&space;\forall&space;\alpha_{el}&space;\in&space;\mathbb{R^{&plus;}},&space;0<&space;\beta_{el}&space;<&space;1" title="\large \forall \alpha_{el} \in \mathbb{R^{+}}, 0< \beta_{el} < 1" /></a>

Componenti meccanici: assumono qualunque valore positivo di alfa, mentre beta è maggiore di 1. Se beta è uguale ad 1, la distribuzione si trasformerebbe in una distribuzione esponenziale a tasso di guasto costante (t/alfa). 

<a href="https://www.codecogs.com/eqnedit.php?latex=\large&space;\forall&space;\alpha_{mec}&space;\in&space;\mathbb{R^{&plus;}},&space;\beta_{mec}&space;>&space;1" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\large&space;\forall&space;\alpha_{mec}&space;\in&space;\mathbb{R^{&plus;}},&space;\beta_{mec}&space;>&space;1" title="\large \forall \alpha_{mec} \in \mathbb{R^{+}}, \beta_{mec} > 1" /></a>

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

**4. Sviluppi successivi**

Il progetto era stato inizialmente pensato per simulare con il metodo di Montecarlo tutti e 4 i parametri (alfa e beta componente elettronico, alfa e beta componente meccanico). La necessità di effettuare numerose iterazioni con test per ognuno dei 365 tempi T superiori a 1000 comportava tuttavia un tempo di analisi troppo elevato. Nel caso in esame ci si limita a simulare soltanto alfa e beta del componente meccanico del sistema per due iterazioni. 
