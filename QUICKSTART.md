# 🚀 Quick Start Guide - Expense Tracker App

## 5-Minute Setup

### Step 1: Get Dependencies (1 minute)

```bash
cd c:\Users\ASUS\expense_tracker
flutter pub get
```

### Step 2: Run the App (1 minute)

```bash
flutter run
```

### Step 3: Try It Out (3 minutes)

1. Go to **Add** tab
2. Enter: Title = "Lunch", Amount = "25.50", Category = "Food"
3. Tap "Add Expense"
4. Go to **Home** to see your total
5. Go to **Charts** to see graphs
6. Go to **History** to see all expenses

## Core Features at a Glance

| Feature         | How to Use           | Tab          |
| --------------- | -------------------- | ------------ |
| **Add Expense** | Fill form → Tap Add  | Add          |
| **View Total**  | See at top           | Home         |
| **View Charts** | Interactive graphs   | Charts       |
| **See History** | Full list with dates | History      |
| **Delete**      | Tap menu → Delete    | History/Home |

## Form Fields Explained

```
Expense Title   → What you spent on (e.g., "Lunch")
Amount          → How much (e.g., "25.50")
Category        → What type (e.g., "Food", "Transport")
Date            → When you spent (calendar picker)
Notes           → Extra details (optional)
```

## Navigation

```
App starts → Home Tab
           → Tap "Charts" to see analytics
           → Tap "Add" to add expense
           → Tap "History" to see list
```

## Example Walkthrough

### Adding Your First Expense

1. **Open App** → Starts on Home (empty)
2. **Tap "Add"** → Form appears
3. **Fill Form**
   - Title: "Coffee"
   - Amount: "4.50"
   - Category: "Food"
   - Date: Today
   - Notes: "Morning coffee"
4. **Tap "Add Expense"** → Success message
5. **See Results**
   - Home: Total shows $4.50
   - Charts: Food pie section appears
   - History: New entry at top

### Adding More Expenses

Add these to see charts in action:

- $50 - Transport - Gas
- $100 - Shopping - Clothes
- $30 - Entertainment - Movie
- $80 - Utilities - Electricity

Now you'll see:

- **Pie Chart**: Distribution of spending
- **Bar Chart**: Which category spent most
- **Statistics**: Averages, totals, highest

## Categories Quick Reference

| Category      | Emoji | Examples                        |
| ------------- | ----- | ------------------------------- |
| Food          | 🍔    | Restaurant, groceries, coffee   |
| Transport     | 🚗    | Gas, parking, bus, taxi         |
| Entertainment | 🎬    | Movies, games, concerts         |
| Utilities     | 💡    | Electric, water, internet bills |
| Shopping      | 🛍️    | Clothes, gadgets, accessories   |
| Health        | 🏥    | Doctor, gym, medicines          |
| Education     | 📚    | Books, courses, tuition         |
| Other         | ➕    | Everything else                 |

## Tips

✅ **Do This**

- Add expenses daily
- Use notes for details
- Check charts monthly
- Use correct categories

❌ **Don't Do This**

- Leave title blank
- Enter text in amount field
- Mix categories
- Forget to save

## Keyboard Shortcuts

| Action      | How                   |
| ----------- | --------------------- |
| Add Expense | Tap "Add" tab         |
| View Stats  | Tap "Charts" tab      |
| See All     | Tap "History" tab     |
| Delete      | Tap menu icon on card |
| Change Date | Tap date picker       |

## Common Issues & Quick Fixes

**Issue: App won't start**

```bash
flutter clean
flutter pub get
flutter run
```

**Issue: No data showing**
→ Add an expense first from "Add" tab

**Issue: Charts empty**
→ Refresh app or add more expenses

**Issue: Amount error**
→ Use numbers only (e.g., 25.50, not $25.50)

## What Each Tab Does

### 🏠 Home Tab

- Shows your total spent
- List expenses by category
- Shows recent transactions
- Quick overview of spending

### 📊 Charts Tab

- Pie chart (what you spent on)
- Bar chart (category comparison)
- Statistics (numbers & insights)
- Best for analysis

### ➕ Add Tab

- Form to add expenses
- Date picker for when
- Category selector
- Notes field
- Validation & feedback

### 📜 History Tab

- All expenses listed
- Newest first
- Color-coded by category
- Delete option
- Full transaction details

## Data Storage

✅ **Your data is:**

- Saved on your device only
- Never uploaded anywhere
- Completely private
- Works without internet
- Safe and secure

## Before & After

### Before Using App

- ❌ Don't know where money goes
- ❌ Can't track spending
- ❌ No visual insights
- ❌ Hard to budget

### After Using App

- ✅ Know exact spending
- ✅ Track by category
- ✅ See beautiful charts
- ✅ Easy budgeting

## Monthly Workflow

**Week 1**: Add expenses as you spend
**Week 2**: Check Home tab for total
**Week 3**: View Charts for trends
**Week 4**: Review History for details

## Quick Stats

After adding 10-15 expenses, you'll see:

- Clear pie chart distribution
- Highest and lowest categories
- Average per transaction
- Total spending visualization

## Advanced Tips

1. **Use Notes Field**

   - Reference numbers
   - Why you spent
   - Who with
   - Transaction details

2. **Pick Right Category**

   - Consistent categorization
   - Better analytics
   - Clearer breakdown
   - Easier tracking

3. **Set Dates Correctly**

   - When you actually spent
   - Easier to remember
   - Accurate history
   - Better reporting

4. **Review Monthly**
   - Check Charts tab
   - Look for patterns
   - Adjust budget
   - Set goals

## Goals

After 1 Month of Tracking:

- Know your spending patterns
- See biggest expense category
- Identify where to save
- Plan better budgets

After 3 Months:

- Clear spending trends
- Seasonal patterns visible
- Budget adjustments made
- Control spending increase

## Settings to Try

All features are ready to use! No setup needed.

## Backup Your Data

To save your data before reinstalling:

1. Note your expenses manually
2. Or screenshot the history
3. Data syncs when app reinstalled (if same device)

## Delete Everything

If you want to start fresh:

1. Go to Settings
2. Clear app data
3. App opens fresh
4. Start adding new expenses

## Screen Sizes

Works on:

- ✅ Phone (all sizes)
- ✅ Tablet (landscape/portrait)
- ✅ Web browser
- ✅ Different OS (Android/iOS)

---

## Next Steps

1. **Right Now**: Install app
2. **Day 1**: Add 5 expenses
3. **Day 7**: Check Charts tab
4. **Day 30**: Review patterns
5. **Day 90**: Adjust budget

## Questions?

Check these files:

- **SETUP_GUIDE.md** - Detailed setup
- **FEATURES.md** - All features explained
- **DEVELOPER_GUIDE.md** - Code details
- **DESIGN_SYSTEM.md** - UI/UX design

---

**You're all set! Start tracking! 💰**
