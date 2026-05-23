.PHONY: dev prod build watch l10n clean fix

#! To run the Development Flavor
dev:
	flutter run --flavor development -t lib/main_development.dart

#! To run the Production Flavor
prod:
	flutter run --flavor production -t lib/main_production.dart

#! To run the build runner package (for freezed and jsonSerializable and Retrofit)
build:
	dart run build_runner build --delete-conflicting-outputs

#! To run the build runner package (for freezed and jsonSerializable and Retrofit) in watch mode
watch:
	dart run build_runner watch --delete-conflicting-outputs

#! To generate Translations
l10n:
	flutter gen-l10n

clean:
	flutter clean && flutter pub get

fix:
	dart fix --apply

scrcpy:
	scrcpy --always-on-top 




#! TODO make it with github actions it build the apk and send it to the firebase thingy
#! todo add build build apk for prod and dev