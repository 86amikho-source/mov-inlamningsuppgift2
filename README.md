# MOV Inlämningsuppgift 2 – Startprojekt

Den här mallen uppfyller uppgiften: enkel webapp → Docker image → Docker Hub → kör i Azure.

## Snabbstart lokalt
```bash
docker build -t mov2:local .
docker run -p 8080:8080 -e APP_NAME="MOV Demo" mov2:local
# Öppna http://localhost:8080
```

## Skicka till Docker Hub
```bash
docker login
docker build -t YOUR_DOCKERHUB_USERNAME/mov2:1.0.0 .
docker push YOUR_DOCKERHUB_USERNAME/mov2:1.0.0
```

## Kör i Azure (Web App for Containers)
Se `scripts/azure-create-webapp.sh` för att skapa resurser och peka på din Docker Hub-bild.

## CI/CD med GitHub Actions
Workflow finns i `.github/workflows/dockerhub-azure.yml` (bygger & pushar till Docker Hub vid push till main).

## Säkerhet (kort)
- Icke-root user i container
- Alpine-bild (liten attackyta)
- HEALTHCHECK
- .dockerignore för att minska byggets yta
- Hantera secrets i GitHub/Actions & Azure (inga hemligheter i repo)
