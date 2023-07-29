# Mastering Flutter State Management with the BloC Pattern: A Comprehensive App Tutorial

Welcome to the [**Mastering Flutter State Management with the BloC Pattern**](https://medium.com/@ali_assi/2b3fc10ed3be) repository! This project is a beginner-friendly tutorial on how to use the Bloc state management pattern in a Flutter application.

The main goal of this tutorial is to guide you through the process of building a simple mobile app that fetches random images of cats and dogs from an API. The app will have two screens: one for displaying cat images and one for displaying dog images, beside an authentication services using Firebase Authentication.

To achieve this, we will be using the Bloc library, which is a state management solution that helps you separate your app's presentation logic from its business logic. We will use the Bloc pattern to manage the state of our app and handle user interactions. Also, we will connect the app with Firebase for the authentication part.



## How to Run the App

1. Clone the GitHub repository.
2. Configure Firebase Authentication, you can check this article to learn more [Flutter Bloc State Management. Firebase Authentication](https://medium.com/@ali_assi/d88e78daa8f5)
3. To use dogs and cats apis, you need to create an account there, so you can get api keys, check this section for a quick quide [Data Layer & API Service](https://medium.com/@ali_assi/2b3fc10ed3be)
4. create a file, add the following variables to it
```
  static const String dogApiKey = 'your api key goes here';

  static const String catApiKey = 'the second one goes here also';
```
and make sure the file is imported where the key is used.

5. Install the dependencies using flutter pub get.
6. Run the app using flutter run.

