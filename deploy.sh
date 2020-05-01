docker build -t dheerajreddy91/multi-client:latest -t dheerajreddy91/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dheerajreddy91/multi-server:latest -t dheerajreddy91/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t dheerajreddy91/multi-worker:latest -t dheerajreddy91/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push dheerajreddy91/multi-client:latest
docker push dheerajreddy91/multi-server:latest
docker push dheerajreddy91/multi-worker:latest

docker push dheerajreddy91/multi-client:$SHA
docker push dheerajreddy91/multi-server:$SHA
docker push dheerajreddy91/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dheerajreddy91/multi-server:$SHA
kubectl set image deployments/client-deployment client=dheerajreddy91/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dheerajreddy91/multi-worker:$SHA