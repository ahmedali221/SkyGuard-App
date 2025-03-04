from flask import Flask, request, jsonify
import pickle
import numpy as np

app = Flask(__name__)

<<<<<<< HEAD
file_path = "C:\\Users\\Ahmed Ali\\Desktop\\python\\model.pkl"
=======
# Load the model
file_path = "model.pkl"  # Path to the model file
>>>>>>> origin/main
with open(file_path, 'rb') as file:
    model = pickle.load(file)


<<<<<<< HEAD
=======
# Define a route for the home page
>>>>>>> origin/main
@app.route('/')
def home():
    return "Welcome to the ML Prediction API!"


<<<<<<< HEAD
@app.route('/predict', methods=['POST'])
def predict():
    data = request.json 
    features = data['features']  

    features = np.array(features).reshape(1, -1)

    prediction = model.predict(features)

=======
# Define the prediction route
@app.route('/predict', methods=['POST'])
def predict():
    data = request.json  # Get the JSON data from the request
    features = data['features']  # Extract the features

    # Convert to 2D array (since the model expects 2D input)
    features = np.array(features).reshape(1, -1)

    # Make the prediction
    prediction = model.predict(features)

    # Return the prediction as JSON
>>>>>>> origin/main
    return jsonify({'prediction': prediction.tolist()})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)