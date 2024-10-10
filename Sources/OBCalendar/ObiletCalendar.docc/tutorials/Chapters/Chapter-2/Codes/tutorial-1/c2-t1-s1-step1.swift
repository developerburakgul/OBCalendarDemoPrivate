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
            ZStack {
                Text("\(model.day.day)")
            }
            .frame(width: 35, height: 35)
        } monthContent: { model, proxy, daysView in
            // Month View goes here
            VStack {
                HStack {
                    Text(getMonthName(from: model.month.month,by: localeIdentifier))
                    Text(formatYear(model.year.year))
                }
                Divider()
                daysView
            }
            
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
    
    func formatYear(_ year: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        return numberFormatter.string(from: NSNumber(value: year)) ?? ""
    }
    
    func getMonthName(from month: Int, by: String) -> String {
        let date = makeDate(from: month)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    
    func makeDate(from month: Int) -> Date {
        let components = DateComponents(month: month)
        return Calendar.current.date(from: components) ?? Date()
    }
    
}


#Preview {
    OBCalendarDemo()
}

