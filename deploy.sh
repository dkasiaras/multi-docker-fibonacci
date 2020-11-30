docker build -t kasiarakos/multi-client:latest -t kasiarakos/multi-client:$GIT_SHA -f kasiarakos/multi-client ./client/Dockerfile ./client
docker build -t kasiarakos/multi-server:latest -t kasiarakos/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t kasiarakos/multi-worker -t kasiarakos/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push kasiarakos/multi-client:latest
docker push kasiarakos/multi-server:latest
docker push kasiarakos/multi-worker:latest

docker push kasiarakos/multi-client:$GIT_SHA
docker push kasiarakos/multi-server:$GIT_SHA
docker push kasiarakos/multi-worker:$GIT_SHA


kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=kasiarakos/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=kasiarakos/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=kasiarakos/multi-worker:$GIT_SHA