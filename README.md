# GoalTube - Get Certified to Watch YouTube!
## AI platform to get credibility by watching Youtube Tutorial Videos 
 
### Team name: Coders.py

## Team members
* Vriddhi Gupta - vriddhigupta898@gmail.com
* Abhay Ubhale - abhayubhale.30@gmail.com
* Krishna Asher - krasher_b19@it.vjti.ac.in
* Jaivanti Dhokey - jsdhokey_b18@pe.vjti.ac.in
* Sarah Tisekar - sntisekar_b19@ce.vjti.ac.in
* Vedika Mamidwar - vedikakmamidwar@gmail.com


## Description

* Because technology is constantly being updated, YouTube serves as a platform for these updates to reach a large audience.
* A lot of people can't afford paid courses on various Edtech platforms like Coursera, Udemy, etc.
* Thus, learning through Youtube is the only way out. But, watching Youtube tutorials does not provide credibility to showcase as a criteria of employability. 
* As a result, we created an interactive and user-friendly mobile application that will aid in the credibility of YouTube playlists.
* GoalTube is an AI platform that provides credibility to learners across all backgrounds through our dynamic and customizable test who aim to educate themselves through platforms like YouTube.
* The user can sign in with their Google account and add the YouTube playlist that they want to finish. The Playlist will not be added to the course list until it has been approved by the admin panel. Following videos, the user will be required to complete a quiz in which the questions are generated based on the subtitles extracted from the video using NLP(Natural Language Processing). Users can also view and watch playlists uploaded by other users.
* If a user believes that a question or answer is incorrect, they can report it to the admin panel, and the admin panel will investigate further.
* If the user receives a certain number of passing points at the end of all videos and quizzes, they will be certified for that course.

## Links
* GitHub Repo link: [Link to repository](https://github.com/abby3010/GoalTube)
* Admin Panel: [Website Link to admin panel](https://goaltube-sih-hackathon.herokuapp.com)
* Admin Panel Github Repository(with Flutter set in it): [Admin Panel Code](https://github.com/abby3010/GoalTube-Admin-Panel)
* ML Model for genearting questions: [ML Model code](https://github.com/Krishna26Ashar/GoalTube---ML-Model-for-generating-Questionnaire)

## Technology stack

Tools and technologies that you learnt and used in the project.

1. Dart
2. Python
3. Flutter
4. Firebase
5. Flask
6. Pytorch

## Project Setup
* For this project, you will have to install latest version of Android studio and latest version of Flutter and then install Dart and Flutter plugin in Android Studio. The steps to so is:
  > Open Android studio -> Go to setting -> Plugins -> Seach dart and flutter -> Install and enable them -> Restart IDE.
* Run the command flutter doctor in the terminal on Android studio to check if there are any issues. You may install the SDK command-line tool. After that, you can either connect your phone to Android Studio or run the app on the emulator.

## Usage
* After setup on Android studio is done, you can connect your mobile device to your laptop via USB and then run the application on your mobile. The app will be installed and opened automatically.
* When the app is finished, you will see a splash screen with beautiful animation displaying the app's name. After that, a series of animated screens will appear before you reach the login screen.
* You can login using your google account which will read your profile name, email, phone and photo and store them in the database as user data. 
* Once logged in, you will see multiple courses uploaded by other users on the home page, which you can complete or request the playlist of your choice.
* When you click on the side drawer option on the app bar, you will see the option to "Add playlist", where you can enter the course name and YouTube playlist link before submitting the course to the admin panel for approval. You can view the course in the "My courses" option once it has been approved by the admin panel.
* When you click view more on any course, you will be able to see the course's ratings as well as all of the videos in two different views: grid view and list view. You can watch the YouTube video in the app by clicking on the video thumbnail. After watching the videos, you can attempt the quiz and get a passing score to receive certificate.

## Flowchart
 
<img src="https://github.com/abby3010/GoalTube/blob/main/Screenshots%20-%20GoalTube/architecture.png" width="1000">


## Applications
* GoalTube's most important application is that it can be used by anyone. Because it is not at all paid and even YouTube courses are becoming more credible, it will undoubtedly benefit students who cannot afford paid courses from Udemy, Coursera, and others.
* If it is published in collaboration with a government entity, the credibility of the certificate for courses will be enhanced even further, and the application can be made available to more schools and colleges.
* We can also use the quiz to determine whether or not the user is watching the video. Furthermore, testing your knowledge is a way to gain confidence in that subject, and thus our application will motivate users to complete the courses.

## Future scope
* Peer to peer quiz rounds after each video in a playlist - At the end of every video, the user will be asked to submit few questions along with their answer related to that video. This submitted quiz questions will be then shown to other users.
* Automate Admin panel -As the number of users grows, so will the number of playlist requests. As a result, we will implement an ML Model that will accept or deny requests based on the videos in the playlist, reducing manual work.

## Screenshots

## Screenshots
| ![](Screenshots%20-%20GoalTube/WhatsApp%20Image%202022-03-26%20at%207.47.40%20AM.jpeg) | ![](Screenshots%20-%20GoalTube/Screenshot_2022-03-26-07-12-29-68_a226cad3b95b00e4795a4053ca203fbc.jpg) | ![](Screenshots%20-%20GoalTube/Screenshot_2022-03-26-07-12-59-95_a226cad3b95b00e4795a4053ca203fbc.jpg) | ![](Screenshots%20-%20GoalTube/Screenshot_2022-03-26-07-13-13-69_a226cad3b95b00e4795a4053ca203fbc.jpg) |
| :-------------: | :-------------:  | :-------------:  | :-------------:  | 
|     Splash Screen     |    HomePage   |    Side Drawer     |     All Courses     |     

| ![](Screenshots%20-%20GoalTube/Screenshot_2022-03-26-01-51-35-370_com.codingabby.goaltube.jpg) | ![](Screenshots%20-%20GoalTube/Screenshot_2022-03-26-01-51-37-411_com.codingabby.goaltube.jpg) | ![](Screenshots%20-%20GoalTube/SS%201.png) | ![](Screenshots%20-%20GoalTube/Screenshot_2022-03-26-07-13-04-96_a226cad3b95b00e4795a4053ca203fbc.jpg) |
| :-------------: | :-------------:  | :-------------:  | :-------------:  | 
|     Videos Grid View     |    Videos List View   |    YouTube Video    |     Add Playlist     |    
    
<!-- 

My Courses Screenshots%20-%20GoalTube/Screenshot%202022-02-27%20122132.jpg
Videos Grid View Screenshots%20-%20GoalTube/Screenshot_2022-03-26-01-51-35-370_com.codingabby.goaltube.jpg
Videos List View Screenshots%20-%20GoalTube/Screenshot_2022-03-26-01-51-37-411_com.codingabby.goaltube.jpg
HomePage Screenshots%20-%20GoalTube/Screenshot_2022-03-26-07-12-29-68_a226cad3b95b00e4795a4053ca203fbc.jpg
Side Drawer Screenshots%20-%20GoalTube/Screenshot_2022-03-26-07-12-59-95_a226cad3b95b00e4795a4053ca203fbc.jpg
All Courses Screenshots%20-%20GoalTube/Screenshot_2022-03-26-07-13-13-69_a226cad3b95b00e4795a4053ca203fbc.jpg
Splash Screen Screenshots%20-%20GoalTube/WhatsApp%20Image%202022-03-26%20at%207.47.40%20AM.jpeg
YouTube Video Screenshots%20-%20GoalTube/SS%201.png -->


- **Admin Panel**
 
<img src="https://github.com/abby3010/GoalTube/blob/main/Screenshots%20-%20GoalTube/Screenshot%202022-03-26%20075129.png" width="1000">

<img src="https://github.com/abby3010/GoalTube/blob/main/Screenshots%20-%20GoalTube/Screenshot%202022-03-26%20075227.png" width="1000">

<img src="https://github.com/abby3010/GoalTube/blob/main/Screenshots%20-%20GoalTube/Screenshot%202022-03-26%20075259.png" width="1000">

<img src="https://github.com/abby3010/GoalTube/blob/main/Screenshots%20-%20GoalTube/Screenshot%202022-03-26%20075527.png" width="1000">

- **Model that will extract the submitiles from the YouTube Video and generate subjetive questions**
 
<img src="https://github.com/abby3010/GoalTube/blob/main/Screenshots%20-%20GoalTube/ML_model_1.png" width="1000">

<img src="https://github.com/abby3010/GoalTube/blob/main/Screenshots%20-%20GoalTube/ML_Model_2.png" width="1000">

<img src="https://github.com/abby3010/GoalTube/blob/main/Screenshots%20-%20GoalTube/ML_Model_3.png" width="1000">

<img src="https://github.com/abby3010/GoalTube/blob/main/Screenshots%20-%20GoalTube/ML_Model_4.png" width="1000">

<img src="https://github.com/abby3010/GoalTube/blob/main/Screenshots%20-%20GoalTube/ML_Model_5.png" width="1000">

<img src="https://github.com/abby3010/GoalTube/blob/main/Screenshots%20-%20GoalTube/ML_Model_6.png" width="1000">
