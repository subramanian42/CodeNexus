# Code Nexus

This Flutter project is a GitHub clone app called Code Nexus. It allows users to authenticate using GitHub through Firebase, view their basic information, repositories, organizations, and navigate through repository details and folder structures.
## Screens

### Screen 1: Login Page
Create a login page that enables GitHub authentication using Firebase.

### Screen 2: Home Page
The home page displays the user's basic information, including their username, full name, and profile icon. It also lists their repositories and organizations.

### Screen 3: Repository View Page
This page lists all the branches in a tab bar. Selecting a branch displays the files and folders within that branch. Clicking on a folder will open the page again, loading the files and sub-folders within that folder.

### Screen 4: File Explorer
The file explorer screen allows users to navigate through files and folders within a repository. Users can view files and sub-folders, and perform various actions related to managing the repository's contents.

## How to Run the App

Follow the steps below to run the Code Nexus app:

1. Clone this repository to your local machine.
2. Make sure you have Flutter installed. If not, follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install).
3. Open a terminal and navigate to the project directory.
4. Run the following command to install the required dependencies:
    ```
    flutter pub get
    ```
5. Download the Google Services JSON file from the Firebase console. Follow these steps:
- Go to the [Firebase Console](https://console.firebase.google.com/).
- Select your project or create a new one.
- Go to the "Project settings" by clicking on the gear icon next to "Project Overview" on the left sidebar.
- In the "Your apps" section, click on the "Add app" button (Android icon).
- Provide the necessary information for the Android app and click on "Register app."
- Download the `google-services.json` file when prompted.
6. Copy the downloaded `google-services.json` file to the `android/app` directory of your project.
7. Open the `android/app/build.gradle` file in your project and add the following line at the bottom of the file, inside the `dependencies` block:
   ```
   implementation 'com.google.firebase:firebase-auth-ktx'
   ```
8. Still in the `android/app/build.gradle` file, add the following line at the bottom of the file, outside any block:
   ```
   apply plugin: 'com.google.gms.google-services'
   ```
9. Open the `android/build.gradle` file in your project and add the following classpath to the `dependencies` block:
   ```
   classpath 'com.google.gms:google-services:{latest_version}'
    ```
10. Save the files and return to the terminal.
11. Connect a device or start an emulator.
12. Run the following command to launch the app on your device/emulator:
    ```
    flutter run
    ```
Make sure to complete the necessary Firebase setup and configuration, such as enabling the necessary Firebase services for your app, before running the app with the Firebase functionality.

Please note that the above steps assume you have the required setup and configuration for Firebase in your Flutter project.

## Screenshots

Here are some screenshots of the Code Nexus app:
| | | | |
|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
|<img width="200" alt="Login Page" src="screenshots/login_page.png"> |  <img width="200" alt="home page" src="screenshots/home_page.png"> | <img width="200" alt="Repository View Page" src="screenshots/repository_view_page.png"> | <img width="200" alt="File Explorer" src="screenshots/file_explorer.png"> |




## Acknowledgements

This project utilizes the following technologies and libraries:

- Flutter: A UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.
- Firebase: A mobile and web application development platform that provides backend services such as authentication, real-time database, and storage.
- GitHub API: The official GitHub API to interact with GitHub repositories and user data.
- go_router: A Flutter package that provides a declarative way to define and navigate between routes in your app.
- flutter_bloc: A predictable state management library that helps to manage the state of your Flutter app in a clear and manageable way.

## Contributing

Contributions to Code Nexus are welcome! If you encounter any issues or have suggestions for improvements, please create a new issue in the GitHub repository.

## License

The Code Nexus project is licensed under the [MIT License](LICENSE). Feel free to use, modify, and distribute this project as per the terms of the license.
