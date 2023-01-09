
# <p align="center">Efrei Mobile Development Project</p>
  
This repo contains the submission of Samuel Bader and Enzo Filangi for the final project of the M2 Mobile Development course at Efrei Paris.

The goal of this project was to build an iOS application for a convention which would display informations about all the talks that would happen at that conference. To train and demonstrate our understanding of the course material, we chose to use SwiftUI as the GUI framework for our app.
        
## Installation
Open Xcode on a mac running macOS 12.6 Monterey or later

Click "Clone an existing project" on the left pane, and paste the following URL in the "Search or enter repository URL" field : https://github.com/EnzoFilangi/M2-MobileDevelopmentProject.git

Choose the `main` branch, name the directory, and wait for Xcode to clone the repository.
        
## Usage
To run the project, choose any simulator running iOS 16 or later. The app adapts properly to every phone size - from the iPhone SE up to the iPhone 14 Pro Max. Then click the |> icon in the top left of the Xcode window. Wait until Xcode finishes building and installing the app.

You can now use the application in the simulator.

## Features
The app is divided in three tabs.

#### Talks
The first tab is a list of all current and upcoming talks. It uses the phone's internal date to filter which talks should be in which category. They are displayed as cards showing a summary of the most important information. Each card can be tapped on to show a more detailed view with a functional button to create a calendar event for this talk.

Since the app's review will probably not happen on the date of the fake conference, the "Right now" pane will most probably be empty. This is intended behavior : indeed, there really is no talk going on right now.

To alleviate this, we embedded a time machine in the app. Tapping the button at the top right of the screen opens a modal that allows you to change the date the app thinks it is, thus enabling you to test what will happen during the conference.

#### Speakers
The second tab is a list of all speakers participating to the event. They are listed in alphabetical order in a similar way to the contacts app of the phone. We did this so users would be familliar with the interface.

It is possible to tap each speaker to open a detailed view with their contact information. As the database contains fake information, we did not actually implement the call, text and email buttons. However, these would be easy to do with iOS's URL Schemes.

We would have liked to display pictures as well, but sadly the database did not contain any.

#### Search
Finally, the third tab is similar to the first one as it displays the talks, however it does not take the time into account. Instead, it allows the user to search for a specific talk (typing its title, one of the speaker's name, and so on...) and/or to filter by type of talk.

In a similar fashion to the talks tab, users can tap on the card to reveal more information about the talk.
        
## Authors
#### Samuel Bader
#### Enzo Filangi

## Known issues
#### Warnings when opening the time travel modal
When you open the time travel modal, the Xcode console might display the following warning :
```
MobileDevelopmentProject[79793:6369779] [LayoutConstraints] Unable to simultaneously satisfy constraints.
```
According to our research, this is a bug in the iOS 16.2 SDK when using the DatePicker component :

https://developer.apple.com/forums/thread/714929?answerId=728471022#728471022

https://stackoverflow.com/questions/73475000/datepicker-with-graphical-style-breaks-layout-constraints-on-ios-16-0

Since we cannot modify iOS's source code, there is no way for us to fix this bug.

#### XPC Connection
When using the app, you might see the following warning
```
[xpc] XPC connection was invalidated
```

We have no idea why this happens and could not find any info on the internet with the same "invalidated" message. Moreover, this problem did not occur on December 27th, but did occur on January 9th without any change being made in between. This leads us to think it might be an issue with either iOS, Xcode, or AirTables that is out of our control.
