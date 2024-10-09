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
            Spacer()
            headerView
                .fixedSize(horizontal: false, vertical: true)
                .padding(12)
                .background(Color.red)
                .foregroundColor(.white)
            
            weekdaysView
                .padding(8)
                .background(Color.white)
                .compositingGroup()
                .shadow(color: .gray, radius: 1, x: 0, y: 2)
            
            calendarView
                .padding(4)
        }
    }
    
    var headerView: some View {
        HStack {
            Image(systemName: "calendar")
            Text("Departure Date")
            Spacer()
            Divider()
                .frame(width: 1)
                .background(Color.white)
            Image(systemName: "checkmark")
            Text("APPLY")
        }
    }
    
    var weekdaysView: some View {
        let weekdays = getShortLocalizedWeekdays()
        return HStack {
            ForEach(weekdays.indices, id: \.self) { index in
                Text(weekdays[index])
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    var calendarView: some View {
        OBCalendar(years: years) { model, proxy in
            // Day View goes here
            let day = model.day
            ZStack {
                switch day.rangeType {
                case .outOfRange(let dateType):
                    if dateType == .currentMonth {
                        Text("\(day.day)")
                            .foregroundColor(.gray)
                    }
                case .insideRange(let dateType):
                    if dateType == .currentMonth {
                        Text("\(day.day)")
                    }else {
                        Color.clear
                    }
                }
                
            }
            .frame(width: 35, height: 35)
        } monthContent: { model, proxy, daysView in
            // Month View goes here
            VStack {
                HStack {
                    Text(getMonthName(from: model.month.month))
                    Text(formatYear(model.year.year))
                }
                Divider()
                daysView
            }
            .padding(4)
        } yearContent: { model, proxy, monthsView in
            // Year view goes here
            monthsView
        }
    }
    
    func formatYear(_ year: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        return numberFormatter.string(from: NSNumber(value: year)) ?? ""
    }
    
    func makeDate(from month: Int) -> Date {
        let components = DateComponents(month: month)
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func getMonthName(from month: Int, localeIdentifier: String = Locale.current.identifier) -> String {
        let date = makeDate(from: month)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    
    func getShortLocalizedWeekdays(for localeIdentifier: String = Locale.current.identifier) -> [String] {
        // Create a Locale object from the localeIdentifier string
        let locale = Locale(identifier: localeIdentifier)
        
        // Use the default calendar and set the locale
        var calendar = Calendar.current
        calendar.locale = locale
        
        // Get the index of the first weekday (e.g., Sunday = 1, Monday = 2)
        let firstWeekday = calendar.firstWeekday
        
        // Get the localized short names of the weekdays (e.g., "Mon", "Tue", "Wed")
        let shortWeekdays = calendar.shortWeekdaySymbols
        
        // Rearrange the weekdays starting from the first weekday
        let firstWeekdayIndex = firstWeekday - 1 // Adjust because firstWeekday is 1-based
        let reorderedShortWeekdays = Array(shortWeekdays[firstWeekdayIndex...]) + Array(shortWeekdays[..<firstWeekdayIndex])
        
        // Return the reordered short weekday names
        return reorderedShortWeekdays
    }
}


#Preview {
    OBCalendarDemo()
}


