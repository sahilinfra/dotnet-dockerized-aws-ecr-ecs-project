# .NET Admin Portal — DevOps portfolio (generic)

Public-safe sample: **Docker**, **Docker Compose**, **GitHub Actions**, and **AWS ECR → ECS**.

Application source is stubbed. AWS account `123456789012` in `infra/ecs/` is a placeholder.

## Layout

- `WebApi/` — ASP.NET Core API Dockerfiles + minimal stub (`WebApi.csproj` → `WebApi.dll`)
- `WebApi.CronJob/` — background worker Dockerfile + stub (`WebApi.CronJob.dll`)
- `WebApi/ClientApp/` — frontend Dockerfiles + stub `package.json`
- `docker-compose*.yml` — compose service **`webapi`** (image `webapi_be`), **`clients`** (`webapi_fe`), **`cronjob`** (`webapi_cronjob`)
- `.github/workflows/` — build service `webapi` or `clients`, tag `webapi_be` / `webapi_fe`
- `infra/ecs/` — sample ECS task definitions

## Local build

```bash
docker compose -f docker-compose.dev.yml up --build
```