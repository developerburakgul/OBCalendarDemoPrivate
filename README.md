
# OBCalendar


- `OBCalendar` is designed to allow you to easily create your own custom calendars.With this structure, you can customize days, months, years. In additional you can change localization of calendar and display days within specific ranges.
- Users set the `startDate` and `endDate` in `OBCalendar`, and the range is created automatically.


## Documentation and Tutorial
- You can visit for the <a href="https://developerburakgul.github.io/OBCalendarDemoPrivate/documentation/obiletcalendar" target="_blank">documentation</a>
- You can visit for the <a href="https://developerburakgul.github.io/OBCalendarDemoPrivate/tutorials/obiletcalendar" target="_blank">tutorial</a> step by step

## Examples

<div align="center">
  <table>
    <tr>
      <th>Standart Calendar</th>
      <th>Single Date Selection Calendar</th>
      <th>Double Date Selection Calendar</th>
    </tr>
    <tr>
      <td><img width=300 src="https://github.com/developerburakgul/OBCalendarDemoPrivate/blob/main/Sources/OBCalendar/ObiletCalendar.docc/Resources/ForReadme/standartCalendar.png"></td>
      <td><img width=300 src="https://github.com/developerburakgul/OBCalendarDemoPrivate/blob/main/Sources/OBCalendar/ObiletCalendar.docc/Resources/ForReadme/singleDateCalendar.png"></td>
      <td><img width=300 src="https://github.com/developerburakgul/OBCalendarDemoPrivate/blob/main/Sources/OBCalendar/ObiletCalendar.docc/Resources/ForReadme/doubleDateCalendar.png"></td>
    </tr>
     <tr>
        <th>Special Day View Calendar</th>
        <th>Localization Calendar</th>
      </tr>
    <tr>
     <td><img width=300 src="https://github.com/developerburakgul/OBCalendarDemoPrivate/blob/main/Sources/OBCalendar/ObiletCalendar.docc/Resources/ForReadme/specialDayCalendar.png"></td>
      <td><img width=300 src="https://github.com/developerburakgul/OBCalendarDemoPrivate/blob/main/Sources/OBCalendar/ObiletCalendar.docc/Resources/ForReadme/localizationCalendar.png"></td>
    </tr>
  </table>
</div>

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
- The first model consists of `CalendarModel.Year`, `CalendarModel.Month` and `CalendarModel.Day` and a view is created for each day using this model in the first block
- The second model consists of `CalendarModel.Year` and `CalendarModel.Month`. In block 2, you can customize the view for each month by using this model and the collection of `day views` from the previous block and adding `daysView`.
- The third model consists of `CalendarModel.Year`.  In block 3, using this model and the collection of `month views` from the previous block, `monthsView` is created and you can customize the view for each year by adding












