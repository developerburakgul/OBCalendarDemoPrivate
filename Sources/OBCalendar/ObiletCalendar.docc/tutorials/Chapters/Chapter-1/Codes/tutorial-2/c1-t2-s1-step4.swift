//
//  OBCalendarDemo.swift
//  OBCalendarDemo
//
//  Created by Burak on 7.10.2024.
//

import SwiftUI
import ObiletCalendar

struct OBCalendarDemo: View {
    let years: [CalendarModel.Year]
    let calendar: Calendar
    
    init(calendar: Calendar) {
        self.calendar = calendar
        self.years = Self.getYears(from: calendar)
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
    
    var calendarView: some View {
        OBCalendar(years: years) { model, scrollProxy in
            // Day View goes here
            Text("\(model.day.day)")
        } monthContent: { model, scrollProxy, daysView in
            // Month View goes here
            daysView
        } yearContent: { model, scrollProxy, monthsView in
            // Year View goes here
            monthsView
        }

    }

}

private extension OBCalendarDemo {
    static func getYears(from calendar: Calendar) -> [CalendarModel.Year] {
        let elevenOctoberDateComponents = DateComponents(year: 2024, month: 10, day: 11)
        let elevenOctober = Calendar.current.date(from: elevenOctoberDateComponents)!
        
        let startingDayOfMonth = Self.getStartDayOfMonth(from: elevenOctober, calendar: calendar)
        let nextYear = calendar.date(byAdding: .year, value: 1, to: startingDayOfMonth)!
        let endingDayOfMonth = Self.getEndDayOfMonth(from: nextYear, calendar: calendar)
        
        return CalendarModelBuilder.defaultLayout(
            calendar: calendar,
            startingDate: startingDayOfMonth,
            endingDate: endingDayOfMonth
        )
    }
    
    static func getStartDayOfMonth(from date: Date, calendar: Calendar) -> Date {
        let startDateComponents = DateComponents(
            year: calendar.component(.year, from: date),
            month: calendar.component(.month, from: date),
            day: 1
        )
        return calendar.date(from: startDateComponents) ?? Date()
    }
    
    static func getEndDayOfMonth(from date: Date, calendar: Calendar) -> Date {
        
        if let range = calendar.range(of: .day, in: .month, for: date) {
            let lastDay = range.count
            let endDateComponents = DateComponents(
                year: calendar.component(.year, from: date),
                month: calendar.component(.month, from: date),
                day: lastDay
            )
            return calendar.date(from: endDateComponents) ?? Date()
        }
        return Date()
    }
}

#Preview {
    var calendar = Calendar.current
    calendar.locale = Locale(identifier: "en_US")
    return OBCalendarDemo(calendar: calendar)
}

