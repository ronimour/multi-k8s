docker build -t ronnymoura/multi-client -t ronnymoura/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ronnymoura/multi-server -t ronnymoura/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ronnymoura/multi-worker -t ronnymoura/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ronnymoura/multi-client:latest
docker push ronnymoura/multi-server:latest
docker push ronnymoura/multi-worker:latest

docker push ronnymoura/multi-client:$SHA
docker push ronnymoura/multi-server:$SHA
docker push ronnymoura/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment clientr=ronnymoura/multi-client:$SHA
kubectl set image deployments/server-deployment server=ronnymoura/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ronnymoura/multi-worker:$SHA
