include vendor/google/build/config.mk
include $(GAPPS_FILES)

DEVICE_PACKAGE_OVERLAYS += $(GAPPS_DEVICE_FILES_PATH)/overlay/pico

PRODUCT_PACKAGES += \
		BugReportSender \
		ConfigUpdater \
		GoogleBackupTransport \
		GoogleContactsSyncAdapter \
		GoogleServicesFramework \
		NoTouchAuthDelegate \
		PrebuiltGmsCorePano \
		Tubesky \
		Backdrop \
		AndroidMediaShell \
		GamepadPairingService \
		GlobalKeyInterceptor \
		TV \
		Overscan \
		RemoteControlService \
		SecondScreenSetup \
		SecondScreenSetupAuthBridge \
		talkback \
		AtvCustomization \
		LeanbackLauncher \
		LeanbackIme \
		VideosPano \
		Music2Pano \
		CanvasPackageInstaller \
		FuguPairingTutorial \
		PlayGames \
		AtvRemoteService \
		Katniss \
		AtvWidget \
		YouTubeLeanback \
		LandscapeWallpaper

ifeq ($(GAPPS_FORCE_WEBVIEW_OVERRIDES),true)
ifneq ($(filter-out $(call get-allowed-api-levels),24),)
DEVICE_PACKAGE_OVERLAYS += $(GAPPS_DEVICE_FILES_PATH)/overlay/webview/21
else
DEVICE_PACKAGE_OVERLAYS += $(GAPPS_DEVICE_FILES_PATH)/overlay/webview/24
endif
PRODUCT_PACKAGES += WebViewGoogle
endif
