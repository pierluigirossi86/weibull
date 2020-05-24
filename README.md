# Finding weibull parameters in a for components of a system with survival analysis in R

l'analisi riguarda un dataset contenente rapporti di guasto di un piccolo sistema composto da una parte elettronica e una parte meccanica. La rottura di una soltanto di esse causa già il guasto del sistema nel complesso. 

La modalità di guasto del sistema in oggetto non consente un'analisi approfondita sulle singole modalità di guasto dei componenti che lo compongono: per risalire ai parametri affidabilistici del sistema, occorre andare a ritroso dalla densità di guasto ottenuta da 10.000 test. 

Per definizione da dati storici, si conosce che sia la parte meccanica che la parte elettronica del sistema seguono la distribuzione di Weibull: 

<a href="https://www.codecogs.com/eqnedit.php?latex=\LARGE&space;f(x)=\frac{\beta}{\alpha}(\frac{x}{\alpha})^{(\beta-1)}\exp{(-((x)/\alpha)^{\beta})}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\LARGE&space;f(x)=\frac{\beta}{\alpha}(\frac{x}{\alpha})^{(\beta-1)}\exp{(-((x)/\alpha)^{\beta})}" title="\LARGE f(x)=\frac{\beta}{\alpha}(\frac{x}{\alpha})^{(\beta-1)}\exp{(-((x)/\alpha)^{\beta})}" /></a>

I valori di beta sono minori di 1 per i componenti elettronici, maggiori di 1 per i componenti meccanici. Se uguale ad 1, la distribuzione diventa una distribuzione esponenziale a tasso di guasto costante (t/alfa). 
 
