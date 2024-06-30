# Mastering Flutter State Management with the BloC Pattern: A Comprehensive App Tutorial

Welcome to the [**Mastering Flutter State Management with the BloC Pattern**](https://medium.com/@ali_assi/2b3fc10ed3be) repository! This project is a beginner-friendly tutorial on how to use the Bloc state management pattern in a Flutter application.

The primary objective of this tutorial is to walk you through the process of creating a app that retrieves random images of cats and dogs from an API. The app will consist of two screens; one for displaying cat images and another for displaying dog images alongside an authentication service that utilizes Firebase Authentication.

To accomplish this we will utilize the Bloc library, which provides a solution, for managing state in your app while separating presentation logic from business logic. By implementing the Bloc pattern we can effectively manage our apps state. Handle user interactions. Additionally we will integrate Firebase into our app to handle authentication.


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

