from flask import Flask, request, jsonify
import pickle
import numpy as np

app = Flask(__name__)

file_path = "C:\\Users\\Ahmed Ali\\Desktop\\python\\model.pkl"
with open(file_path, 'rb') as file:
    model = pickle.load(file)


@app.route('/')
def home():
    return "Welcome to the ML Prediction API!"


@app.route('/predict', methods=['POST'])
def predict():
    data = request.json 
    features = data['features']  

    features = np.array(features).reshape(1, -1)

    prediction = model.predict(features)

    return jsonify({'prediction': prediction.tolist()})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)