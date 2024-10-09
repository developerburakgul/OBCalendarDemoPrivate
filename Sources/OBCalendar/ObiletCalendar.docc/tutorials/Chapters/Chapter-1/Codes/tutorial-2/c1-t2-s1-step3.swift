//
//  OBCalendarDemo.swift
//  OBCalendarDemo
//
//  Created by Burak on 7.10.2024.
//

import SwiftUI
import ObiletCalendar

struct OBCalendarDemo: View {
    
    let years: [CalendarModel.Year] = {
        let nineOctoberDateComponents = DateComponents(year: 2024,month: 10,day: 9)
        let nineOctober = Calendar.current.date(from: nineOctoberDateComponents)!
        let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: nineOctober)
        return CalendarModelBuilder.defaultLayout(
            startingDate: nineOctober,
            endingDate: nextYear!
        )
    }()
    var body: some View {
        VStack {
            calendarView
        }
        .padding()
    }
    
    var calendarView: some View {
        OBCalendar(years: years) { model, proxy in
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
}


#Preview {
    OBCalendarDemo()
}

