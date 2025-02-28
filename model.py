import pickle
import numpy as np

file_path =  "C:\\Users\\Ahmed Ali\\Desktop\\python\\model.pkl"
with open(file_path, 'rb') as file:
    model = pickle.load(file)


sample_features = [0, 1, 0, 1, 1]  

sample_features = np.array(sample_features).reshape(1, -1)

prediction = model.predict(sample_features)

print(f'Prediction: {prediction}')
