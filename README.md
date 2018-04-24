#  PhotoChallenge 

## Udacity you decide project

This App generates a random Photo Challenge Keywords you should find and take a picture of. 


## Implementation
### Initial Screen 
The inital screen is an overview of all Photo Challenges in a table view. You can add as many challenges as you like. 

### Create Challenge View
When loaded the View loades the avilable word domains and presents them in a picker view. After selection of one Domain a new Challenge is created in the CoreData store. 

### Challenge Detail View
In the challenge detail view you can add as many Photos, either from camera or photo roll, that you think fits the challenge keyword. 

### Oxford API
Upon creating an new challenge the app hits the oxford API. It uses the oxford Dictionaries API to let you choose a Domain, subject area of a word. Curently only in english. It than picks a random word out of the domain which represents the challenge. 
Not fully happy with the words the API provides. Perhaps in future I develop an own api that returns predefined keywords tailored to photo taking. 😀

## How to build
No special steps need here. 
Open the project in Xcode and hit run. 

## Requirements
* Xcode 9.3
* Swift 4.0 
* iOS > 11.0
* no third party libs used
