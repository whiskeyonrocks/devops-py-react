# React-Vite-Flask-Docker-Compose

This project is a full-stack web application template that combines React, Vite, Flask, and Docker Compose. It provides a development and deployment environment for building and serving a React frontend with Vite and a Flask backend within Docker containers. Additionally, it includes a Redis database service as a dependency.

## Prerequisites:
Install Docker and Docker Compose.
Keep the Docker running.

## Setup Steps:
Clone the Repository:
git clone [docker-react](https://github.com/whiskeyonrocks/docker-react) && cd docker-react

## Running the Application:

- To run the application, execute `docker-compose up --build` in the project root.
- Access the web application in your browser at [http://localhost:80](http://localhost:80).

## Stopping the Containers:

   To stop the running containers, use the following command:

   ```bash
   docker-compose down
   ```

This will stop and remove the containers, but it won't remove the built images.
To remove the images as well when stopping the containers, use the following command:
   ```bash
   docker-compose down --volumes --rmi all
   ```
For development purposes, you can use the --scale option to run multiple instances of the webapp service (useful for testing load balancing):
   ```bash
   docker-compose up --scale webapp=3
   ```

## OTHER INFO
### Folder Structure:
```
.
├── README.md
├── docker-compose.yml
├── docker-swarm
│   └── docker-stack.yml
├── docker-swarm-deployment.sh
├── kubernetes
│   └── webapp-deployment.yml
├── minikube-deployment.sh
├── terraform
│   └── main.tf
└── webapp
    ├── Dockerfile
    ├── app.py
    └── templates
        ├── README.md
        ├── index.html
        ├── package.json
        ├── public
        │   └── vite.svg
        ├── src
        │   ├── App.css
        │   ├── App.jsx
        │   ├── assets
        │   │   └── react.svg
        │   ├── index.css
        │   └── main.jsx
        └── vite.config.js
```
### Docker Configuration:

- **React App Build (Node as Builder):**
  - The Dockerfile in the `webapp` directory first builds the React app using Node.js as a builder. It sets up the working directory, installs dependencies, and runs the build command.

- **Flask App and Redis Service (Python as Base):**
  - The second part of the Dockerfile uses a Python base image to set up the Flask app. It copies the built React app from the previous stage into the `templates` directory.
  - Flask is installed, and the Redis database service is defined as a dependency. The environment variable `FLASK_APP` is set to `app.py`.

### Docker Compose:

- The `docker-compose.yml` file orchestrates the entire application. It defines two services: `webapp` (for the combined React and Flask app) and `redis` (for the Redis database).
- The `webapp` service is built from the Dockerfile in the `webapp` directory, exposing port 80 on the host. It depends on the `redis` service.

### Docker Swarm deployment

- **Local Deployment:**
  - RUN Below commands to build, push, init and run docker swarm.
  - chmod +x docker-swarm-deployment.sh
  - ./docker-swarm-deployment.sh 
  - To stop and remove deployment `docker stack rm webapp_stack`

### Kubernetes deployment



- **Local - Minikube:**


- **GKE - deployment**



## FULL CI/CD
- Assume we have a cloud connection.

### INFRASTRUCTURE --
- Terraform - to create the Kubernetes Cluster.

brew install terraform
gcloud config set project development-404800
gcloud services enable container.googleapis.com
gcloud container clusters create docker-react-k8s --num-nodes=1
gcloud components install gke-gcloud-auth-plugin
gcloud container clusters get-credentials docker-react-k8s
kubectl get nodes


gcloud container clusters delete docker-react-k8s


- **2 Stratergies**
  - use terraform to create dev, stage and prod cluster.
  - use single cluster but namespaces for dev, stage and prod.

<!-- TAKING THE STRATERGY 1 -->
#### CONTINOUS INTEGRATION

  - Develop, 
  - Run tests
  - Build the docker image.
  - Tag the docker image with build tag
  - Upload the docker image to container repo.
  - Update the respective values.yml file with tag.

#### CONTINOUS DEPLOYMENT
  - Run helm - to deploy (upgrade only when changes in values.yml)

