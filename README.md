# MediConnect - Hospital Management App

MediConnect is a Flutter-based mobile application for hospital management. It supports patient registration, appointment workflows, and access to medical records. The app integrates with a FHIR (Fast Healthcare Interoperability Resources) backend to enable standardized healthcare data exchange.

This project is part of a research effort focused on evaluating security and performance when building Flutter apps using official ecosystem packages.

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [System Architecture](#system-architecture)
- [Technology Stack](#technology-stack)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Research Context](#research-context)

## Overview

The app is designed to support common healthcare workflows:

- Patient onboarding and profile management
- Appointment booking and schedule tracking
- Doctor profile and availability browsing
- Medical record and consultation history viewing
- Secure API-based communication with backend services

## Key Features

### Patient Management

- Register new patients
- View and update patient profiles
- Store demographic and contact information

### Appointment Scheduling

- Book appointments with doctors
- View upcoming and past appointments
- Reschedule or cancel appointments

### Doctor Information

- View doctor profiles
- Access specialization and department details
- Check consultation availability

### Medical Records Viewer

- View consultation history
- Display observations and encounter details
- Access prescription information

### Notifications and Reminders

- Appointment reminders
- Health record update notifications

### Secure Data Access

- Authentication for authorized users
- Secure communication with backend APIs

## System Architecture

MediConnect follows a layered architecture:

1. **Frontend Layer**  
	Flutter mobile client for UI and app-side logic.
2. **Integration Layer**  
	RESTful API communication using FHIR-aligned resources.
3. **Backend Layer**  
	HAPI FHIR server for healthcare resource management.
4. **Data Layer**  
	PostgreSQL storage for structured FHIR-compliant data.

## Technology Stack

The application uses official Flutter ecosystem packages where possible for long-term support, security, and maintainability.

| Feature | Package 0 |
|---|---|
| State management | `ChangeNotifier`, `InheritedWidget` |
| API communication | `http` |
| Navigation | `go_router` |
| Local storage | `path_provider` |
| Local database | `sqflite` |
| Notifications | Native platform channels |

## Getting Started

### Prerequisites

- Flutter SDK (stable channel)
- Dart SDK (bundled with Flutter)
- Android Studio or VS Code with Flutter tooling
- A running backend FHIR server (if testing live integration)

### Installation

```bash
flutter pub get
```

### Run the App

```bash
flutter run
```

### Build Commands

```bash
# Android APK
flutter build apk

# iOS (macOS only)
flutter build ios

# Web
flutter build web
```

## Project Structure

```text
lib/
  core/          # App-wide constants, theme, routes, shared styling
  data/          # Datasources and repository implementations
  domain/        # Domain models and services
  presentation/  # Screens, state management, and UI widgets
  main.dart      # Application entry point
```

## Research Context

This codebase supports a research study comparing official and third-party Flutter plugin usage, with an emphasis on:

- Security exposure
- Performance impact
- Maintainability and long-term stability