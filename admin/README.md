# Logit LMS Admin Panel

A comprehensive Flutter web admin panel for managing the Logit Diving LMS (Learning Management System). This admin interface allows you to create, edit, and manage competencies, guides, and workplace assessments for diving professionals.

## Features

### 📊 Dashboard
- Overview statistics for competencies, guides, and assessments
- Quick action buttons for common tasks
- Recent activity tracking
- System status monitoring

### 🎯 Competencies Management
- View all competencies with filtering and search
- Add new competencies with categories and descriptions
- Edit existing competencies
- Delete competencies with confirmation
- Track progress percentages and due dates

### 📚 Guides Management
- Browse all procedural guides
- Search and filter guides
- Add step-by-step guides with detailed instructions
- Bookmark important guides
- Edit guide content and steps

### 📝 Assessments Management
- Create workplace assessment workflows
- Manage assessment steps (checklist, booking, upload)
- Track assessment status (pending, in progress, completed, failed)
- Link assessments to competencies

### 💾 Data Export & Import
- Export all data as JSON files
- Export specific content types (competencies, guides, or assessments only)
- Import data from JSON files
- Migration guide for moving to new codebase

## Project Structure

```
admin/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── theme/
│   │   └── app_theme.dart        # Admin theme and styling
│   ├── providers/
│   │   └── admin_provider.dart   # State management
│   ├── models/
│   │   ├── competency.dart       # Competency data model
│   │   ├── guide.dart            # Guide data model
│   │   └── assessment.dart       # Assessment data model
│   ├── screens/
│   │   ├── admin_dashboard_screen.dart
│   │   ├── competencies_admin_screen.dart
│   │   ├── guides_admin_screen.dart
│   │   ├── assessments_admin_screen.dart
│   │   └── data_export_screen.dart
│   └── widgets/
│       ├── admin_sidebar.dart
│       ├── dashboard_stats_card.dart
│       ├── recent_activity_card.dart
│       ├── competency_list_item.dart
│       ├── guide_list_item.dart
│       └── assessment_list_item.dart
├── pubspec.yaml                  # Flutter dependencies
└── README.md                     # This file
```

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or later)
- Dart SDK (included with Flutter)
- Web development environment set up

### Setup Instructions

1. **Navigate to the admin directory**
   ```bash
   cd admin
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the web app**
   ```bash
   flutter run -d web
   ```

4. **Build for production**
   ```bash
   flutter build web
   ```

## Data Models

### Competency
```dart
class Competency {
  final String id;
  final String category;
  final String title;
  final String description;
  final int progressPercent;
  final String imageAssetPath;
  final String dueDateLabel;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

### Guide
```dart
class Guide {
  final String id;
  final String title;
  final IconData icon;
  final String description;
  final bool isBookmarked;
  final List<GuideStep> steps;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

### Assessment
```dart
class Assessment {
  final String id;
  final String competencyId;
  final String title;
  final String description;
  final List<AssessmentStep> steps;
  final AssessmentStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

## Key Features Explained

### State Management
The app uses the Provider pattern for state management:
- `AdminProvider` handles all CRUD operations
- Manages loading states and data synchronization
- Provides export/import functionality

### Theme System
- Consistent design language throughout the app
- AdminTheme class provides colors, typography, and component styles
- Responsive design for different screen sizes

### Navigation
- Sidebar navigation for main sections
- Breadcrumb navigation within sections
- Search and filtering capabilities

## Export & Import Functionality

### Export Options
1. **All Data**: Complete export of competencies, guides, and assessments
2. **Competencies Only**: Export just competency data
3. **Guides Only**: Export procedural guides
4. **Assessments Only**: Export assessment workflows

### Import Process
1. Select JSON file to import
2. Preview data before importing
3. Confirm import (will overwrite existing data)
4. Verify imported data

### Data Format
All data is exported in JSON format with the following structure:
```json
{
  "competencies": [...],
  "guides": [...],
  "assessments": [...],
  "exportedAt": "2024-01-01T00:00:00.000Z"
}
```

## Moving to New Codebase

This admin panel is designed to be easily movable to a new codebase:

### Step 1: Export Data
1. Go to the Data Export section
2. Choose export option (All Data recommended)
3. Download the JSON file

### Step 2: Set Up New System
1. Deploy the new codebase
2. Set up the admin panel in the new environment
3. Ensure all dependencies are installed

### Step 3: Import Data
1. Go to the Data Import section in the new admin panel
2. Upload the exported JSON file
3. Confirm import
4. Verify all data was imported correctly

### Step 4: Test & Verify
1. Check that all competencies, guides, and assessments are present
2. Test search and filtering functionality
3. Verify export/import works in the new system

## Customization

### Adding New Content Types
1. Create new model in `lib/models/`
2. Add CRUD operations to `AdminProvider`
3. Create management screen in `lib/screens/`
4. Add navigation in `AdminSidebar`
5. Create list item widget in `lib/widgets/`

### Modifying Theme
- Update colors and styles in `AdminTheme`
- Modify component styles in theme classes
- Add new theme variants if needed

### Extending Export/Import
- Add new export formats in `DataExportScreen`
- Implement custom import parsers
- Add data validation and transformation

## Troubleshooting

### Common Issues

**Flutter Web Not Running**
- Ensure Flutter web is enabled: `flutter config --enable-web`
- Check Chrome is installed for development
- Try `flutter doctor` to diagnose issues

**Data Not Loading**
- Check browser console for errors
- Verify AdminProvider is properly initialized
- Ensure sample data is loading in `_initializeSampleData()`

**Export/Import Not Working**
- Check file permissions for downloads
- Verify JSON format is valid
- Ensure browser supports file downloads

### Performance Tips
- Use pagination for large datasets
- Implement lazy loading for images
- Optimize search with debouncing
- Cache frequently accessed data

## Contributing

When contributing to this admin panel:

1. Follow Flutter best practices
2. Use the established theme system
3. Add proper error handling
4. Test on web platform
5. Update documentation

## License

This admin panel is part of the Logit LMS system and follows the same licensing terms.

---

## Support

For questions or issues with the admin panel:
1. Check this documentation
2. Review the Flutter web documentation
3. Check browser compatibility
4. Verify data formats and structures

The admin panel is designed to be intuitive and follows standard web application patterns for ease of use.