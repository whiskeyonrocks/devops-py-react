from flask import Flask, render_template, send_from_directory
import os

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html', message='Welcome to Flask Web App!')

# Serve Vite-generated static files
@app.route('/<path:filename>')
def vite_static_files(filename):
    return send_from_directory(os.path.join(app.root_path, 'templates'), filename)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
