# Inlämningsuppgift 2 – Rapport (Mall)

**Kurs:** [Kursnamn]  
**Namn:** [Ditt namn]  
**GitHub-repo:** https://github.com/[user]/[repo]

---

## 1. Översikt
- Syfte: Skapa en enkel webapp, paketera som Docker image, ladda upp till Docker Hub och köra i Azure (Container Host).
- Valda plattformar: Azure, GitHub, Docker Hub.
- Arkitektur i korthet: Klient → Azure Web App (Container) → Docker Hub (pullar bilden).

## 2. Förutsättningar
- Konton: Azure, GitHub, Docker Hub.
- Verktyg: Docker Desktop, Git, Azure CLI.
- Repo-struktur (skärmdump på repo, ej kod som bild).

## 3. Implementationssteg (med verifiering)
### 3.1 Skapa webapp
- Kod i `app/` (Express).  
- Verifiera lokalt: `docker build ...`, `docker run -p 8080:8080 ...`, öppna `http://localhost:8080` (skärmbild).

### 3.2 Container-image
- `Dockerfile` (icke-root, HEALTHCHECK).  
- `docker build -t username/mov2:1.0.0 .`  
- Verifiera: `docker run ...`, `curl http://localhost:8080/healthz` → `ok`.

### 3.3 Docker Hub
- Skapa repo på Docker Hub.  
- `docker push username/mov2:1.0.0`  
- Verifiera: Bild syns publikt (skärmbild).

### 3.4 Azure (Container Host)
- Azure Web App for Containers.  
- Skapa resursgrupp, App Service plan och Web App (`scripts/azure-create-webapp.sh`).  
- Ställ in container-image från Docker Hub.  
- Verifiera: `https://<ditt-appnamn>.azurewebsites.net` svarar (skärmbild).

### 3.5 CI/CD (valfritt men rekommenderas)
- GitHub Actions workflow `.github/workflows/dockerhub-azure.yml`.
- Vid push till `main`: build+push till Docker Hub.
- Verifiera i Actions-loggarna (skärmbild).

## 4. IaC
- `infra/azure-webapp.bicep` beskriver App Service plan + Web App (container).  
- Kör: `az deployment group create ...`  
- Verifiera: Resurser skapade (skärmbild i Azure Portal).

## 5. Säkerhet
- Icke-root user, minimal basimage, .dockerignore, HEALTHCHECK.  
- Secrets i GitHub/Azure, inga i repo.  
- Tagga bilder med versionsnummer (ej bara `latest`).  
- (Extra) Sårbarhetsskanning: Docker Hub / Trivy (skärmbild om använt).

## 6. Slutsats
- Kort reflektion: vad gick bra, vad kan förbättras, nästa steg.
