//
//  TalkDetails.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 16/12/2022.
//

import SwiftUI
import EventKit

struct TalkDetailsView: View {
    let talk : Talk
    
    let eventStore : EKEventStore = EKEventStore()
    
    init(talk: Talk) {
        self.talk = talk
    }
    
    /**
     Extract the day of the week from {date}
     */
    private func formatDayOfWeek(date: Date) -> String {
        return date.formatted(
            .dateTime
                .weekday(.wide)
        )
    }
    
    /**
     Formats {start} and {end} into the string "{start hour}:{start minute} {AM/PM} - {end hour}:{end minute} {AM/PM}"
     */
    private func formatHours(start: Date, end: Date) -> String {
        return start.formatted(
            .dateTime
                .hour().minute()
        ) + " - " + end.formatted(
            .dateTime
                .hour().minute()
        )
    }
    
    /**
     Creates a new event in the user's default calendar for this talk
     */
    private func saveToCalendar(){
        eventStore.requestAccess(to: .event) { (granted, error) in
          if (granted) && (error == nil) {
              
              let event:EKEvent = EKEvent(eventStore: eventStore)
              
              event.title = talk.activity
              event.startDate = talk.start
              event.endDate = talk.end
              event.notes = talk.speakers?.reduce("Speakers : \n", { partialResult, name in
                  partialResult + "\n" + name
              })
              event.location = talk.location
              event.calendar = eventStore.defaultCalendarForNewEvents
              do {
                  try eventStore.save(event, span: .thisEvent)
              } catch _ {}
          }
        }
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(talk.activity)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 1)
            VStack (alignment: .leading) {
                Text(formatDayOfWeek(date: talk.start))
                Text(formatHours(start: talk.start, end: talk.end))
            }
            .padding(.bottom, 20)
            if(talk.speakers != nil){
                HStack {
                    Text("Speakers")
                        .fontWeight(.semibold)
                    Spacer()
                    VStack (alignment: .leading) {
                        // Use ! since we ensure the list exists with the if
                        ForEach(talk.speakers ?? [], id: \.self){ speakerName in
                            Text(speakerName)
                        }
                    }
                }
                Divider()
            }
            HStack {
                Text("Tag")
                    .fontWeight(.semibold)
                Spacer()
                ColoredTextPill(text: talk.type)
            }
            Divider()
            HStack {
                Text("Location")
                    .fontWeight(.semibold)
                Spacer()
                Text(talk.location)
            }
            Spacer()
            HStack{
                Spacer()
                Button(action: saveToCalendar) {
                    ColoredTextPill(text: "Add to calendar", backgroundColor: .accent, foregroundColor: .foreground, font: .title)
                }
                Spacer()
            }
        }
        .foregroundColor(.main)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            alignment: .topLeading
        )
        .padding()
        .navigationTitle("Talk details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TalkDetails_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack{
                TalkDetailsView(talk: Talk(location: "Sapphire room", activity: "Building an alert system that works for everyone", type: "Panel", start: Date.now, end: Date.now, speakers: ["Mattheus Anderson", "Deepa Vartak"]))
            }
            NavigationStack{
                TalkDetailsView(talk: Talk(location: "Foo", activity: "Building an alert system that works for everyone", type: "Panel", start: Date.now, end: Date.now, speakers: nil))
            }
        }
        
    }
}
