# 📚 API Reference & Method Documentation

Complete reference for all methods and classes in the Expense Tracker app.

## Class Reference

### Expense Class

Data model for individual expense transactions.

```dart
class Expense {
  final String id;              // Unique identifier
  final String title;           // Transaction title
  final double amount;          // Amount in dollars
  final String category;        // Category name
  final DateTime date;          // Transaction date
  final String? notes;          // Optional notes
}
```

#### Constructor

```dart
Expense({
  required String id,
  required String title,
  required double amount,
  required String category,
  required DateTime date,
  String? notes,
})
```

#### Methods

##### `toJson() → Map<String, dynamic>`

Converts Expense object to JSON for storage.

**Returns:** Map with all expense data as JSON-compatible types

**Example:**

```dart
Expense exp = Expense(
  id: '123',
  title: 'Lunch',
  amount: 25.50,
  category: 'Food',
  date: DateTime.now(),
  notes: 'Restaurant',
);

Map<String, dynamic> json = exp.toJson();
// Output: {
//   'id': '123',
//   'title': 'Lunch',
//   'amount': 25.50,
//   'category': 'Food',
//   'date': '2024-12-01T12:00:00.000Z',
//   'notes': 'Restaurant'
// }
```

##### `fromJson(Map<String, dynamic> json) → Expense` (Factory)

Creates Expense object from JSON data.

**Parameters:**

- `json`: Map containing expense data

**Returns:** New Expense instance

**Example:**

```dart
Map<String, dynamic> json = {
  'id': '123',
  'title': 'Lunch',
  'amount': 25.50,
  'category': 'Food',
  'date': '2024-12-01T12:00:00.000Z',
  'notes': 'Restaurant'
};

Expense expense = Expense.fromJson(json);
```

---

## State Methods (\_ExpenseHomeState)

### Data Management

#### `loadExpenses() → Future<void>`

Loads all expenses from local storage.

**Behavior:**

- Reads from SharedPreferences key "expenses"
- Parses JSON data
- Converts to Expense objects
- Sorts by date (newest first)
- Updates UI

**Example:**

```dart
await loadExpenses();
// expenses list now contains all stored data
```

#### `saveExpenses() → Future<void>`

Saves all current expenses to local storage.

**Behavior:**

- Converts each Expense to JSON
- Creates JSON array
- Stores in SharedPreferences
- Auto-called after changes

**Example:**

```dart
await saveExpenses();
// Data persisted to device
```

### Expense Operations

#### `addExpense() → void`

Adds a new expense from form data.

**Validation:**

- Checks title is not empty
- Checks amount is not empty
- Shows error snackbar if invalid

**Behavior:**

- Creates new Expense with unique ID
- Adds to expenses list
- Sorts by date
- Saves to storage
- Clears form
- Shows success message

**Example:**

```dart
// User fills form and taps "Add Expense"
addExpense();
// Expense added, form cleared, success shown
```

#### `deleteExpense(String id) → void`

Deletes expense with confirmation dialog.

**Parameters:**

- `id`: Unique ID of expense to delete

**Behavior:**

- Shows confirmation dialog
- Removes from list if confirmed
- Saves changes
- Shows success message

**Example:**

```dart
deleteExpense('1701561600000');
// Shows "Delete Expense?" dialog
// Removes if user confirms
```

#### `clearForm() → void`

Resets all form fields to initial state.

**Clears:**

- titleController text
- amountController text
- notesController text
- selectedDate to today
- selectedCategory to first category

**Example:**

```dart
clearForm();
// All form fields reset
```

### Calculation Methods

#### `getTotalExpenses() → double`

Calculates total of all expenses.

**Returns:** Sum of all expense amounts

**Example:**

```dart
double total = getTotalExpenses();
// Returns: 1250.50
```

#### `getTotalByCategory(String category) → double`

Calculates total for specific category.

**Parameters:**

- `category`: Category name to sum

**Returns:** Sum of expenses in that category

**Example:**

```dart
double foodTotal = getTotalByCategory('Food');
// Returns: 450.00 (if Food category total is 450)
```

### UI Building Methods

#### `build(BuildContext context) → Widget`

Main build method for the screen.

**Returns:** Complete scaffold with navigation

**Behavior:**

- Shows different tab based on \_selectedIndex
- Bottom navigation bar for tab switching
- AppBar with title

#### `_buildHomeTab() → Widget`

Builds the Home tab content.

**Displays:**

- Total expenses gradient card
- Category breakdown with progress bars
- Recent 5 expenses

**Returns:** SingleChildScrollView with Column

#### `_buildChartsTab() → Widget`

Builds the Charts tab content.

**Displays:**

- Pie chart (if expenses exist)
- Bar chart
- Statistics grid

**Returns:** SingleChildScrollView with charts

#### `_buildAddExpenseTab() → Widget`

Builds the Add Expense form tab.

**Displays:**

- Title input field
- Amount input field
- Category dropdown
- Date picker
- Notes textarea
- Add button

**Returns:** Form widgets in Column

#### `_buildHistoryTab() → Widget`

Builds the expense history list.

**Displays:**

- All expenses sorted by date
- Empty state if no expenses

**Returns:** ListView or empty message

#### `_buildPieChart() → Widget`

Creates pie chart visualization.

**Data:**

- One section per category
- Only non-zero categories
- Category color as section color

**Returns:** PieChart widget

**Example Output:**

```
      Food 36%
    ╱          ╲
   │  Transport  │ 24%
   │  24%   Other│
    ╲    18%    ╱
      ╲──────╱
```

#### `_buildBarChart() → Widget`

Creates bar chart visualization.

**Data:**

- One bar per category
- Height = category total
- Color = category color

**Returns:** BarChart widget

#### `_buildStatisticsGrid() → Widget`

Creates 2x2 grid of statistics.

**Cards:**

1. Total Transactions (count)
2. Average Expense (total/count)
3. Highest Expense (max amount)
4. Top Category (highest sum)

**Returns:** GridView widget

#### `_buildStatCard(String label, String value, Color color) → Widget`

Creates individual statistic card.

**Parameters:**

- `label`: Stat name (e.g., "Average Expense")
- `value`: Stat value (e.g., "$104.21")
- `color`: Card color

**Returns:** Container with stat display

#### `_buildExpenseCard(Expense expense) → Widget`

Creates card for single expense.

**Displays:**

- Category icon and name
- Expense title
- Date formatted
- Amount in green
- Delete menu

**Returns:** Card widget

#### `_buildCategoryItem(String category, double amount) → Widget`

Creates category summary card.

**Displays:**

- Category color dot
- Category name
- Total amount
- Progress bar
- Percentage

**Returns:** Container widget

### Helper Methods

#### `_getCategoryIcon(String category) → IconData`

Gets icon for category name.

**Parameters:**

- `category`: Category name

**Returns:** Appropriate IconData

**Mapping:**

```dart
'Food' → Icons.fastfood
'Transport' → Icons.directions_car
'Entertainment' → Icons.movie
'Utilities' → Icons.lightbulb
'Shopping' → Icons.shopping_bag
'Health' → Icons.health_and_safety
'Education' → Icons.school
'Other' → Icons.category
```

---

## State Variables

### Collections

```dart
List<Expense> expenses = [];
// All expense data, sorted by date (newest first)

List<String> categories = [
  'Food',
  'Transport',
  'Entertainment',
  'Utilities',
  'Shopping',
  'Health',
  'Education',
  'Other'
];
// Available expense categories

Map<String, Color> categoryColors = {
  'Food': Colors.orange,
  'Transport': Colors.blue,
  // ... etc
};
// Color for each category
```

### Controllers

```dart
TextEditingController titleController;
// Controls expense title input

TextEditingController amountController;
// Controls amount input

TextEditingController notesController;
// Controls notes input
```

### UI State

```dart
int _selectedIndex = 0;
// Current tab (0=Home, 1=Charts, 2=Add, 3=History)

String? selectedCategory;
// Selected category for new expense

DateTime selectedDate = DateTime.now();
// Selected date for new expense
```

---

## Life Cycle Methods

### initState()

Called once when widget is created.

```dart
@override
void initState() {
  super.initState();
  selectedCategory = categories[0];
  loadExpenses();  // Load from storage
}
```

### dispose()

Called when widget is destroyed.

```dart
@override
void dispose() {
  titleController.dispose();
  amountController.dispose();
  notesController.dispose();
  super.dispose();
}
```

---

## Callback Functions

### setState()

Triggers rebuild when state changes.

```dart
setState(() {
  expenses.add(newExpense);
});
// UI updates with new data
```

### onTap Navigation

```dart
onTap: (index) => setState(() => _selectedIndex = index)
// Updates current tab when user taps bottom nav
```

### onChanged Dropdown

```dart
onChanged: (value) => setState(() => selectedCategory = value)
// Updates selected category
```

### onPressed Button

```dart
onPressed: addExpense
// Calls addExpense when button tapped
```

---

## Dialog & Snackbar Methods

### Show Delete Confirmation

```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Delete Expense?'),
    actions: [...],
  ),
)
```

### Show Success Message

```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Expense added successfully')),
);
```

### Show Error Message

```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Please fill all fields')),
);
```

---

## Data Flow Examples

### Adding an Expense

```
1. User fills form
2. User taps "Add Expense"
3. addExpense() called
4. Input validation
5. Create Expense object
6. Add to expenses list
7. Sort by date
8. setState() → rebuild UI
9. saveExpenses() → persist data
10. clearForm()
11. Show success snackbar
```

### Deleting an Expense

```
1. User taps delete button
2. showDialog() appears
3. User confirms
4. deleteExpense(id) called
5. Remove from list
6. setState() → rebuild UI
7. saveExpenses() → persist data
8. Show success snackbar
```

### Loading Data

```
1. App starts
2. initState() called
3. loadExpenses() called
4. Read from SharedPreferences
5. Parse JSON
6. Convert to Expense objects
7. Sort by date
8. setState() → populate UI
```

---

## Constants

```dart
// Storage key
const String EXPENSES_KEY = "expenses";

// Category list (8 total)
static const List<String> CATEGORIES = [
  'Food',
  'Transport',
  'Entertainment',
  'Utilities',
  'Shopping',
  'Health',
  'Education',
  'Other'
];
```

---

## Validation Rules

```
Title:
- Required (non-empty)
- Any string allowed
- Max length: no limit

Amount:
- Required (non-empty)
- Numeric only (double)
- Positive values only
- 2 decimal places

Category:
- Required
- Must be in categories list
- Case sensitive

Date:
- Required
- Past or current date
- Max date: today

Notes:
- Optional
- Any string allowed
- Max length: no limit
```

---

## Error Handling

### Try-Catch

```dart
try {
  Expense newExpense = Expense(...);
  // Add expense
} catch (e) {
  // Show error snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error adding expense')),
  );
}
```

### Validation Checks

```dart
if (titleController.text.isEmpty) {
  // Show error
}

if (amountController.text.isEmpty) {
  // Show error
}
```

---

## Performance Considerations

### List Operations

- Add: O(1) - append to list
- Delete: O(n) - removeWhere
- Sort: O(n log n) - after each change
- Search: O(n) - linear scan

### Storage

- Save: Serializes to JSON, writes to disk
- Load: Reads from disk, deserializes JSON
- Time: < 100ms typically

### Charts

- Pie: Generates sections for each category
- Bar: Creates bars for each category
- Render time: < 500ms

---

## Best Practices

1. **Always validate input** before processing
2. **Show user feedback** via snackbars
3. **Persist data** immediately after changes
4. **Sort consistently** (date descending)
5. **Use proper types** (Expense class, not Map)
6. **Handle errors gracefully** with try-catch
7. **Clean up resources** in dispose()

---

**API Reference Complete ✓**
