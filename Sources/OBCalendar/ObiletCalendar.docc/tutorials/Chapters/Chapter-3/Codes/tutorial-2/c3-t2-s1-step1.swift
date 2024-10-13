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
    
    @State var firstSelectedDate: Date?
    
    init(calendar: Calendar) {
        self.calendar = calendar
        self.years = Self.getYears(from: calendar)
    }
    
    var body: some View {
        VStack {
            Spacer()
            headerView
                .fixedSize(horizontal: false, vertical: true)
                .padding(16)
                .background(Color.red)
                .foregroundColor(.white)
            
            daysView
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
    
    var daysView: some View {
        let days = getShortLocalizedWeekdays(for: calendar)
        return HStack {
            ForEach(days.indices, id: \.self) { index in
                Text(days[index])
                    .frame(maxWidth: .infinity)
            }
        }
        
    }
    
    var calendarView: some View {
        OBCalendar(years: years) { model, scrollProxy in
            // Day View goes here
            let day = model.day
            let today = calendar.startOfDay(for: Date())
            let dayDate = calendar.startOfDay(for: day.date)
            ZStack {
                if case .insideRange(.currentMonth) = day.rangeType {
                    if (dayDate < today) {
                        Text("\(day.day)")
                            .foregroundColor(.gray)
                    }else {
                        firstSelectedDate == day.date
                        ?
                        Text("\(day.day)")
                            .foregroundColor(.white)
                        :
                        Text("\(day.day)")
                            .foregroundColor(.black)
                        
                    }
                }
            }
            .frame(width: 35, height: 35)
            .onTapGesture {
                if case .insideRange(.currentMonth) = day.rangeType {
                    if dayDate >= today {
                        firstSelectedDate = day.date
                    }
                }
            }
            .background {
                if case .insideRange(.currentMonth) = day.rangeType,case firstSelectedDate = day.date {
                    Circle()
                        .foregroundColor(.green)
                }
            }
        } monthContent: { model, scrollProxy, daysView in
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
        } yearContent: { model, scrollProxy, monthsView in
            // Year View goes here
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
        return calendar.date(from: components) ?? Date()
    }
    
    func getMonthName(
        from month: Int
    ) -> String {
        let date = makeDate(from: month)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: calendar.locale?.identifier ?? "")
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    
    func getShortLocalizedWeekdays(
        for calendar: Calendar
    ) -> [String] {
        let firstWeekday = calendar.firstWeekday
        
        let shortWeekdays = calendar.shortWeekdaySymbols
        let firstWeekdayIndex = firstWeekday - 1
        
        let reorderedShortWeekdays = Array(shortWeekdays[firstWeekdayIndex...])
        + Array(shortWeekdays[..<firstWeekdayIndex])
        
        return reorderedShortWeekdays
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

