git clone https://github.com/Piankov-Michail/Flowise_for_GraphRAG.git
git clone https://github.com/Piankov-Michail/cognee_for_GraphRAG.git

cd cognee_for_GraphRAG/
cp .env.template .env

docker compose --profile postgres --profile neo4j --profile mcp up -d

cd ../Flowise_for_GraphRAG/docker/
cp .env.example .env

docker compose up -d

cd ../..

docker run -d --name pgadmin_container -p 5050:80 -e PGADMIN_DEFAULT_EMAIL=user@example.com -e PGADMIN_DEFAULT_PASSWORD=your_secure_password --network cognee-network dpage/pgadmin4

docker run -d --network=cognee-network -v ollama:/root/.ollama --name ollama ollama/ollama
docker exec -it -d ollama ollama run qwen3-next:80b-cloud
docker exec -it -d ollama ollama run mxbai-embed-large
