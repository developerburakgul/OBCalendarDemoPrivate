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
            calendarView
        }
        .padding()
    }
    
    var calendarView: some View {
        let nineOctoberDateComponents = DateComponents(year: 2024, month: 10, day: 9)
        let nineOctober = Calendar.current.date(from: nineOctoberDateComponents)!
        let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: nineOctober)!
        let calendar = getCalendar(for: localeIdentifier)
        
        let years: [CalendarModel.Year] = CalendarModelBuilder.defaultLayout(
            calendar: calendar,
            startingDate: nineOctober,
            endingDate: nextYear
        )
        return OBCalendar(years: years) { model, proxy in
            // Day View goes here
            Text("\(model.day.day)")
        } monthContent: { model, proxy, daysView in
            // Month View goes here
            daysView
        } yearContent: { model, proxy, monthsView in
            // Year view goes here
            monthsView
        }
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

