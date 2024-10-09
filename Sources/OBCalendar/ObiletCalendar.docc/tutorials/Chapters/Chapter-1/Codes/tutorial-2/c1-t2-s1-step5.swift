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
            ZStack {
                Text("\(model.day.day)")
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
}


#Preview {
    OBCalendarDemo()
}

