# 🚀 Setup & Usage Guide - Expense Tracker App

## Prerequisites

- Flutter SDK (version 3.9.2 or higher)
- Dart SDK
- Android Studio or Xcode (for iOS)
- A code editor (VS Code recommended)

## Installation Steps

### 1. Clone/Open the Project

```bash
cd c:\Users\ASUS\expense_tracker
```

### 2. Get Dependencies

```bash
flutter pub get
```

This will install all required packages:

- `shared_preferences` - For local data storage
- `fl_chart` - For charts and graphs
- `intl` - For date formatting

### 3. Run the App

**For Android:**

```bash
flutter run
```

**For iOS:**

```bash
flutter run -i
```

**For Web:**

```bash
flutter run -w
```

## App Structure

```
lib/
├── main.dart           # Main application file
│   ├── ExpenseApp      # Root widget
│   ├── Expense         # Data model class
│   └── ExpenseHome     # Main screen with navigation
```

## How to Use

### Adding an Expense

1. Tap the **"Add"** tab in the bottom navigation
2. Fill in the expense details:
   - **Expense Title**: Name of what you spent on
   - **Amount**: How much you spent
   - **Category**: Select from 8 categories
   - **Date**: Tap to select the date
   - **Notes**: Add optional details (optional)
3. Tap **"Add Expense"** button
4. You'll see a success message

### Viewing Dashboard

1. Tap the **"Home"** tab
2. See your total expenses at the top (gradient card)
3. View category-wise breakdown with progress bars
4. See recent 5 expenses below

### Viewing Analytics

1. Tap the **"Charts"** tab
2. View:
   - **Pie Chart**: Expense distribution visualization
   - **Bar Chart**: Category-wise spending
   - **Statistics**: Key metrics and insights

### Viewing History

1. Tap the **"History"** tab
2. See all expenses in chronological order (newest first)
3. Each card shows:
   - Category icon and name
   - Date and amount
   - Optional notes
4. Tap the amount/menu to delete an expense

### Deleting an Expense

**Method 1:** From History

1. Go to History tab
2. Tap the amount or menu icon
3. Select "Delete"
4. Confirm deletion

**Method 2:** From Home

1. Recent expenses section shows delete option
2. Tap to remove

## Data Storage

All data is stored locally on your device using SharedPreferences:

- **Location**: Device's app data folder
- **Format**: JSON
- **Auto-save**: Every operation saves automatically
- **No Internet**: Works completely offline

## Categories Explained

| Category      | Icon        | Color  | Use For                       |
| ------------- | ----------- | ------ | ----------------------------- |
| Food          | 🍔 Fastfood | Orange | Restaurants, groceries        |
| Transport     | 🚗 Car      | Blue   | Fuel, parking, public transit |
| Entertainment | 🎬 Movie    | Purple | Movies, games, hobbies        |
| Utilities     | 💡 Bulb     | Green  | Electricity, water, internet  |
| Shopping      | 🛍️ Bag      | Pink   | Clothes, accessories, items   |
| Health        | 🏥 Hospital | Red    | Medical, medicines, gym       |
| Education     | 📚 School   | Indigo | Tuition, books, courses       |
| Other         | ➕ Plus     | Grey   | Miscellaneous                 |

## Features Overview

### ✅ Home Tab

- Total expenses summary
- Category breakdown with percentages
- Recent transactions
- Visual progress bars

### ✅ Charts Tab

- Pie chart for distribution
- Bar chart for comparison
- Statistics cards (total, average, max, top category)

### ✅ Add Tab

- Complete form with validation
- Date picker calendar
- Category dropdown
- Notes field for details

### ✅ History Tab

- Complete expense list
- Color-coded categories
- Sorted by date (newest first)
- Quick delete functionality

## Tips & Tricks

1. **Bulk View**: Tap "Home" to see quick summary
2. **Deep Dive**: Tap "Charts" for detailed analytics
3. **Date Selection**: Use calendar picker for past/future dates
4. **Categories**: Each category has its own color
5. **Notes**: Use for transaction reference or details
6. **Sorting**: Always sorted by date (newest first)
7. **Calculations**: Automatic sum, average, and percentages

## Troubleshooting

### Issue: App won't start

**Solution**: Run `flutter clean` then `flutter pub get` again

### Issue: Dependencies not loading

**Solution**: Delete `pubspec.lock` and run `flutter pub get`

### Issue: Data not persisting

**Solution**: Ensure app has storage permissions on Android

### Issue: Charts not showing

**Solution**: Make sure you have at least one expense added

## Customization

### Change App Theme

Edit in `main.dart` line 13:

```dart
theme: ThemeData(
  primarySwatch: Colors.blue,  // Change this color
  useMaterial3: true,
),
```

### Add New Category

1. Add to `categories` list (line 77)
2. Add color mapping in `categoryColors` (line 84)
3. Add icon in `_getCategoryIcon()` method

### Change Storage Key

Edit in `loadExpenses()` and `saveExpenses()`:

```dart
prefs.getString("expenses");  // Change "expenses" to your key
```

## Performance Notes

- App uses minimal memory (optimized state management)
- Local storage is fast and doesn't require internet
- Charts are optimized for smooth rendering
- No external API calls

## File Size

- Source code: ~8KB
- Dependencies: ~10MB
- Compiled app: ~15-20MB (varies by platform)

## Privacy & Security

- ✅ All data stored locally
- ✅ No cloud uploads
- ✅ No tracking or analytics
- ✅ No personal data collection
- ✅ Works completely offline

## Support

For issues or questions:

1. Check the FEATURES.md file
2. Review the code comments
3. Check Flutter documentation at flutter.dev

---

**Happy Expense Tracking! 💰**
