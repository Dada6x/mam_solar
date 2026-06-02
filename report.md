# Bug & Code Quality Report

Generated: comprehensive scan of the codebase.

---

## Bugs Fixed (Previous Sessions)

### HIGH: Wizard page validation ignores required multiphoto fields
- **File:** `lib/features/protocols/widgets/question_wizard_widget.dart`
- Fixed: added `(val is List && val.isEmpty)` check.

### MEDIUM: `_evaluateShowIf` missing `unchecked` keyword handling
- **File:** `lib/features/protocols/widgets/question_wizard_widget.dart`
- Fixed: added `unchecked` handling and OR-condition support.

### MEDIUM: Remaining `as String?` casts on `buildPhotoField` calls
- **File:** `lib/features/pdf/generators/damage_report_pdf_generator.dart`
- Fixed: removed unsafe casts.

### MEDIUM: `_expectedFlatKeys` missing 16+ field keys
- **File:** `lib/features/pdf/generators/installation_report_pdf_generator.dart`
- Fixed: added missing keys.

### MEDIUM: `MultiPhotoCaptureFieldWidget` double `existsSync()` + unused variable
- **File:** `lib/features/protocols/widgets/multi_photo_capture_field_widget.dart`
- Fixed: single pass with `(path, exists)` tuples.

---

## Critical Issues (CRASH Risk)

### CRASH-1: `setState` after async gap — `photo_capture_field_widget.dart`
- **File:** `lib/features/protocols/widgets/photo_capture_field_widget.dart`
- **Lines:** 41, 61
- **Issue:** `_takePhoto` and `_pickFromGallery` call `setState()` after `await _picker.pickImage(...)` without checking `mounted`. If the user navigates away while camera/gallery is open, `setState()` throws `FlutterError` ("setState() called after dispose()"). The catch block only covers picker errors.
- **Screenshot of code (lines ~33-71):**
  ```dart
  final file = await _picker.pickImage(...);  // async gap
  if (file != null) {
    setState(() => _imagePath = file.path);  // CRASH if unmounted!
    widget.onChanged(file.path);
  }
  ```

### CRASH-2: `setState` after async gap — `file_field_widget.dart`
- **File:** `lib/features/protocols/widgets/file_field_widget.dart`
- **Line:** 51
- **Issue:** Same pattern as CRASH-1. `setState()` after `await FilePicker.pickFiles(...)` without `mounted` check.
- **Fix:** Add `if (!mounted) return;` after every `await` in `_pickFile`.

### CRASH-3: `DropdownButtonFormField` uses non-existent `initialValue` parameter
- **File:** `lib/features/protocols/widgets/form_field_renderer.dart`
- **Line:** 188
- **Issue:** `DropdownButtonFormField<String>` has no `initialValue` parameter. This causes a **compile error**. The correct parameter is `value`.
- **Note:** Old report.md marked this as LOW ("only used during first build"), but it is actually a **compile-time error** — the code will not compile and run at all.

### CRASH-4: Unsafe `as String?` casts — `form_field_renderer.dart`
- **File:** `lib/features/protocols/widgets/form_field_renderer.dart`
- **Lines:** 44, 54, 86, 96, 121, 229, 242
- **Issue:** `value as String?` where `value` is `dynamic`. If the runtime type is not `String?` (e.g., an `int`, `bool`, or `List`), this throws `TypeError`. Data comes from `Map<String, dynamic>` (parsed JSON) with no type guarantees.
- **Fix:** Replace with `value?.toString()` which safely converts any type to its string representation.

### CRASH-5: Force cast `ModalRoute.of(context) as PageRoute` — `home_screen.dart`
- **File:** `lib/features/home/view/home_screen.dart`
- **Lines:** 35-38
- **Issue:** `ModalRoute.of(context)` returns `ModalRoute?`. The force cast to `PageRoute` crashes if the route is null or not a `PageRoute` (e.g., dialog route, bottom-sheet route). This runs before `Navigator` is fully initialized.
- **Fix:** Use `ModalRoute.of(context) as PageRoute?` and handle the null case, or use a different navigation approach.

### CRASH-6: `signature_screen.dart` — SnackBar after `context.pop()`
- **File:** `lib/features/signatures/view/signature_screen.dart`
- **Lines:** 52-61
- **Issue:** `BlocListener` pops the route first, then calls `ScaffoldMessenger.of(context).showSnackBar()` on a context that may be removed from the widget tree.
- **Fix:** Check `context.mounted` before showing SnackBar, or show SnackBar before popping.

### CRASH-7: `pdf_naming_util.dart` — no null guard on `customerName`
- **File:** `lib/core/utils/pdf_naming_util.dart`
- **Lines:** 7-8
- **Issue:** `customerName` is `String` (non-nullable), but callers pass `ProtocolModel.customerName` which is `String?`. If a protocol model has `customerName: null`, the call `.replaceAll(...)` throws `NullError`.
- **Fix:** Accept `String?` and default to `'Unknown'`, or add a null assertion at call sites.

---

## High Severity

### HIGH-1: Unsafe `as String?` casts on signature fields (all 4 PDF generators)
- **Files:**
  - `ac_protocol_pdf_generator.dart` lines 479, 489
  - `damage_report_pdf_generator.dart` lines 458, 466
  - `installation_report_pdf_generator.dart` lines 528, 533
  - `work_order_pdf_generator.dart` lines 269, 270
- **Issue:** `data['customerSignature'] as String?` — if the value exists but is not a `String` (e.g., `true`, `42`), a `TypeError` is thrown at runtime.
- **Fix:** Pass `data['customerSignature']?.toString()` or use a type-check helper.

### HIGH-2: Unsafe `as String` cast — `damage_report_pdf_generator.dart`
- **File:** `lib/features/pdf/generators/damage_report_pdf_generator.dart`
- **Line:** 114
- **Issue:** `(data['damageTypeOther'] as String).isNotEmpty` — null check only, no type check. Non-String value throws `TypeError`.
- **Fix:** Use `safeString(data['damageTypeOther']).isNotEmpty`.

### HIGH-3: Unsafe `as String?` on photo fields — `damage_report_pdf_generator.dart`
- **File:** `lib/features/pdf/generators/damage_report_pdf_generator.dart`
- **Lines:** 355, 361, 367
- **Issue:** `d['photoOverview'] as String?` casts to `String?` before passing to `buildPhotoField` (which accepts `dynamic`). This breaks `List<String>` support and crashes if the data contains a list.
- **Fix:** Pass raw value without cast.

### HIGH-4: String-only `== 'yes'` checks — `installation_report_pdf_generator.dart`
- **File:** `lib/features/pdf/generators/installation_report_pdf_generator.dart`
- **Lines:** 194, 196, 287, 311, 397, 413, 428, 484
- **Issue:** Checks like `data['satDishPresent'] == 'yes'` silently skip conditional blocks if the value is boolean `true` instead of string `'yes'`. Inconsistent with `_yesNo` helper which handles both.
- **Fix:** Normalize with `data['key']?.toString().toLowerCase() == 'yes'` or use `_yesNo`.

### HIGH-5: Boolean `true` not treated as completed — `work_order_pdf_generator.dart`
- **File:** `lib/features/pdf/generators/work_order_pdf_generator.dart`
- **Line:** 211
- **Issue:** `workCompleted == 'yes'` — if value is boolean `true`, `toString()` gives `'true'`, and `'true' == 'yes'` is false.
- **Fix:** Accept both `true` and `'yes'`.

### HIGH-6: Typo `remoteControlPrdesent` — `ac_protocol_pdf_generator.dart`
- **File:** `lib/features/pdf/generators/ac_protocol_pdf_generator.dart`
- **Lines:** 104, 385
- **Issue:** Expected key is `'remoteControlPresent'` but code reads `'remoteControlPrdesent'` (missing 'e'). The remote-control photo is never found, always shows `'-'`.
- **Fix:** Correct spelling to `'remoteControlPresent'`.

### HIGH-7: Missing comma in `_expectedFlatKeys` — `work_order_pdf_generator.dart`
- **File:** `lib/features/pdf/generators/work_order_pdf_generator.dart`
- **Lines:** 14-15
- **Issue:** No comma between `'image'` and `'customerFullName'`. Dart string concatenation merges them into `'imagecustomerFullName'`, a garbage key. `'image'` and `'customerFullName'` are both missing from the expected keys list, causing noisy logging and misleading missing-field counts.

### HIGH-8: `TextEditingController` created on every build, never disposed
- **File:** `lib/features/protocols/widgets/form_field_renderer.dart`
- **Lines:** 57, 99, 124
- **Issue:** `TextEditingController(text: displayValue)` is created inside the build method for date/time/datetime fields. A new controller is allocated on every rebuild with no `dispose()`. Memory grows with each interaction.
- **Fix:** Extract into a StatefulWidget with `initState`/`dispose` lifecycle.

### HIGH-9: Missing `didUpdateWidget` — `photo_capture_field_widget.dart` + `file_field_widget.dart`
- **Files:** `photo_capture_field_widget.dart` (line 27-31), `file_field_widget.dart` (line 29-33)
- **Issue:** Local state (`_imagePath`, `_filePath`) is initialized from `widget.imagePath` / `widget.filePath` in `initState` but never updated when the parent passes a new value. External reset/clear does not work.
- **Fix:** Override `didUpdateWidget` or eliminate local state entirely.

---

## Medium Severity

### MED-1: `setState`/`onChanged` after async gap — `multi_photo_capture_field_widget.dart`
- **File:** `lib/features/protocols/widgets/multi_photo_capture_field_widget.dart`
- **Lines:** 34, 52
- **Issue:** `_takePhoto` and `_pickFromGallery` call `widget.onChanged(...)` after `await` without `mounted` check. While `onChanged` itself doesn't crash, the parent handler may trigger `setState`.
- **Fix:** Add `if (!mounted) return;` after each `await`.

### MED-2: Magic string comparisons in `dynamic_form_screen.dart`
- **File:** `lib/features/protocols/view/dynamic_form_screen.dart`
- **Lines:** 50, 64
- **Issue:** `state.error == 'saveFailed'` and `state.pdfPath == 'preview'` are magic strings with no type safety. If the Bloc changes these strings, the screen silently stops reacting.
- **Fix:** Use freezed sealed union variants instead of stringly-typed state fields.

### MED-3: `context.read` in SnackBar action — `dynamic_form_screen.dart`
- **File:** `lib/features/protocols/view/dynamic_form_screen.dart`
- **Lines:** 57-58
- **Issue:** The `context` captured by the SnackBar's `onPressed` closure may be unmounted by the time the user taps "Retry". `context.read<ProtocolBloc>()` throws if context is not in widget tree.
- **Fix:** Store bloc reference at listener time: `final bloc = context.read<ProtocolBloc>()`.

### MED-4: Navigate back while async save in-flight — `dynamic_form_screen.dart`
- **File:** `lib/features/protocols/view/dynamic_form_screen.dart`
- **Lines:** 104-107
- **Issue:** `SaveDraft` is dispatched but not awaited. `context.pop()` fires immediately. If save fails, the user has already left with no feedback.
- **Fix:** Await save completion before navigating, or show SnackBar before pop.

### MED-5: Unsafe `.cast<String>()` in `form_field_renderer.dart` and `pdf_generator_base.dart`
- **Files:** `form_field_renderer.dart` line 296, `pdf_generator_base.dart` line 223
- **Issue:** `value.cast<String>()` creates a lazy wrapper that throws `TypeError` if any element is not a `String`. Data from JSON (`Map<String, dynamic>`) may contain mixed-type lists.
- **Fix:** Use `.map((e) => e?.toString() ?? '')` instead.

### MED-6: `RefreshIndicator.onRefresh` returns immediately — `home_screen.dart`
- **File:** `lib/features/home/view/home_screen.dart`
- **Lines:** 82-84
- **Issue:** `bloc.add()` returns `void`, so the async lambda completes instantly. The `RefreshIndicator` retracts its spinner before the bloc finishes loading.
- **Fix:** Await a state change: `bloc.stream.firstWhere(...)`.

### MED-7: Swipe-to-delete bypasses confirmation — `saved_drafts_screen.dart`
- **File:** `lib/features/drafts/view/saved_drafts_screen.dart`
- **Lines:** 185-187
- **Issue:** `confirmDismiss` returns `true` immediately. The button delete shows an `AlertDialog` confirmation, but swipe does not. Accidental swipe loses data.
- **Fix:** Show confirmation dialog in `confirmDismiss`.

### MED-8: `dynamic draft` type — `saved_drafts_screen.dart`
- **File:** `lib/features/drafts/view/saved_drafts_screen.dart`
- **Line:** 155
- **Issue:** `final dynamic draft` — loses all compile-time type safety. `NoSuchMethodError` at runtime if properties are missing.
- **Fix:** Use `final ProtocolModel draft`.

### MED-9: Delete state inconsistency — `drafts_bloc.dart`
- **File:** `lib/features/drafts/bloc/drafts_bloc.dart`
- **Lines:** 41-49
- **Issue:** `isLoading` is never set during delete. If `deleteProtocol` succeeds but `getDrafts()` fails, the deleted draft remains in state (stale data shown to user).
- **Fix:** Set `isLoading = true` before delete; handle partial failure.

### MED-10: Nested try-catch misclassifies errors — `import_protocol_button.dart`
- **File:** `lib/features/settings/widgets/import_protocol_button.dart`
- **Lines:** 96-108
- **Issue:** If `saveOverride()` throws (disk full), it falls to outer catch showing "Import failed" instead of "File has errors".
- **Fix:** Restructure error handling.

### MED-11: `as String?` cast in signature dispatch — `form_field_renderer.dart`
- **File:** `lib/features/protocols/widgets/form_field_renderer.dart`
- **Line:** 220
- **Issue:** `signaturePath: value as String?` — same unsafe cast pattern. If value is `List<String>` (from a multiphoto field passed incorrectly), it crashes.
- **Fix:** Use `value?.toString()`.

### MED-12: Missing `context.mounted` after time picker — `form_field_renderer.dart`
- **File:** `lib/features/protocols/widgets/form_field_renderer.dart`
- **Lines:** 76-82
- **Issue:** After `showDatePicker` + `showTimePicker`, no `context.mounted` check before calling `onChanged`. Datetime fields can call callbacks on disposed widgets.
- **Fix:** Add `if (!context.mounted) return;` after the time picker.

### MED-13: `photoDcCableRoute` multiphoto field never rendered in PDF
- **File:** `assets/protocols/installation_report.md` (line 121) / `installation_report_pdf_generator.dart`
- **Issue:** Field is defined in markdown but the PDF generator's `_buildDcCableRouteSection` does not render it. Photos stored but never appear in PDF.

---

## Low Severity / Code Quality

### LOW-1: `validPaths` unused + double `existsSync()` — `multi_photo_capture_field_widget.dart`
- **Lines:** 70-71 vs 85-88 — `validPaths` is computed but never used; `existsSync()` called twice per path per build.

### LOW-2: Synchronous `File.existsSync()` in build methods
- **Files:** `photo_capture_field_widget.dart` (line 88), `multi_photo_capture_field_widget.dart` (lines 70, 88), `signature_field_widget.dart` (line 40)
- **Issue:** Synchronous filesystem checks on UI thread can cause jank.

### LOW-3: Dead code — `repeatable_section_widget.dart`
- **File:** `lib/features/protocols/widgets/repeatable_section_widget.dart`
- **Issue:** 105-line file never imported anywhere. Superseded by inline implementation in `question_wizard_widget.dart`.

### LOW-4: Dead code — `law.dart`
- **File:** `lib/features/pdf/generators/law.dart` (0 lines, empty file)

### LOW-5: Commented-out dead code — `onboarding_screen.dart`
- **File:** `lib/features/onboarding/onboarding_screen.dart` (70 lines of commented-out code)

### LOW-6: Signature field with empty `onTap` — `form_field_renderer.dart`
- **Line:** 219-225 — Signature field rendered by `FormFieldRenderer` has `onTap: () {}` (no-op). Currently unreachable because `question_wizard_widget.dart` handles signatures before reaching `FormFieldRenderer`, but latent bug if routing changes.

### LOW-7: FieldType.repeatable renders `SizedBox.shrink()` silently
- **File:** `form_field_renderer.dart` line 260-261 — silent no-op instead of explicit error for future developers.

### LOW-8: Hardcoded German string "Datei auswählen" — `file_field_widget.dart`
- **Line:** 121 — Not localized.

### LOW-9: Hardcoded string "MAM-Solarbau" — `home_screen.dart`
- **Line:** 75 — Not localized.

### LOW-10: Case-sensitive file extension filter `.md` — `import_protocol_button.dart`
- **Line:** 58 — Files with `.MD` or `.Md` rejected on Linux.

### LOW-11: TODO comment in production code — `signature_screen.dart`
- **Lines:** 68-69 — `//TODO figure out what ive did here` — developer did not understand their own regex.

### LOW-12: Key mismatch `remarksGeneral` vs `remarks` — `ac_protocol_pdf_generator.dart`
- **Line:** 449 — Reads `'remarksGeneral'` but expected key is `'remarks'`. Silent blank field.

### LOW-13: Generator name mismatch in logging — `installation_report_pdf_generator.dart`
- **Line:** 96 — Logs as `'AufmassReportPdfGenerator'` but class is `InstallationReportPdfGenerator`.

### LOW-14: `FormSection.repeatableField` never used
- **File:** `lib/features/protocols/forms/form_definition.dart` — line 26, `repeatableField` is declared but never set by parser or read anywhere.

### LOW-15: `FormFieldDef` field `multiple` never used after parsing
- **File:** `lib/features/protocols/forms/form_definition.dart` — line 66, set by parser but never read by any widget or generator.

### LOW-16: `SettingsBloc` uses `abstract class` instead of `sealed class` (freezed)
- **File:** `lib/features/settings/bloc/settings_bloc.dart` — inconsistent with `HomeState` and `ProtocolState` which use `sealed class`.

### LOW-17: `DraftsBloc` uses `abstract class` instead of `sealed class` (freezed)
- **File:** `lib/features/drafts/bloc/drafts_bloc.dart` — same inconsistency.

### LOW-18: Missing `_expectedFlatKeys` photo keys — `installation_report_pdf_generator.dart`
- **File:** `lib/features/pdf/generators/installation_report_pdf_generator.dart` — despite a previous fix adding 16+ keys, the following photo keys are still referenced in section builders but not listed in `_expectedFlatKeys`: `photoHak`, `photosWayToMeter`, `photoMeterCabinet`, `photosZkDetails`, `photoMainMeter`, `photoOptionalZkLocation`, `photosCableHakToOptionalZk`, `photosCableExistingZkToOptionalZk`, `photosInstallLocation`, `photosCableInverterToExistingZk`, `photosCableInverterToOptionalZk`, `photosEarthingCableRoute`, `photosRouterCableRoute`, `photosWallboxCable`, `photosNubCableRoute`, `photosSpecial`. These generate noisy "unexpected field" log entries.

---

## Summary

| Severity | Count | Key Issues |
|----------|-------|------------|
| **CRASH** | 7 | `setState` after dispose (2x), compile error `DropdownButtonFormField`, unsafe `as String?` casts (7 sites), force-cast `PageRoute`, SnackBar after pop, null `customerName` |
| **HIGH** | 9 | Unsafe casts on signatures (4 generators), photo field casts (1 generator), string-only boolean checks (8+ sites), typo `remoteControlPrdesent`, missing comma in expected keys, `TextEditingController` leak, missing `didUpdateWidget` (2x) |
| **MEDIUM** | 13 | Async gaps without mounted check, magic strings, stale state on delete, swipe-to-delete bypass, broken RefreshIndicator, unsafe `.cast<String>()`, datetime missing mounted check, photo field not rendered, etc. |
| **LOW** | 18 | Dead code, unlocalized strings, unused fields, inconsistent freezed patterns, noisy logging, TODO in production |
