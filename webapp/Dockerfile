# Use a Node.js base image for building the React app
FROM node AS builder

# Set the working directory
WORKDIR /app

# Copy the rest of the application files
COPY templates .

# Install dependencies
RUN npm install

# Build the React app
RUN npm run build

# CMD ["/bin/bash"]

# the above has the created the build in /app/dist

# Use a Python base image for serving the app with Flask
FROM python:3

# Set the working directory inside the container
WORKDIR /app

# Copy the built React app from the builder stage
COPY --from=builder /app/dist /app/templates

# Copy app.py specifically
COPY app.py /app

# Install Flask and Redis libraries
RUN pip install Flask redis

# Set an environment variable called "FLASK_APP" to the name of application file
ENV FLASK_APP=app.py

# Expose port 5000 for the web service
EXPOSE 80

# CMD ["/bin/bash"]

# Define a command that starts the Flask application server
CMD ["flask", "run", "--host=0.0.0.0", "--port=80"]
