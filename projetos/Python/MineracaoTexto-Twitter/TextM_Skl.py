##------------------------------------------------------------------------
## Autor: Prof. Roberto Angelo  (coding: utf-8 )
## Objetivo: Conceitos de Text Mining com Machine Learning
##------------------------------------------------------------------------

# Bibliotecas padrão  e carga de dados
import pandas as pd
dataset = pd.read_csv('Amazon_Reviews_1000.txt', sep=';') 

#------------------------------------------------------------------------------------------
# Processamento do Texto
# https://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.CountVectorizer.html
#------------------------------------------------------------------------------------------
from sklearn.feature_extraction.text import CountVectorizer
from nltk.tokenize import RegexpTokenizer
token = RegexpTokenizer(r'[a-zA-Z0-9]+') # Expressão regular para remover simbolos
cv = CountVectorizer(   analyzer='word',lowercase=True, stop_words='english',min_df=1,
                        ngram_range = (1,1), tokenizer = token.tokenize)
text_counts = cv.fit_transform(dataset['Text'])
# print(cv.vocabulary_)

##------------------------------------------------------------
## Separa os dados em treinamento e teste
##------------------------------------------------------------
y = dataset['Sentiment']   # Carrega alvo 
X = text_counts            # Carrega as colunas geradas
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=1)

#---------------------------------------------------------------------------
## Ajusta modelo Naive Bayes com treinamento - Aprendizado supervisionado  
#---------------------------------------------------------------------------
from sklearn.naive_bayes import MultinomialNB
NaiveB = MultinomialNB()
NaiveB.fit(X_train, y_train)

#---------------------------------------------------------------------------
## Previsão usando os dados de teste
#---------------------------------------------------------------------------
# Naive Bayes
y_pred_test_NaiveB= NaiveB.predict(X_test)

#---------------------------------------------------------------------------
## Cálcula da Acurácia do Naive Bayes
#---------------------------------------------------------------------------
from sklearn import metrics
print()
print('----------------------------------------------------------')
print('Acurácia NaiveBayes:',metrics.accuracy_score(y_test, y_pred_test_NaiveB))
print('----------------------------------------------------------')