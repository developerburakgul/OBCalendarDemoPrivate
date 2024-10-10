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
        let weekdays = getShortLocalizedWeekdays(for: localeIdentifier)
        return HStack {
            ForEach(weekdays.indices, id: \.self) { index in
                Text(weekdays[index])
                    .frame(maxWidth: .infinity)
            }
        }
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
                    Text(getMonthName(from: model.month.month,by: localeIdentifier))
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
    
    func getShortLocalizedWeekdays(for localeIdentifier: String) -> [String] {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: localeIdentifier)
        let firstWeekday = calendar.firstWeekday
        let shortWeekdays = calendar.shortWeekdaySymbols
        let firstWeekdayIndex = firstWeekday - 1
        return Array(shortWeekdays[firstWeekdayIndex...]) + Array(shortWeekdays[..<firstWeekdayIndex])
    }
    
}


#Preview {
    OBCalendarDemo()
}

