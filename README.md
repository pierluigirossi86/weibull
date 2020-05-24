# Finding weibull parameters in a for components of a system with survival analysis in R

l'analisi riguarda un dataset contenente rapporti di guasto di un piccolo sistema composto da una parte elettronica e una parte meccanica. La rottura di una soltanto di esse causa già il guasto del sistema nel complesso. 

La modalità di guasto del sistema in oggetto non consente un'analisi approfondita sulle singole modalità di guasto dei componenti che lo compongono: per risalire ai parametri affidabilistici del sistema, occorre andare a ritroso dalla densità di guasto ottenuta da 10.000 test. 

Per definizione da dati storici, si conosce che sia la parte meccanica che la parte elettronica del sistema seguono la distribuzione di Weibull: 

<img src="https://latex.codecogs.com/gif.latex?\(f(x)=\frac{\beta}{\alpha}(\frac{x}{\alpha})^{(\beta-1)}\exp{(-((x)/\alpha)^{\beta})}" /> 


 
