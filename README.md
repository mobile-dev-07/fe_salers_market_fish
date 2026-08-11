# E-Market Fish - Mobile Fishery Products Marketplace
A mobile e-commerce application for booking fresh and frozen fishery products. The platform is designed to simplify product management for sellers and product discovery and booking for buyers.

<img src="/assets/Video-Project-8.gif" height="640" />

## Overview

The project aims to digitalize the fishery marketplace by providing:

- **Digital product marketplace**: Manage and browse fresh and frozen fishery products through a mobile application.
- **Booking management**: Support a structured booking process to help manage product availability and reduce errors in manual transactions.
- **Better user experience**: Simplify product management and order-related workflows for sellers, while making product search, filtering, and booking easier for buyers.

## Features

### Implemented with REST API

- User authentication — Login and registration
- Add and manage delivery addresses
- Add products
- Display products
- Logout

### UI Implemented, REST API Integration Pending

The following interfaces have been implemented in the mobile application but are not yet integrated with the REST API:

- Search and filtering
- Profile editing
- Product filtering by category
- Product editing
- Notifications

## Tech Stack

### Mobile / Frontend

- **Flutter / Dart**
- **Flutter BLoC** — State management
- **GetIt** — Dependency injection
- **Shared Preferences** — Local data storage
- **Flutter Map** — Map integration
- **Material Design** — UI components and design system

### Backend / Infrastructure

- **Go** — Backend API
- **PostgreSQL** — Relational database
- **Docker / Docker Compose** — Containerization
- **MinIO** — Object storage

## Architecture

The Flutter application follows **Clean Architecture** to separate presentation, domain, and data responsibilities and make the codebase easier to maintain and extend.

## Screenshots
| Image 1 | Image 2 | Image 3 |
| --- | --- | ---- |
| ![Image 1](https://drive.google.com/uc?id=1rFV7yX0eV4BZWFrbVyU_H5ej4TXlsil7) | ![Image 1](https://drive.google.com/uc?id=113ZmhgH1rsN-B2BVlK3zeW-SHez5w12S) | ![Image 1](https://drive.google.com/uc?id=1dGuh0Uo-rsj2nZfyAQPsALOht8P-8YjM) |
| ![Image 1](https://drive.google.com/uc?id=1DCtSTiwdJjmzPISIgd2XQv5t93yabqD5) | ![Image 1](https://drive.google.com/uc?id=1vm9uHszpBtj9AlqqheymwyZT4bjneVag) | ![Image 1](https://drive.google.com/uc?id=1xDwqihsucwyT2D1qhbIyr75gw9s3W8xS) |

## UI/UX Design

The application's UI/UX design is available in Figma:

**Figma Design:** [Mobile Dev — E-Market Fish](https://www.figma.com/design/Xw2rJJx5txv2vqgqfEmK7g/Mobile-Dev?node-id=36-1865&t=zywcfwn2Wn0znt5c-1)

## Backend Repository

Backend code can be accessed in this repository:

**Backend:** [Backend Repository](https://github.com/mobile-dev-07/backend)

## Project Structure

A simplified project structure is shown below:

```text
project/
├── frontend/          # Flutter mobile application
└── backend/            # Go REST API
```

The exact structure may vary depending on the current repository layout.

# Installation & Setup

## Prerequisites

Before running the project, make sure the following tools are installed:

### Frontend

- Flutter SDK
- Android Studio
- Android SDK
- Android Emulator or a physical Android device
- JDK 17
- Git

### Backend

- Go
- Docker Desktop
- Git
- PostgreSQL client (optional)

---

# Frontend Setup

## 1. Install Flutter

Download and install Flutter from the official documentation:

[Flutter for Windows](https://docs.flutter.dev/get-started/install/windows)

After installation, add Flutter's `bin` directory to the system `PATH`.

For example:

```text
C:\flutter\bin
```

Verify the installation:

```powershell
flutter --version
```

## 2. Install Android Studio

Download and install Android Studio:

[Android Studio](https://developer.android.com/studio)

Open Android Studio and go to:

```text
More Actions
→ SDK Manager
```

Make sure the following components are installed:

- Android SDK
- Android SDK Platform
- Android SDK Build-Tools
- Android SDK Command-line Tools
- Android SDK Platform-Tools
- Android Emulator

## 3. Configure the Android SDK

Avoid Android SDK paths containing spaces when possible.

For example:

```text
C:\Android\Sdk
```

or:

```text
C:\Users\Public\Android\Sdk
```

Check the SDK location used by Flutter:

```powershell
flutter doctor -v
```

Look for:

```text
Android SDK at:
```

## 4. Enable Windows Developer Mode

Flutter may require symbolic links for some plugins.

Open Windows Developer settings:

```powershell
start ms-settings:developers
```

Then enable:

```text
Developer Mode → ON
```

## 5. Install JDK 17

This project uses JDK 17 as the recommended Java version for Android builds.

One option is Eclipse Temurin:

[Eclipse Temurin JDK 17](https://adoptium.net/temurin/releases/?version=17)

After installation, configure Flutter to use the installed JDK:

```powershell
flutter config --jdk-dir="C:\Program Files\Eclipse Adoptium\jdk-17.x.x-hotspot"
```

Replace the path with the actual JDK installation directory.

Verify the configuration:

```powershell
flutter doctor -v
```

Flutter should report Java 17.

> Note: `java -version` may show a different Java installation if the system `PATH` has not been updated. The JDK reported by `flutter doctor -v` is the important one for Flutter's Android build process.

## 6. Run Flutter Doctor

Run:

```powershell
flutter doctor -v
```

The main Android-related checks should pass:

```text
[✓] Flutter
[✓] Android toolchain
[✓] Android Studio
[✓] Connected device
```

Accept Android licenses if required:

```powershell
flutter doctor --android-licenses
```

Press `y` to accept the licenses.

## 7. Create an Android Emulator

In Android Studio, open:

```text
More Actions
→ Virtual Device Manager
```

Create and start an Android Virtual Device.

For example:

```text
Device: Pixel
Android: 15
API: 35
```

Check whether Flutter detects the emulator:

```powershell
flutter devices
```

## 8. Get Flutter Dependencies

Navigate to the Flutter project directory:

```powershell
cd "path\to\frontend"
```

Then install dependencies:

```powershell
flutter pub get
```

## 9. Run the Flutter Application

Make sure an emulator or Android device is connected:

```powershell
flutter devices
```

Then run:

```powershell
flutter run
```

The first build may take longer because Gradle and Android dependencies may need to be downloaded.

If the terminal displays:

```text
Running Gradle task 'assembleDebug'...
```

allow the process to finish before stopping it.

## 10. Dependency and Build Warnings

You may see warnings about Gradle, Android Gradle Plugin (AGP), or Kotlin versions.

For example:

```text
Flutter support for your project's Gradle version will soon be dropped.
```

These messages are warnings rather than necessarily being build errors.

For an existing project, avoid upgrading all dependencies at once. First make sure the current project builds successfully, then update dependencies incrementally.

If a package causes a compatibility error, update that package in `pubspec.yaml` and run:

```powershell
flutter pub get
flutter clean
flutter run
```

Avoid upgrading every package only because Flutter reports that newer versions are available, as this can introduce dependency conflicts.

## 11. Troubleshooting `DevFSException`

If you see an error similar to:

```text
Error initializing DevFS:
DevFSException(Service disconnected...)
```

even though the APK was successfully built and installed, the issue may be related to the connection between Flutter and the emulator.

Try:

```powershell
adb kill-server
adb start-server
```

Then check the device:

```powershell
flutter devices
```

Finally, run:

```powershell
flutter run
```

Restarting the emulator may also resolve the issue.

---

# Backend Setup

## 1. Install the Prerequisites

Make sure the following are installed:

- Go
- Docker Desktop
- Git
- PostgreSQL client (optional)

Verify Go:

```powershell
go version
```

Verify Docker:

```powershell
docker --version
docker compose version
```

Make sure Docker Desktop is running.

You can also verify the Docker Engine:

```powershell
docker info
```

If the `Server:` section is displayed, Docker is running correctly.

## 2. Navigate to the Backend

Go to the backend directory:

```powershell
cd "path\to\backend"
```

The backend should contain files and directories similar to:

```text
backend/
├── cmd/
├── config/
├── internal/
├── pkg/
├── docker-compose.yaml
├── init_replication.sql
├── go.mod
└── .env.example
```

## 3. Create the Environment File

The project provides an example environment file:

```text
.env.example
```

Create a local `.env` file:

```powershell
Copy-Item .env.example .env
```

For local development, configure the required environment variables.

Example:

```env
ENVIRONMENT=development
SERVICE_PORT=:8080

# PostgreSQL Master
MASTER_DB_USERNAME=user
MASTER_DB_PASSWORD=password
MASTER_DB_NAME=postgres
MASTER_DB_HOST=localhost
MASTER_DB_PORT=5432

# PostgreSQL Replica
SLAVE_DB_USERNAME=readuser
SLAVE_DB_PASSWORD=read_password
SLAVE_DB_NAME=postgres
SLAVE_DB_HOST=localhost
SLAVE_DB_PORT=5433

# JWT
TOKEN_SECRET=local-development-secret

# CORS
CORS_ALLOW_ORIGINS=*

# Timezone
TIMEZONE=Asia/Makassar

# MinIO
OSS_ENDPOINT=localhost:9000
OSS_USER=minioadmin
OSS_PASSWORD=minioadmin
OSS_BUCKET_NAME=gudang-data
OSS_URL=http://10.0.2.2:9000

# API
API_BASE_URL=http://localhost:8080
```

> **Security:** Do not commit `.env` or real credentials to Git. Keep sensitive values in local environment files or a secure secret-management system.

> **Android Emulator:** `10.0.2.2` maps to the host machine's `localhost`, allowing the Android emulator to access services running on the development computer.

## 4. Download Go Dependencies

From the backend directory:

```powershell
go mod download
```

Then:

```powershell
go mod tidy
```

## 5. Start PostgreSQL and MinIO

The project includes:

```text
docker-compose.yaml
```

The Docker Compose configuration provides:

- PostgreSQL primary database — port `5432`
- PostgreSQL replica database — port `5433`
- MinIO API — port `9000`
- MinIO Console — port `9001`

Start the services:

```powershell
docker compose up -d
```

## 6. Check the Containers

Run:

```powershell
docker compose ps
```

The services should be running and healthy.

Expected ports:

```text
PostgreSQL Primary    5432
PostgreSQL Replica    5433
MinIO                 9000
MinIO Console         9001
```

If the project uses an incompatible PostgreSQL image version, update the image in `docker-compose.yaml` to a compatible version.

For example:

```yaml
image: postgres:17
```

Apply the same compatible version to the primary and replica PostgreSQL services when required.

## 7. Check PostgreSQL

View PostgreSQL logs:

```powershell
docker compose logs --tail=50 postgres_primary
```

You can also connect to the primary database:

```powershell
docker exec -it backend-postgres_primary-1 psql -U user -d postgres
```

To list database users:

```powershell
docker exec -it backend-postgres_primary-1 psql -U user -d postgres -c "\du"
```

The project expects users such as:

```text
user
replicator
readuser
```

The replication initialization script creates the replication and read-only users.

## 8. Check the PostgreSQL Replica

Check the services:

```powershell
docker compose ps
```

The replica should be running and healthy.

The host port is:

```text
5433
```

while PostgreSQL listens on:

```text
5432
```

inside the container.

Therefore, the backend uses:

```env
SLAVE_DB_HOST=localhost
SLAVE_DB_PORT=5433
```

## 9. Configure MinIO

MinIO is started through Docker Compose.

Check:

```powershell
docker compose ps
```

The expected ports are:

```text
9000 → MinIO API
9001 → MinIO Console
```

Open the MinIO Console in a browser:

```text
http://localhost:9001
```

For the default local-development configuration:

```text
Username: minioadmin
Password: minioadmin
```

## 10. Create the `gudang-data` Bucket

The backend uses:

```env
OSS_BUCKET_NAME=gudang-data
```

Therefore, the MinIO bucket must be named:

```text
gudang-data
```

Create the bucket through the MinIO Console or MinIO Client.

For example, using the MinIO Client through Docker:

```powershell
docker run --rm --network container:minio minio/mc alias set local http://localhost:9000 minioadmin minioadmin
```

Then:

```powershell
docker run --rm --network container:minio minio/mc mb local/gudang-data
```

If the bucket already exists, it does not need to be created again.

## 11. Configure Public Read Access for Product Images

If product images need to be displayed directly by the Flutter application, the bucket must allow anonymous download access.

Check the bucket policy:

```powershell
& "$env:USERPROFILE\mc.exe" anonymous get local/gudang-data
```

The expected permission is:

```text
download
```

If necessary, set the policy:

```powershell
& "$env:USERPROFILE\mc.exe" anonymous set download local/gudang-data
```

Then verify it again:

```powershell
& "$env:USERPROFILE\mc.exe" anonymous get local/gudang-data
```

> For production deployments, review the bucket policy carefully instead of automatically making the entire bucket public.

## 12. Run the Go Backend

Make sure PostgreSQL and MinIO are running:

```powershell
docker compose ps
```

Then start the backend:

```powershell
go run .\cmd\main
```

The API is configured to run on:

```text
http://localhost:8080
```

## 13. Test the API

The project provides a ping endpoint:

```text
GET /api/v1/ping
```

Test it from PowerShell:

```powershell
curl.exe http://localhost:8080/api/v1/ping
```

A successful response should look similar to:

```json
{
  "status": "success",
  "data": "Hello, World!"
}
```

This confirms that the Go backend is running and reachable on port `8080`.

---

# Local Development Architecture

The local development environment consists of the following services:

```text
                         Windows Host
                              │
             ┌────────────────┼────────────────┐
             │                │                │
          Go API          PostgreSQL         MinIO
          :8080             :5432             :9000
                              │
                              │
                     PostgreSQL Replica
                           :5433
```

From an Android Emulator:

```text
Android Emulator
       │
       ├── Go API
       │   http://10.0.2.2:8080
       │
       └── MinIO
           http://10.0.2.2:9000
```

## Host vs. Android Emulator Addresses

| Service | From Windows Host | From Android Emulator |
|---|---|---|
| Go API | `localhost:8080` | `10.0.2.2:8080` |
| MinIO | `localhost:9000` | `10.0.2.2:9000` |
| PostgreSQL Primary | `localhost:5432` | Not accessed directly |
| PostgreSQL Replica | `localhost:5433` | Not accessed directly |
| MinIO Console | `localhost:9001` | `10.0.2.2:9001` |

For product images stored in the `gudang-data` bucket, the Android Emulator should use a URL in this format:

```text
http://10.0.2.2:9000/gudang-data/<FILE_NAME>.jpg
```

The bucket name must be included in the URL.

---

# Running the Project

After the initial setup is complete, you do not need to repeat the installation steps every time.

## Terminal 1 — Start Infrastructure

```powershell
cd "path\to\backend"
docker compose up -d
```

Check the containers:

```powershell
docker compose ps
```

## Terminal 2 — Start the Backend

```powershell
cd "path\to\backend"
go run .\cmd\main
```

## Terminal 3 — Run the Flutter Application

```powershell
cd "path\to\frontend"
flutter pub get
flutter run
```

## Test the Backend

```powershell
curl.exe http://localhost:8080/api/v1/ping
```

---

# Quick Start

Once everything has been configured, the typical development workflow is:

```text
Start Docker
     ↓
Start PostgreSQL + MinIO
     ↓
Start Go API
     ↓
Start Android Emulator
     ↓
Run Flutter Application
     ↓
Test the application
```

## Setup Checklist

### Flutter

- [ ] Flutter SDK installed
- [ ] Flutter added to `PATH`
- [ ] Android Studio installed
- [ ] Android SDK installed
- [ ] Android SDK Build-Tools installed
- [ ] Android SDK Command-line Tools installed
- [ ] Android Emulator available
- [ ] JDK 17 installed
- [ ] Flutter configured to use JDK 17
- [ ] Windows Developer Mode enabled
- [ ] Android licenses accepted
- [ ] Emulator detected by `flutter devices`
- [ ] `flutter doctor -v` reports no Android errors

### Backend

- [ ] Go installed
- [ ] Docker Desktop installed and running
- [ ] `.env` created from `.env.example`
- [ ] Go dependencies downloaded
- [ ] PostgreSQL containers running
- [ ] PostgreSQL primary available on port `5432`
- [ ] PostgreSQL replica available on port `5433`
- [ ] MinIO available on port `9000`
- [ ] MinIO Console available on port `9001`
- [ ] `gudang-data` bucket created
- [ ] Required MinIO access policy configured
- [ ] Go API running on port `8080`
- [ ] `/api/v1/ping` responds successfully

## Notes

This README describes the current local development setup and the features documented in the project source. Update the screenshots, project structure, environment variables, and commands if the repository structure or implementation changes.
