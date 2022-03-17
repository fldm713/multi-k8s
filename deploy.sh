docker build -t fldm713/multi-client:latest -t fldm7/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fldm713/multi-server:latest -t fldm7/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fldm713/multi-worker:latest -t fldm7/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push fldm713/multi-client:latest
docker push fldm713/multi-server:latest
docker push fldm713/multi-worker:latest

docker push fldm713/multi-client:$SHA
docker push fldm713/multi-server:$SHA
docker push fldm713/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=fldm713/multi-client:$SHA
kubectl set image deployments/server-deployment server=fldm713/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=fldm713/multi-worker:$SHA