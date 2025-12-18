# 🎬 Visual Guide - Expense Tracker App Screenshots & Flows

Complete visual walkthrough of the app with descriptions.

---

## 📱 App Screenshots & Descriptions

### Screen 1: Home Tab (Dashboard)

```
┌─────────────────────────────────┐
│   Expense Tracker      [···]     │  ← AppBar
├─────────────────────────────────┤
│                                 │
│  ╔═════════════════════════════╗│
│  ║   Total Expenses            ║│
│  ║   $1,250.50                 ║│
│  ╚═════════════════════════════╝│  ← Total Card
│                                 │     (Gradient Blue)
│  By Category                    │
│  ┌─────────────────────────────┐│
│  │ ● Food               $450    ││
│  │ ████████░░░░░░░░░░ 36.0%    ││
│  └─────────────────────────────┘│
│                                 │
│  ┌─────────────────────────────┐│
│  │ ● Transport          $300    ││
│  │ ██████░░░░░░░░░░░░░ 24.0%   ││
│  └─────────────────────────────┘│  ← Category Items
│                                 │     (Progress Bars)
│  ┌─────────────────────────────┐│
│  │ ● Shopping           $225    ││
│  │ ███████░░░░░░░░░░░░ 18.0%   ││
│  └─────────────────────────────┘│
│                                 │
│  Recent Expenses                │
│  ┌─────────────────────────────┐│
│  │🍔 Lunch              $50.00 │┃│
│  │   Food • Dec 01             │┃│
│  └─────────────────────────────┘│
│                                 │
│  ┌─────────────────────────────┐│
│  │🚗 Gas Refill         $40.00 │┃│
│  │   Transport • Nov 30        │┃│
│  └─────────────────────────────┘│  ← Recent Expenses
│                                 │
│  ┌─────────────────────────────┐│
│  │🛍️  Clothes          $120.00 │┃│
│  │   Shopping • Nov 28         │┃│
│  └─────────────────────────────┘│
│                                 │
├─────────────────────────────────┤
│ 🏠 Home │📊 Charts│➕ Add│📜 Hist│  ← BottomNavBar
└─────────────────────────────────┘
```

**Purpose:** Quick overview of total spending and recent transactions

**Key Elements:**

- Gradient card with total
- Category list with progress bars
- Recent 5 expenses
- Color-coded categories

**Interactions:**

- Scroll to see all content
- Tap category to (future feature)
- Tap recent expense to view details

---

### Screen 2: Charts Tab (Analytics)

```
┌─────────────────────────────────┐
│   Expense Tracker      [···]     │
├─────────────────────────────────┤
│                                 │
│  Expense Distribution           │
│                                 │
│         ╱─ Food ─╲             │
│       ╱   $450    ╲            │
│      │  Transport   │           │
│      │   $300      │           │
│      │  Shopping   │           │  ← Pie Chart
│      │   $225     │            │
│       ╲  Other  ╱             │
│         ╲─────╱                │
│                                 │
│  Spending by Category           │
│  │                              │
│  │ $500 ┌─────┐                │
│  │      │ ┌─┐ │                │
│  │ $400 │ │ │ │ ┌─┐            │
│  │      │ │ │ │ │ │            │
│  │      │ │ │ │ │ │            │
│  │      │ │ │ │ │ │            │
│  │      │ │ │ │ │ │ ┌─┐       │
│  │ $0───┴─┴─┴─┴─┴─┴─┴─┴─┘     │  ← Bar Chart
│  │  Foo Tra Ent Uti Sho Hea   │
│                                 │
│  Statistics                     │
│  ┌────────────┐ ┌────────────┐ │
│  │ Transacti. │ │  Average   │ │
│  │     12     │ │  $104.21   │ │
│  └────────────┘ └────────────┘ │
│  ┌────────────┐ ┌────────────┐ │  ← Statistics Grid
│  │  Highest   │ │  Category  │ │
│  │   $250     │ │    Food    │ │
│  └────────────┘ └────────────┘ │
│                                 │
├─────────────────────────────────┤
│ 🏠 Home │📊 Charts│➕ Add│📜 Hist│
└─────────────────────────────────┘
```

**Purpose:** Visual analytics and spending insights

**Key Elements:**

- Pie chart (distribution)
- Bar chart (comparison)
- Statistics cards (metrics)

**Displays:**

- Expense breakdown by category
- Spending trends
- Key metrics (count, average, max)
- Top spending category

---

### Screen 3: Add Expense Tab (Form)

```
┌─────────────────────────────────┐
│   Expense Tracker      [···]     │
├─────────────────────────────────┤
│                                 │
│  Add New Expense                │
│                                 │
│  Expense Title                  │
│  ┌─────────────────────────────┐│
│  │ ✎ Lunch at restaurant  │     │
│  └─────────────────────────────┘│  ← Text Input
│                                 │
│  Amount                         │
│  ┌─────────────────────────────┐│
│  │ $ 45.50                 │    │
│  └─────────────────────────────┘│  ← Amount Input
│                                 │
│  Category                       │
│  ┌─────────────────────────────┐│
│  │ ▼ Food              [→]  │   │
│  └─────────────────────────────┘│  ← Dropdown
│                                 │
│  Date                           │
│  Dec 01, 2024                [→]│
│  (Tap to change)                │  ← Date Picker
│                                 │
│  Notes (Optional)               │
│  ┌─────────────────────────────┐│
│  │ Had lunch with friends at   │
│  │ downtown restaurant with    │
│  │ Sarah and Mike              │
│  └─────────────────────────────┘│  ← Notes Input
│                                 │
│  ┌─────────────────────────────┐│
│  │  ADD EXPENSE                ││
│  └─────────────────────────────┘│  ← Submit Button
│                                 │
├─────────────────────────────────┤
│ 🏠 Home │📊 Charts│➕ Add│📜 Hist│
└─────────────────────────────────┘
```

**Purpose:** Input form to add new expenses

**Key Elements:**

- Title field
- Amount field
- Category dropdown
- Date picker
- Notes textarea
- Submit button

**Validation:**

- Title required
- Amount required (numeric)
- Category pre-selected
- Date defaults to today
- Notes optional

---

### Screen 4: History Tab (List)

```
┌─────────────────────────────────┐
│   Expense Tracker      [···]     │
├─────────────────────────────────┤
│                                 │
│  ┌─────────────────────────────┐│
│  │ 🍔 Lunch                    ││
│  │    Food • Dec 01            ││
│  │    Nice restaurant    $50.00│ [⋯]
│  └─────────────────────────────┘│
│                                 │  ← Expense Card
│  ┌─────────────────────────────┐│     (Color-coded)
│  │ 🚗 Gas Refill               ││
│  │    Transport • Nov 30       ││
│  │    Shell station      $40.00│ [⋯]
│  └─────────────────────────────┘│
│                                 │
│  ┌─────────────────────────────┐│
│  │ 🛍️  Winter Clothes          ││
│  │    Shopping • Nov 28        ││
│  │    H&M store         $120.00│ [⋯]
│  └─────────────────────────────┘│
│                                 │
│  ┌─────────────────────────────┐│
│  │ 🎬 Movie Tickets            ││
│  │    Entertainment • Nov 25   ││
│  │    Cinema 7           $30.00│ [⋯]
│  └─────────────────────────────┘│  ← Scrollable List
│                                 │     (Newest First)
│  ┌─────────────────────────────┐│
│  │ 💡 Electricity Bill         ││
│  │    Utilities • Nov 20       ││
│  │    Monthly bill       $85.00│ [⋯]
│  └─────────────────────────────┘│
│                                 │
│  ┌─────────────────────────────┐│
│  │ 🏥 Doctor Visit             ││
│  │    Health • Nov 15          ││
│  │    Checkup            $75.00│ [⋯]
│  └─────────────────────────────┘│
│                                 │
├─────────────────────────────────┤
│ 🏠 Home │📊 Charts│➕ Add│📜 Hist│
└─────────────────────────────────┘
```

**Purpose:** View all expenses in chronological order

**Key Elements:**

- Category icon
- Title and category name
- Date (MMM DD format)
- Notes (if present)
- Amount in green
- Menu button for delete

**Interactions:**

- Scroll for more
- Tap menu to delete
- Confirmation before delete

---

## 🔄 User Flow Diagrams

### Adding an Expense Flow

```
START
  ↓
Open App (Home Tab)
  ↓
Tap "Add" Tab
  ↓
Fill Title Field
  ↓
Fill Amount Field
  ↓
Select Category (Dropdown)
  ↓
Pick Date (Calendar)
  ↓
Add Notes (Optional)
  ↓
Tap "ADD EXPENSE"
  ↓
[Validation Check]
  ├─ Valid? → Continue
  └─ Invalid? → Show Error → Back to Step 3
  ↓
Expense Created
  ↓
Form Cleared
  ↓
Success Message Shown
  ↓
Data Saved to Storage
  ↓
Show Updated Home/Charts
  ↓
END
```

### Deleting an Expense Flow

```
START
  ↓
Go to History Tab
  ↓
Find Expense to Delete
  ↓
Tap Menu Icon
  ↓
Select "Delete"
  ↓
Confirmation Dialog Appears
  ↓
[User Confirmation]
  ├─ Cancel? → Back to History
  └─ Delete? → Continue
  ↓
Expense Removed from List
  ↓
Data Saved to Storage
  ↓
Success Message Shown
  ↓
UI Updated
  ↓
END
```

### Viewing Analytics Flow

```
START
  ↓
Open App
  ↓
Tap "Charts" Tab
  ↓
Check if Expenses Exist
  ├─ No Expenses? → Show Empty State
  └─ Has Expenses? → Continue
  ↓
Display Pie Chart
  ↓
Display Bar Chart
  ↓
Calculate Statistics
  ↓
Display Statistics Grid
  ↓
User Can Scroll to See All
  ↓
User Can Switch Tabs
  ↓
END
```

---

## 🎨 Color Usage Guide

### Background Colors

- Page background: #F5F5F5 (Light Grey)
- Card background: #FFFFFF (White)
- Gradient card: Blue (#2196F3 to #1976D2)

### Text Colors

- Primary text: #212121 (Dark Grey)
- Secondary text: #757575 (Medium Grey)
- Amount text: #4CAF50 (Green)

### Category Colors

| Category      | Color  | Hex     |
| ------------- | ------ | ------- |
| Food          | Orange | #FF9800 |
| Transport     | Blue   | #2196F3 |
| Entertainment | Purple | #9C27B0 |
| Utilities     | Green  | #4CAF50 |
| Shopping      | Pink   | #E91E63 |
| Health        | Red    | #F44336 |
| Education     | Indigo | #3F51B5 |
| Other         | Grey   | #9E9E9E |

---

## 📱 Interaction Patterns

### Button States

```
Normal State:
[  ADD EXPENSE  ]
(Blue background)

Hover State:
[  ADD EXPENSE  ]
(Slightly darker blue)

Pressed State:
[  ADD EXPENSE  ]
(Ripple effect shown)

Disabled State:
[  ADD EXPENSE  ]
(Faded/greyed out)
```

### Input Field States

```
Empty State:
┌────────────────────┐
│ Enter amount      │
└────────────────────┘

Focused State:
┌────────────────────┐
│ 45.50             │ (cursor)
└────────────────────┘
(Underline blue)

Error State:
┌────────────────────┐
│                    │
└────────────────────┘
Error: Please enter valid amount
(Red underline)

Filled State:
┌────────────────────┐
│ 45.50             │
└────────────────────┘
(Green indicator)
```

### Dialog States

```
Confirmation Dialog:
┌──────────────────────────────┐
│ Delete Expense?              │
├──────────────────────────────┤
│ This action cannot be undone.│
├──────────────────────────────┤
│  [Cancel]      [Delete]      │
└──────────────────────────────┘
```

---

## ⚡ Animation Specifications

### Tab Transitions

- Type: Fade + Slide
- Duration: 300ms
- Curve: EaseInOut

### Dialog Open

- Type: Fade In + Scale
- Duration: 200ms
- Curve: EaseOut

### Snackbar

- Type: Slide Up
- Duration: 400ms
- Curve: EaseIn

### Chart Render

- Type: Progressive Draw
- Duration: 800ms
- Curve: EaseInOut

---

## 📐 Layout Specifications

### Spacing

- Screen padding: 16dp
- Section margin: 24dp
- Card spacing: 12dp
- Text spacing: 8dp

### Dimensions

- AppBar height: 56dp
- BottomNavBar height: 56dp
- Button height: 50dp
- Card min height: 80dp

### Border Radius

- Cards: 12dp
- Buttons: 12dp
- Input: 12dp
- Categories: 12dp

---

## 🔤 Text Styles

### Headlines

- Size: 24px
- Weight: Bold
- Color: Dark Grey
- Example: "Add New Expense"

### Section Titles

- Size: 18px
- Weight: Bold
- Color: Dark Grey
- Example: "By Category"

### Card Titles

- Size: 16px
- Weight: Bold
- Color: Dark Grey
- Example: "Lunch"

### Body Text

- Size: 14px
- Weight: Regular
- Color: Dark Grey
- Example: "Food • Dec 01"

### Small Text

- Size: 12px
- Weight: Regular
- Color: Medium Grey
- Example: "36.0%"

---

## 📊 Chart Visual Specs

### Pie Chart

- Radius: 100dp
- Center label: Category name
- Legend: Yes, with colors
- Animation: Progressive

### Bar Chart

- Width: 16dp per bar
- Spacing: 20dp between groups
- X-axis: Category names
- Y-axis: Dollar amounts
- Grid: Light grey

### Progress Bars

- Height: 6dp
- Background: Light grey
- Fill: Category color
- Border radius: 4dp

---

## 🎯 Responsive Design

### Phone (Portrait)

- Width: Full screen - 32dp padding
- Orientation: Portrait only
- Text size: Standard
- Charts: Full width

### Tablet (Landscape)

- Width: Full screen
- Columns: 2 for stats
- Orientation: Both
- Text size: Slightly larger
- Charts: Side by side (optional)

### Sizing Rules

- Minimum width: 280dp (small phone)
- Maximum width: 600dp (tablet)
- Aspect ratio: Responsive

---

## ✨ User Feedback

### Success Feedback

```
✓ Expense added successfully
(Green snackbar, 2 seconds)
```

### Error Feedback

```
⚠ Please fill all fields
(Red snackbar, 2 seconds)
```

### Confirmation Feedback

```
Delete Expense?
[Cancel] [Delete]
(Modal dialog)
```

---

## 🎬 Complete User Session Example

**Time: 0:00** - User opens app

```
Home tab shows empty state
Total: $0.00
No recent expenses
```

**Time: 0:05** - User adds first expense

```
Tap "Add" tab
Fill: "Coffee" | "4.50" | "Food"
Tap "ADD EXPENSE"
Success message appears
```

**Time: 0:10** - User adds more expenses

```
Add: "Gas" | "40.00" | "Transport"
Add: "Movie" | "15.00" | "Entertainment"
Add: "Electricity" | "85.00" | "Utilities"
```

**Time: 0:30** - User checks dashboard

```
Home tab shows:
Total: $144.50
By Category breakdown
Recent 4 expenses
```

**Time: 0:45** - User views analytics

```
Charts tab shows:
Pie chart visualization
Bar chart comparison
Statistics (4 metrics)
```

**Time: 1:00** - User reviews history

```
History tab shows:
All 4 expenses
Color-coded
Newest first
Option to delete
```

---

**Visual Guide Complete! 🎨**
