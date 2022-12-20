//
//  DateChooser.View.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 19/12/2022.
//

import SwiftUI

struct DateChooserView: View {
    @State private var showingSheet = false
    @State private var selectedDate = Date.now
    
    @ObservedObject var actualDate : ObservableDate
    
    init(actualDate: ObservableDate) {
        self.actualDate = actualDate
    }
    
    var body: some View {
        Button(action: {showingSheet.toggle()}){
            Image(systemName: "calendar.badge.clock")
        }
        .sheet(isPresented: $showingSheet) {
            NavigationView {
                VStack (alignment: .center) {
                    Text("You've figured out how to time travel !")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    Text("Use the date picker below to choose what date the app thinks it is")
                        .multilineTextAlignment(.center)
                    Spacer()
                    DatePicker(
                        "Current Date",
                        selection: $selectedDate
                    ).datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                    Spacer()
                    Button(action: {
                        actualDate.date = selectedDate
                        showingSheet = false
                    }){
                        ColoredTextPill(text: "Done", backgroundColor: .accent, foregroundColor: .foreground, font: .title)
                    }
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Button("Cancel"){
                            selectedDate = actualDate.date
                            showingSheet = false
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button("Reset"){
                            selectedDate = Date.now
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct DateChooserView_Previews: PreviewProvider {
    static var previews: some View {
        DateChooserView(actualDate: ObservableDate())
    }
}
