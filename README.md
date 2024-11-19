# Flutter Weather App

## Overview
This is a Flutter application that displays weather information based on user input or location.

## Setup Instructions

### Prerequisites
Before you begin, make sure you have the following installed:
- [Flutter](https://docs.flutter.dev/get-started/install) SDK
- Dart
- Android Studio or Xcode for emulators
- Git (for cloning the repository)

### Steps to Run the Project

1. **Clone the Repository**
   ```bash
   git clone git@github.com:qaysdwekat/weather_app.git
   cd weather_app
   ```
2. **Add Configuration Files**

- Development Configration: 
    -  Create a file `development.json` with the following content:
        ```bash
        {
            "env": "development",
            "production": false,
            "base_url": "base_url",
            "weather_token": "your_dev_weather_token",
            "openweathermap_image_url": "openweathermap_image_url"
            }
         ```
    - Save this file at: 
        ```bash
        lib/environments/weather_app/development/development.json
        ```

- Production Configration: 
    -  Create a file `production.json` with the following content:
        ```bash
        {
            "env": "Production",
            "production": true,
            "base_url": "base_url",
            "weather_token": "your_dev_weather_token",
            "openweathermap_image_url": "openweathermap_image_url"
            }
          ```  
    - Save this file at:
 
        ```bash
        lib/environments/weather_app/production/production.json
        ```

3. **Generate Environment Files**
 Use the following command to generate the necessary environment-specific files:

    ```bash
        dart run build_runner build
    ```

4. **Run the Application**
   
   - Run the Application Start the app using the desired environment flavor.
   
      * For Development:
      
          ```bash
          flutter run -t lib/environments/weather_app/development/main_development.dart
          ```
      * For Production:
      
          ```bash
          flutter run -t lib/environments/weather_app/production/main_production.dart
          ```

### Running Tests

   - Unit Tests Run the following command to execute unit tests:
   
       ```bash
       flutter test
       ```
