# Bug & Code Quality Report

Generated: comprehensive scan of the codebase.

## Bugs Fixed

### HIGH: Wizard page validation ignores required multiphoto fields
- **File:** `lib/features/protocols/widgets/question_wizard_widget.dart`
- **Lines:** ~198, ~212
- **Issue:** The `onNext` validation check `val == null || (val is String && val.trim().isEmpty)` did not detect empty `List<String>` values. Required `multiphoto` fields with zero photos passed page-level validation, allowing users to proceed past them.
- **Fix:** Added `(val is List && val.isEmpty)` check to both validation paths.

### MEDIUM: `_evaluateShowIf` missing `unchecked` keyword handling
- **File:** `lib/features/protocols/widgets/question_wizard_widget.dart`
- **Lines:** 51-62
- **Issue:** The `_evaluateShowIf` method in `question_wizard_widget.dart` did not handle the `unchecked` keyword (unlike the identical method in `form_field_renderer.dart`). Fields with `show_if: someCheckbox == unchecked` were incorrectly evaluated. Since `photo`, `multiphoto`, and `signature` fields bypass `FormFieldRenderer` (handled directly in `_RepeatItemCard` and `_FieldGroupPage`), they had no safety net.
- **Fix:** Updated `_evaluateShowIf` to include `unchecked` handling and OR-condition (`showIfValues`) support, matching `form_field_renderer.dart`.

### MEDIUM: Remaining `as String?` casts on `buildPhotoField` calls
- **File:** `lib/features/pdf/generators/damage_report_pdf_generator.dart`
- **Lines:** 357, 363, 369
- **Issue:** Three `buildPhotoField` calls still used `as String?` cast (multiline calls missed by initial sed pass). These would throw a runtime type error if the fields were ever changed to `multiphoto` (which stores `List<String>`).
- **Fix:** Removed the `as String?` casts.

### LOW: `_expectedFlatKeys` missing 16+ field keys
- **File:** `lib/features/pdf/generators/installation_report_pdf_generator.dart`
- **Lines:** 8-85
- **Issue:** The `_expectedFlatKeys` list used for diagnostic field tracking was missing over 16 field keys that are actively referenced in section builder methods (e.g., `photoHak`, `photosWayToMeter`, `photoMeterCabinet`, `photosZkDetails`, `photoMainMeter`, etc.).
- **Fix:** Added all missing field keys to the list, organized by section.

### MEDIUM: `MultiPhotoCaptureFieldWidget` double `existsSync()` + unused variable
- **File:** `lib/features/protocols/widgets/multi_photo_capture_field_widget.dart`
- **Lines:** 70, 85-88
- **Issue:** `validPaths` was computed but never used. Every photo path had `existsSync()` called twice per build (once in `validPaths`, once in the render loop).
- **Fix:** Replaced with a single pass that computes `(path, exists)` tuples, used for both the `hasPhotos` check and rendering.

## Remaining Code Quality Issues

### LOW: Dead code — `repeatable_section_widget.dart`
- **File:** `lib/features/protocols/widgets/repeatable_section_widget.dart`
- **Issue:** This 105-line widget is not imported by any other file. It appears to be an older implementation superseded by repeatable handling in `question_wizard_widget.dart`.

### LOW: Dead code — `law.dart`
- **File:** `lib/features/pdf/generators/law.dart`
- **Issue:** Empty file (0 lines).

### LOW: Dead code — `onRemoveRepeat` parameter in `_NavigationBar`
- **File:** `lib/features/protocols/widgets/question_wizard_widget.dart`
- **Line:** ~810
- **Issue:** The `onRemoveRepeat` callback is passed to `_NavigationBar`, stored as a field, but never invoked. Actual remove functionality is handled directly in `_RepeatItemCard` via bloc.

### LOW: `DropdownButtonFormField` uses `initialValue` instead of `value`
- **File:** `lib/features/protocols/widgets/form_field_renderer.dart`
- **Line:** 188
- **Issue:** Uses `initialValue` parameter instead of `value` on `DropdownButtonFormField<String>`. The `initialValue` is only used during first build — if the form data changes externally, the dropdown won't reflect the new value on rebuild. This is a pre-existing issue.

### LOW: `photoDcCableRoute` multiphoto field defined in markdown but never rendered in PDF
- **File:** `assets/protocols/installation_report.md` (line 121) / `lib/features/pdf/generators/installation_report_pdf_generator.dart` (line ~257)
- **Issue:** The `photoDcCableRoute | multiphoto | ...` field is defined in the markdown protocol but the PDF generator's `_buildDcCableRouteSection` method does not render it. Photos taken for this field will be stored in form data but never appear in the PDF.
