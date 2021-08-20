# alnews
lettore news alternativo che elimina in automatico tutte le notizie inerenti il covid
Per la compilazione del sorgente necessita di questi componenti open source 
wke4delphi:  https://gitee.com/LangjiApp/Wke4Delphi (browser web miniblink derivante da chromium ma ridotto ed ottimizzato)
dll necessarie per l'eseguibile win32 o win64 disponibile ai seguenti link https://weolar.github.io/miniblink/ - https://github.com/weolar/miniblink49/releases

L'applicazione in forma binaria e disponibile solo per sistemi windows a 64bit

Perchè il componente wke4delphi?
Rad studio come visual studio utilizza come browser standard ancora internet explorer, browser non adatto, microsoft ha rilasciato librerie per edge derivate da chrome ma tutt'ora allo stadio beta per cui funziona solo se hai installato edge canary opzione non praticabile avere 2 browser edge sullo stesso sistema per utilizzare quest'applicazione. L'alternativa era tra cef4 (chromium per delphi) ma le dll e librerie superavano i 100 mb solo per far funzionare un eseguibile e miniblink la versione ridotta di chromium e sempre open source.
