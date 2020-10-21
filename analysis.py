import pandas as pd 
import numpy as np 

url = 'https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale.json'
df = pd.read_json(url)
df['data'] = pd.to_datetime(df['data'])
data_offset = df['data'].iloc[0]
print('#days from {} - positives - sqrt(positives) [assuming the infection process is poissonian'.format(data_offset))
for time,positives,tests in zip(df['data'],df['totale_positivi'],df['tamponi']):
    print('{} {} {} {} {}'.format((time-data_offset).days,positives,np.sqrt(positives),tests,np.sqrt(tests)))