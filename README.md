# PawsPlaydate

This app was created as a capstone project for Ada Developers Academy. <br> 
The main function is for users to coordinate pet playdates with other users. 
The user has the option to add pet data, read pet data, and upload pet images from Firebase (Authentication, Firestore, Storage).

<img src="https://github.com/eetorresf/PawsPlaydate/blob/main/PawsPlaydate/Assets.xcassets/Readme%20/SignInView.imageset/SignInView.png" alt="sign in view" width="30%" height="30%"/> <img src="https://github.com/eetorresf/PawsPlaydate/blob/main/PawsPlaydate/Assets.xcassets/Readme%20/SignUpView.imageset/SignUpView.png" alt="sign up view" width="30%" height="30%"/>   <img src="https://github.com/eetorresf/PawsPlaydate/blob/main/PawsPlaydate/Assets.xcassets/Readme%20/UserView.imageset/UserView.png" alt="user view" width="30%" height="30%"/>
<img src="https://github.com/eetorresf/PawsPlaydate/blob/main/PawsPlaydate/Assets.xcassets/Readme%20/ChatView.imageset/ChatView.png" alt="chat view" width="30%" height="30%"/> <img src="https://github.com/eetorresf/PawsPlaydate/blob/main/PawsPlaydate/Assets.xcassets/Readme%20/PetsView.imageset/PetsView.png" alt="pets view" width="30%" height="30%"/>   <img src="https://github.com/eetorresf/PawsPlaydate/blob/main/PawsPlaydate/Assets.xcassets/Readme%20/FavoritesView.imageset/FavoritesView.png" alt="favorites view" width="30%" height="30%"/>

## Requirements

This module requires the following: <br>
- Install [Xcode](https://apps.apple.com/use/app/xcode/id497799835?mt=12).
  - Requires minimum iOS 16.2
- Register as an iOS app with [Firebase](https://firebase.google.com/docs/ios/setup) to create your own database.
  - Swift Package Manager must be installed on Xcode and the file GoogleService-Info.plist needs to 
 be saved to the root of the project. 

## Features
1. User can sign in to an existing account using their email and password, or create an account with a username,
email, and password.
2. The user is brought to a welcome screen with a tabview to tab across main views.
3. The **User** view displays the user's pets and includes a button to add a new pet with an image.
4. The user can message other users using the **Chat** view.
5. The user can view other user's pets using **Pets** view.
6. The user can like other pets, those pets will be displayed on the **Friends** view.
