FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["WebApi.CronJob/WebApi.CronJob.csproj", "WebApi.CronJob/"]
COPY ["WebApi.Core/WebApi.Core.csproj", "WebApi.Core/"]
COPY ["WebApi.Services/WebApi.Services.csproj", "WebApi.Services/"]
COPY ["WebApi.Infrastructure/WebApi.Infrastructure.csproj", "WebApi.Infrastructure/"]
COPY ["WebApi.DataModel/WebApi.DataModel.csproj", "WebApi.DataModel/"]
COPY ["WebApi.Repositories/WebApi.Repositories.csproj", "WebApi.Repositories/"]
COPY ["WebApi.ViewModel/WebApi.ViewModel.csproj", "WebApi.ViewModel/"]
RUN dotnet restore "WebApi.CronJob/WebApi.CronJob.csproj"
COPY . .
WORKDIR "/src/WebApi.CronJob"
RUN dotnet build "WebApi.CronJob.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "WebApi.CronJob.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "WebApi.CronJob.dll"]
