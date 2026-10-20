# LoremIpsum

A layered .NET 10 web app template: minimal API, EF Core on PostgreSQL, a MudBlazor WebAssembly client, xUnit integration tests, Docker Compose and CI.

## Structure

| Project | Role |
| --- | --- |
| `src/LoremIpsum.Core` | Domain entities, repository interfaces, API contracts |
| `src/LoremIpsum.Infrastructure` | EF Core `AppDbContext`, migrations, repositories |
| `src/LoremIpsum.Api` | Minimal API (`/api/tasks`, `/health`, OpenAPI in Development) |
| `src/LoremIpsum.Web` | Blazor WebAssembly client (MudBlazor, light/dark) |
| `src/LoremIpsum.Api.Tests` | xUnit v3 tests using `WebApplicationFactory` and the EF in-memory provider |

Repo-wide conventions: `global.json` (SDK + Microsoft.Testing.Platform runner) lives at the root; `src/` holds `Directory.Build.props` (shared properties, analyzers, artifacts output),
`Directory.Packages.props` (central package versions) and
`.config/dotnet-tools.json` (`dotnet-ef`). Build output goes to `artifacts/`.

## Use as a template

```sh
dotnet new install .
dotnet new lorem-ipsum-webapp -n Acme.Shop
```

`LoremIpsum` is replaced everywhere with the name you pass. Lowercase `lorem-ipsum` (Docker names, database, volume) becomes a
dash-separated slug, for example `acme-shop`.

## Run

With Docker (Postgres, API and web):

```sh
./start.sh   # web on :5200, api on :5117
./stop.sh
```

Without Docker, start Postgres (`docker compose up -d lorem-ipsum-postgres`), then:

```sh
dotnet run --project src/LoremIpsum.Api
dotnet run --project src/LoremIpsum.Web
```

The API applies migrations on startup in Development.

## Develop

```sh
dotnet build src/LoremIpsum.slnx
dotnet test --solution src/LoremIpsum.slnx

dotnet tool restore
dotnet ef migrations add <Name> --project src/LoremIpsum.Infrastructure --startup-project src/LoremIpsum.Api
```

CI (`.github/workflows/ci.yml`) restores, builds and tests on every push and pull request, with warnings as errors.

## License

See [LICENSE](LICENSE). The license file is not included when the project is used as a template.
