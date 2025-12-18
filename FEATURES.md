# 💰 Expense Tracker App - Complete Feature List

A fully functional Flutter expense tracking application with advanced analytics and beautiful UI.

## ✨ Features

### 1. **Home Dashboard** 🏠

- Total expenses summary with gradient card
- Category-wise spending breakdown
- Progress bars showing percentage distribution
- Recent expenses preview (last 5 transactions)
- Color-coded categories for easy identification

### 2. **Charts & Analytics** 📊

- **Pie Chart**: Visual representation of expense distribution across categories
- **Bar Chart**: Spending breakdown by category with detailed labels
- **Statistics Grid**: Key metrics including:
  - Total number of transactions
  - Average expense amount
  - Highest expense recorded
  - Top spending category

### 3. **Add Expense Form** ➕

- Intuitive form with multiple input fields
- **Title**: Name of the expense
- **Amount**: Expense amount (numeric input)
- **Category**: Dropdown selector with 8 predefined categories
- **Date Picker**: Calendar interface to select expense date
- **Notes**: Optional notes/description field
- Real-time validation with user feedback
- Success/error notifications

### 4. **Expense History** 📝

- Complete list of all expenses sorted by date (newest first)
- Detailed expense cards showing:
  - Expense title with bold font
  - Category with color indicator
  - Date in readable format (MMM dd, yyyy)
  - Notes preview (if available)
  - Amount in green for quick scanning
- Quick delete option via popup menu
- Empty state message when no expenses exist

### 5. **Categories** 🏷️

8 predefined expense categories with color coding:

- 🍔 **Food** (Orange)
- 🚗 **Transport** (Blue)
- 🎬 **Entertainment** (Purple)
- 💡 **Utilities** (Green)
- 🛍️ **Shopping** (Pink)
- 🏥 **Health** (Red)
- 📚 **Education** (Indigo)
- ➕ **Other** (Grey)

### 6. **Data Management** 💾

- Local storage using SharedPreferences
- Automatic data persistence
- JSON serialization for complex data types
- Data backup on every change
- Load data on app startup

### 7. **UI/UX Features** 🎨

- Material Design 3 with modern styling
- Bottom navigation bar for easy tab switching
- Gradient cards for visual appeal
- Smooth animations and transitions
- Rounded corners and shadows
- Responsive layout for different screen sizes
- Color-coded icons for each category
- Empty states with helpful messages

### 8. **User Interactions** 🎯

- Add expense with validation
- Delete expenses with confirmation dialog
- Date picker for expense date selection
- Category dropdown for easy selection
- Snackbar notifications for user feedback
- Clear form after successful entry

## 📱 Navigation

The app uses a 4-tab bottom navigation:

1. **Home** - Dashboard with summary and recent expenses
2. **Charts** - Analytics and visual representations
3. **Add** - Form to add new expenses
4. **History** - Complete expense list

## 🔧 Technical Details

### Dependencies

- `flutter` - UI framework
- `shared_preferences` - Local data storage
- `fl_chart` - Charts and graphs library
- `intl` - Date and number formatting

### Architecture

- Stateful Widget for state management
- Single Expense class for data modeling
- Custom helper methods for calculations
- Proper widget composition and reusability

### Data Structure

```dart
class Expense {
  String id;           // Unique identifier
  String title;        // Expense name
  double amount;       // Amount spent
  String category;     // Category
  DateTime date;       // Date of expense
  String? notes;       // Optional notes
}
```

## 🎯 Key Calculations

- **Total Expenses**: Sum of all amounts
- **Category Totals**: Sum per category
- **Percentages**: Category amount / Total × 100
- **Average**: Total / Number of expenses
- **Max/Min**: Highest and lowest amounts

## 📊 Data Persistence

All data is stored locally using SharedPreferences in JSON format:

- Key: "expenses"
- Value: JSON array of expense objects
- Automatic save on every change
- Auto-load on app startup

## 🎨 Color Scheme

- Primary: Blue (#2196F3)
- Success: Green (#4CAF50)
- Warning: Orange (#FF9800)
- Error: Red (#F44336)
- Category Colors: Unique color per category

## 💡 Usage Tips

1. **Add Expense**: Tap the "Add" tab to add a new expense
2. **View Charts**: Tap "Charts" to see visual analytics
3. **Delete Expense**: Long-press amount or use popup menu
4. **Filter by Date**: Use the date picker when adding expenses
5. **View History**: Tap "History" for complete expense list

## 🚀 Future Enhancements

Possible features to add:

- Budget tracking with limits
- Monthly/yearly reports
- Export to CSV/PDF
- Multiple currencies
- Income tracking
- Recurring expenses
- Search and filtering
- Edit existing expenses
- Backup to cloud
- Dark theme
- Multi-language support

## 📄 License

This expense tracker app is built with Flutter and is free to use and modify.

---

**Enjoy tracking your expenses! 💸**
