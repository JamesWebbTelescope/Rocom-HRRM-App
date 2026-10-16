# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

### Added
- Environment variable support using flutter_dotenv package
- .env file configuration for API base URL (HRRM_API_BASE_URL)
- .env asset declaration in pubspec.yaml
- .env and .env.* files added to .gitignore (with .env.example exception)
- Initial Flutter project structure with MaterialApp scaffold
- Album model with JSON serialization and HTTP fetching capability
- MyHomePage widget with counter functionality and state management
- GetTaskContent widget for displaying fetched album data
- FutureBuilder integration for asynchronous data loading
- Basic UI components including AppBar, FloatingActionButton, and Text displays
- Platform-specific configurations for Android and Web
- Project configuration files (pubspec.yaml, analysis_options.yaml)
- Test directory structure
- Refresh Album button in persistentFooterButtons for manual album data refresh
- Task model with comprehensive fields (taskId, description, requiredCapability, priority, status, assignedAgentId, zone, constraints, createdAt, updatedAt)
- Task.toJson() serialization method
- Task.fromJson() factory with safe parsing and null handling
- Helper methods (_safeToString, _safeToInt) for robust data conversion
- Task.fetchTasks() static method for fetching task list from API
- Task.sendTasks() static method for posting sample task
- Task.createTask() static method for creating tasks with custom description and priority
- Task creation form with description and priority input fields
- New task button in persistentFooterButtons
- Debug logging throughout the application with debugPrint
- Enhanced error handling with stack trace display
- Loading state with CircularProgressIndicator

### Changed
- API endpoints now use environment variable (HRRM_API_BASE_URL) with fallback to hardcoded URL
- main() function changed to async to support dotenv loading at startup
- Added dotenv.load() initialization at app startup
- Button layout changed from Row to Column in MyHomePage for better responsiveness
- Updated API endpoint IP from 192.168.111.3:18830/tasks to 10.0.6.209:18830/tasks in Task.sendTasks() and Task.createTask() methods
- Added automatic task refresh on MyHomePage initState via _refreshTasks() method
- Refactored persistentFooterButtons to use Row layout with proper spacing
- Added late Future<List<Task>> futureTasks initialization in _MyHomePageState
- Removed unused import 'package:flutter/foundation.dart' from main.dart
- Reduced Gradle JVM heap memory from -Xmx8G to -Xmx2G
- Reduced Gradle MaxMetaspaceSize from 4G to 512m and ReservedCodeCacheSize from 512m to 256m
- Removed -XX:+HeapDumpOnOutOfMemoryError from Gradle JVM args
- Changed Gradle distribution from gradle-9.3.1-all.zip to gradle-9.3.1-bin.zip
- Added gradle.user.home=D:/gradle/gradle-user-home to both gradle.properties and gradle-wrapper.properties
- Updated API endpoint from jsonplaceholder.typicode.com to local server (192.168.111.3:18830/tasks)
- Updated app title from 'Flutter Demo' to 'Rocom HRRM'
- Updated home page title from 'Flutter Demo Home Page' to 'Rocom HRRM Home Page'
- Updated device_calendar dependency from 4.3.2 to ^4.3.3
- Updated pubspec.lock with new dependency versions
- Replaced Album model with Task model for domain-specific task management
- Changed fetchAlbum() to fetchTasks() with List<Task> return type
- Updated UI labels from "Album Title" to "Task Title"
- Updated refresh button from "Refresh Album" to "Refresh Tasks"
- Changed theme color from default to Colors.lightBlue
- Removed all inline comment blocks for cleaner code
- Imported flutter/foundation.dart for debugPrint functionality

### Fixed

### Removed

## [0.1.0] - 2026-10-09

### Added
- Initial commit with project setup
