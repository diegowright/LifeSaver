# Life-Saver

# 1: Implementation Contribution
Diego Wright 50%
- Medical event tab
- Data I/O for large part of app
- Calendar tab
- Data plotting tab
- Theming

Robin Stewart 25%
- Initial setup of calendar tab
- Medicine tracker tab
- Food tracker

William Zhang 25%
- Login/Registration
- Settings tab
- Initial setup of plot tab

# 2: Grading Level
Same level

# 3: Differences
- Plotting tab does not have as robust of features as we wanted because it is quite complicated to go sorting through all the data as it is loosely organized.
- Medical Event tab is not editable, got bogged down in other stuff for this feature
- Medicine tracker only has one reminder setting (daily)
- Settings doesn't have data exporter, and themes are wonky.

# 4: Special Instructions
- need to have version 1.1.0+ of CocoaPods
- JTAppleCalendar version 6.1 is used
- JBChart version 3.0.13 is used
- If the plot tab crashes the app there is probably no medical event data entered, and so to fix that create a medical event and add in at least one entry for that event type. It may still crash otherwise but reloading the app and avoiding that page will solve that.
- Selecting a theme may severely screw up the way the app looks, if so reload the app and it should go back to the default