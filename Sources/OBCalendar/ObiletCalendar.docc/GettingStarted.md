#  Getting Started


## Requirements
- iOS 14+
- Swift 5.10+

## Installation
To integrate `OBCalendar` into your project using Swift Package Manager, follow these steps:
- Open your Xcode project.
- Go to File > Add Packages.
- In the search bar, enter the following URL :
  
    ```
    https://github.com/oBilet/OBCalendar.git
    ```
- Choose the package version or branch and click Add Package.

## Usage
```swift
let today = Date()
let twoYearsLater = calendar.date(byAdding: .year, value: 2, to: today)!
return OBCalendar(startingDate: today, endingDate: twoYearsLater) { model, scrollProxy in
    // day view goes here
    let day = model.day
    Text("\(day.day)")
} monthContent: { model, scrollProxy, daysView in
    // month view goes here
    daysView
} yearContent: { model, scrollProxy, monthsView in
    // year view goes here
      monthsView
}
```
- You can create `OBCalendar` specifying `startingDate` and `endingDate`.
- The first model consists of  [Year](doc://ObiletCalendar/CalendarModel/Year)
, [Month](doc://ObiletCalendar/CalendarModel/Month) and [Day](doc://ObiletCalendar/CalendarModel/Day) and a view is created for each day using this model in the first block
- The second model consists of [Year](doc://ObiletCalendar/CalendarModel/Year) and [Month](doc://ObiletCalendar/CalendarModel/Month). In block 2, you can customize the view for each month by using this model and the collection of `day views` from the previous block and adding `daysView`.
- The third model consists of [Year](doc://ObiletCalendar/CalendarModel/Year).  In block 3, using this model and the collection of `month views` from the previous block, `monthsView` is created and you can customize the view for each year by adding
