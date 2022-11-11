# BProfilePage
ProfilePage with Customize NavBar

#### Technologies used
 - RxSwift
 
 - Swift Language (UIKit)
 
 - MVVM Architecture
 
 - Coordinator Pattern
 
 - SOLID
 
 - Caching using FileManager

## Design

#### The UI was implemented using programmatic and AUTO Layout. The following are the steps I took in other to get this project done.

- I broke the task down into several layers
- I setup the Coordinator for Navigation
- I added the dependencies using SPM and Cocoapods
- I setup a Networking Manager and a Network service for CRUD Operation
- I created Interfaces/Protocols for get creating the Data Model used for retrieving Data from Firestore
- I used the interfaces to created the Data Model
- I had a rough test of the data from the firebase firestore on a separate app (Testing App My way of confirming the data response)
- I added the Utility file / Extension files needed for smooth developing process
- I created Reuseable Components
- I implemented the collection datasource using RxSwift and later improved on it to have the desired result

![Simulator Screen Shot - iPhone 14 Pro - 2022-11-11 at 17 11 54](https://user-images.githubusercontent.com/67703771/201383105-38d20594-7e03-4e77-a6d1-eb7d04266cfb.png)


![Simulator Screen Shot - iPhone 14 Pro - 2022-11-11 at 15 03 36](https://user-images.githubusercontent.com/67703771/201382761-0fab51db-3a09-4942-919a-a1d64df870b9.png)


![Simulator Screen Shot - iPhone 14 Pro - 2022-11-11 at 15 03 41](https://user-images.githubusercontent.com/67703771/201382794-b51223de-2c19-4c70-91c0-8b01abe52c94.png)


![Simulator Screen Shot - iPhone 14 Pro - 2022-11-11 at 16 48 41](https://user-images.githubusercontent.com/67703771/201382816-78726746-dada-4f60-bbb0-e784f21cf457.png)
