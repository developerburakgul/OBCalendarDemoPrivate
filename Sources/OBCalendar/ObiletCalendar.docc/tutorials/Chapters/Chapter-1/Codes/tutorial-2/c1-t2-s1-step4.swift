//
//  OBCalendarDemo.swift
//  OBCalendarDemo
//
//  Created by Burak on 7.10.2024.
//

import SwiftUI
import ObiletCalendar

struct OBCalendarDemo: View {
    @State var localeIdentifier: String
    
    init(localeIdentifier: String = "en_US") {
        self.localeIdentifier = localeIdentifier
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    private func getCalendar(for localeIdentifier: String) -> Calendar {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: localeIdentifier)
        return calendar
    }
    
}


#Preview {
    OBCalendarDemo()
}

