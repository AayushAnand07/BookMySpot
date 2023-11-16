
import sys
import os

# Get the directory containing deploy.py
dir_path = os.path.abspath('../numberplaterecognition')

# Add the directory to the Python path
sys.path.append(dir_path)

from flask import Flask, jsonify, request

app = Flask(__name__)

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

def allowed_file(filename):
    return '.' in filename and \
        filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/detect', methods=['POST'])
def detect_objects():
    # check if a file was uploaded
    if 'file' not in request.files:
        return jsonify({'error': 'No file uploaded'})

    file = request.files['file']

    # check if the file is a valid image
    if file.filename == '':
        return jsonify({'error': 'No file selected'})

    if not allowed_file(file.filename):
        return jsonify({'error': 'Invalid file type'})

    # perform object detection on the uploaded image
    #result =main(img_path=file)

    # return the detection results as a JSON object
    #return jsonify(result)

@app.route('/', methods=['GET'])
def Response():
 return jsonify("HELLO WORLD")

if __name__ == '__main__':
    app.run(debug=True)