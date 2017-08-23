#!/bin/bash

opengapps_get_package_info() {
  packagename=""
  packagetype=""
  packagetarget=""
  packagefiles=""
  packagelibs=""
  packagemaxapi="$API"
  packagegappsremove=""
  case "$1" in
    # Common GApps
    configupdater)            packagetype="Core"; packagename="com.google.android.configupdater"; packagetarget="priv-app/ConfigUpdater";; #On Android TV 5.1 and 6.0 this is in 'app'
    extsharedgoogle)          packagetype="Core"; packagename="com.google.android.ext.shared"; packagetarget="app/GoogleExtShared";;
    extservicesgoogle)        packagetype="Core"; packagename="com.google.android.ext.services"; packagetarget="priv-app/GoogleExtServices";;
    googlebackuptransport)    packagetype="Core"; packagename="com.google.android.backuptransport"; packagetarget="priv-app/GoogleBackupTransport";;
    googlecontactssync)       packagetype="Core"; packagename="com.google.android.syncadapters.contacts"; packagetarget="app/GoogleContactsSyncAdapter";;
    gsfcore)                  packagetype="Core"; packagename="com.google.android.gsf"; packagetarget="priv-app/GoogleServicesFramework";;
    talkback)                 packagetype="GApps"; packagename="com.google.android.marvin.talkback"; packagetarget="app/talkback";;
    webviewgoogle)            packagetype="GApps"; packagename="com.google.android.webview"; packagetarget="app/WebViewGoogle"; packagegappsremove="$webviewgappsremove";;

    # Regular GApps
    defaultetc)               packagetype="Core"; packagefiles="etc/preferred-apps/google.xml etc/sysconfig/google.xml etc/sysconfig/google_build.xml etc/sysconfig/google_vr_build.xml etc/sysconfig/whitelist_com.android.omadm.service.xml";;
    defaultframework)         packagetype="Core"; packagefiles="etc/permissions/com.google.android.maps.xml etc/permissions/com.google.android.media.effects.xml etc/permissions/com.google.widevine.software.drm.xml framework/com.google.android.maps.jar framework/com.google.android.media.effects.jar framework/com.google.widevine.software.drm.jar";;
    gmscore)                  packagetype="Core"; packagename="com.google.android.gms"; packagetarget="priv-app/PrebuiltGmsCore";;
    googlefeedback)           packagetype="Core"; packagename="com.google.android.feedback"; packagetarget="priv-app/GoogleFeedback";;
    googleonetimeinitializer) packagetype="Core"; packagename="com.google.android.onetimeinitializer"; packagetarget="priv-app/GoogleOneTimeInitializer";;
    googlepartnersetup)       packagetype="Core"; packagename="com.google.android.partnersetup"; packagetarget="priv-app/GooglePartnerSetup";;
    gsflogin)                 packagetype="Core"; packagename="com.google.android.gsf.login"; packagetarget="priv-app/GoogleLoginService";;
    setupwizard)              packagetype="Core"; packagename="com.google.android.setupwizard"; packagetarget="priv-app/SetupWizard";; #KitKat only
    setupwizarddefault)       packagetype="Core"; packagename="com.google.android.setupwizard.default"; packagetarget="priv-app/SetupWizard";;
    setupwizardtablet )       packagetype="Core"; packagename="com.google.android.setupwizard.tablet"; packagetarget="priv-app/SetupWizard";;
    vending)                  packagetype="Core"; packagename="com.android.vending"; packagetarget="priv-app/Phonesky";;

    androidpay)               packagetype="GApps"; packagename="com.google.android.apps.walletnfcrel"; packagetarget="app/Wallet";;
    books)                    packagetype="GApps"; packagename="com.google.android.apps.books"; packagetarget="app/Books";;
    calculatorgoogle)         packagetype="GApps"; packagename="com.google.android.calculator"; packagetarget="app/CalculatorGoogle";;
    calendargoogle)           packagetype="GApps"; packagename="com.google.android.calendar"; packagetarget="app/CalendarGooglePrebuilt";;
    calsync)                  packagetype="GApps"; packagename="com.google.android.syncadapters.calendar"; packagetarget="app/GoogleCalendarSyncAdapter";;
    cameragoogle)             packagetype="GApps"; packagename="com.google.android.googlecamera"; packagetarget="app/GoogleCamera";
                              if [ "$API" -ge "23" ]; then  # On Marshmallow+ we use the new GoogleCamera
                                packagefiles="etc/permissions/com.google.android.camera.experimental2015.xml framework/com.google.android.camera.experimental2015.jar"
                              else
                                packagefiles="etc/permissions/com.google.android.camera2.xml framework/com.google.android.camera2.jar"
                              fi;;
    cameragooglelegacy)       packagetype="GApps"; packagename="com.google.android.googlecamera"; packagetarget="app/GoogleCamera"; packagemaxapi="22"; packagefiles="etc/permissions/com.google.android.camera2.xml framework/com.google.android.camera2.jar";;
    chrome)                   packagetype="GApps"; packagename="com.android.chrome"; packagetarget="app/Chrome";;
    clockgoogle)              packagetype="GApps"; packagename="com.google.android.deskclock"; packagetarget="app/PrebuiltDeskClockGoogle";;
    cloudprint)               packagetype="GApps"; packagename="com.google.android.apps.cloudprint"; packagetarget="app/CloudPrint2";;
    contactsgoogle)           packagetype="GApps"; packagename="com.google.android.contacts"; packagetarget="priv-app/GoogleContacts";;
    dialerframework)          packagetype="GApps"; packagefiles="etc/permissions/com.google.android.dialer.support.xml framework/com.google.android.dialer.support.jar";;
    dialergoogle)             packagetype="GApps"; packagename="com.google.android.dialer"; packagetarget="priv-app/GoogleDialer";;
    dmagent)                  packagetype="GApps"; packagename="com.google.android.apps.enterprise.dmagent"; packagetarget="app/DMAgent";;
    docs)                     packagetype="GApps"; packagename="com.google.android.apps.docs.editors.docs"; packagetarget="app/EditorsDocs";;
    drive)                    packagetype="GApps"; packagename="com.google.android.apps.docs"; packagetarget="app/Drive";;
    earth)                    packagetype="GApps"; packagename="com.google.earth"; packagetarget="app/GoogleEarth";;
    exchangegoogle)           packagetype="GApps"; packagename="com.google.android.gm.exchange"; packagetarget="app/PrebuiltExchange3Google";;
    facedetect)               packagetype="GApps";
                              if [ "$LIBFOLDER" = "lib64" ]; then #on 64 bit, we also need the 32 bit lib of libfilterpack_facedetect.so
                                packagelibs="libfilterpack_facedetect.so+fallback";
                              else
                                packagelibs="libfilterpack_facedetect.so";
                              fi;;
    faceunlock)               case "$ARCH" in #only arm based platforms
                                arm*) packagetype="GApps"; packagename="com.android.facelock"; packagetarget="app/FaceLock";
                                      if [ "$API" -ge "24" ]; then  # On 7.0+ the facelock library is libfacenet.so
                                        FACELOCKLIB="libfacenet.so"
                                      else  # Before Nougat there is a pittpatt folder and libfacelock_jni
                                        packagefiles="vendor/pittpatt/";
                                        FACELOCKLIB="libfacelock_jni.so"
                                      fi
                                      if [ "$LIBFOLDER" = "lib64" ]; then #on 64 bit, we also need the 32 bit lib of libfrsdk.so
                                        packagelibs="$FACELOCKLIB libfrsdk.so+fallback";
                                      else
                                        packagelibs="$FACELOCKLIB libfrsdk.so";
                                      fi;;
                              esac;;
    fitness)                  packagetype="GApps"; packagename="com.google.android.apps.fitness"; packagetarget="app/FitnessPrebuilt";;
    gcs)                      packagetype="GApps"; packagename="com.google.android.apps.gcs"; packagetarget="priv-app/GCS";;
    gmail)                    packagetype="GApps"; packagename="com.google.android.gm"; packagetarget="app/PrebuiltGmail";;
    googlenow)                packagetype="GApps"; packagename="com.google.android.launcher"; packagetarget="app/GoogleHome";;
    googleplus)               packagetype="GApps"; packagename="com.google.android.apps.plus"; packagetarget="app/PlusOne";;
    googletts)                packagetype="GApps"; packagename="com.google.android.tts"; packagetarget="app/GoogleTTS";;
    hangouts)                 packagetype="GApps"; packagename="com.google.android.talk"; packagetarget="app/Hangouts";;
    hotword)                  packagetype="GApps"; packagename="com.android.hotwordenrollment"; packagetarget="priv-app/HotwordEnrollment";;
    indic)                    packagetype="GApps"; packagename="com.google.android.apps.inputmethod.hindi"; packagetarget="app/GoogleHindiIME";;
    japanese)                 packagetype="GApps"; packagename="com.google.android.inputmethod.japanese"; packagetarget="app/GoogleJapaneseInput";;
    korean)                   packagetype="GApps"; packagename="com.google.android.inputmethod.korean"; packagetarget="app/KoreanIME";;
    keep)                     packagetype="GApps"; packagename="com.google.android.keep"; packagetarget="app/PrebuiltKeep";;
    keyboardgoogle)           packagetype="GApps"; packagename="com.google.android.inputmethod.latin";
                              if [ "$API" -ge "24" ]; then
                                packagetarget="app/LatinIMEGooglePrebuilt"
                              else
                                packagetarget="app/LatinImeGoogle"
                              fi;;
    maps)                     packagetype="GApps"; packagename="com.google.android.apps.maps"; packagetarget="app/Maps";;
    messenger)                packagetype="GApps"; packagename="com.google.android.apps.messaging"; packagetarget="app/PrebuiltBugle";;
    movies)                   packagetype="GApps"; packagename="com.google.android.videos"; packagetarget="app/Videos";;
    music)                    packagetype="GApps"; packagename="com.google.android.music"; packagetarget="app/Music2";;
    newsstand)                packagetype="GApps"; packagename="com.google.android.apps.magazines"; packagetarget="app/Newsstand";;
    newswidget)               packagetype="GApps"; packagename="com.google.android.apps.genie.geniewidget"; packagetarget="app/PrebuiltNewsWeather";;
    packageinstallergoogle)   packagetype="GApps"; packagename="com.google.android.packageinstaller"; packagetarget="priv-app/GooglePackageInstaller";;
    photos)                   packagetype="GApps"; packagename="com.google.android.apps.photos"; packagetarget="app/Photos";;
    pinyin)                   packagetype="GApps"; packagename="com.google.android.inputmethod.pinyin"; packagetarget="app/GooglePinyinIME";;
    playgames)                packagetype="GApps"; packagename="com.google.android.play.games"; packagetarget="app/PlayGames";;
    printservicegoogle)       packagetype="GApps"; packagename="com.google.android.printservice.recommendation"; packagetarget="app/GooglePrintRecommendationService";;
    projectfi)                packagetype="GApps"; packagename="com.google.android.apps.tycho"; packagetarget="app/Tycho";;
    search)                   packagetype="GApps"; packagename="com.google.android.googlequicksearchbox"; packagetarget="priv-app/Velvet";;
    sheets)                   packagetype="GApps"; packagename="com.google.android.apps.docs.editors.sheets"; packagetarget="app/EditorsSheets";;
    slides)                   packagetype="GApps"; packagename="com.google.android.apps.docs.editors.slides"; packagetarget="app/EditorsSlides";;
    speech)                   packagetype="GApps"; packagefiles="usr/srec/en-US/";;
    street)                   packagetype="GApps"; packagename="com.google.android.street"; packagetarget="app/Street";;
    taggoogle)                packagetype="GApps"; packagename="com.google.android.tag"; packagetarget="priv-app/TagGoogle";;
    translate)                packagetype="GApps"; packagename="com.google.android.apps.translate"; packagetarget="app/TranslatePrebuilt";;
    vrservice)                packagetype="GApps"; packagename="com.google.vr.vrcore"; packagetarget="app/GoogleVrCore";;
    youtube)                  packagetype="GApps"; packagename="com.google.android.youtube"; packagetarget="app/YouTube";;
    zhuyin)                   packagetype="GApps"; packagename="com.google.android.apps.inputmethod.zhuyin"; packagetarget="app/GoogleZhuyinIME";;

    # TV GApps
    bugreport)                packagetype="Core"; packagetarget="app/BugReportSender";
                              if [ "$API" -ge "24" ]; then
                                packagename="com.google.tungsten.bugreportsender"
                              else
                                packagename="com.google.android.tv.bugreportsender"
                              fi;;
    notouch)                  packagetype="Core"; packagename="com.google.android.gsf.notouch"; packagetarget="app/NoTouchAuthDelegate";;
    setupwraith)              packagetype="Core"; packagename="com.google.android.tungsten.setupwraith"; packagetarget="priv-app/SetupWraith";;
    tvetc)                    packagetype="Core"; packagefiles="etc/sysconfig/google.xml etc/sysconfig/google_build.xml";;
    tvframework)              packagetype="Core"; packagefiles="etc/permissions/com.google.android.pano.v1.xml etc/permissions/com.google.android.tv.installed.xml etc/permissions/com.google.widevine.software.drm.xml framework/com.google.android.pano.v1.jar framework/com.google.widevine.software.drm.jar";;
    tvgmscore)                packagetype="Core"; packagename="com.google.android.gms.leanback"; packagetarget="priv-app/PrebuiltGmsCorePano";;
    tvvending)                packagetype="Core"; packagename="com.android.vending.leanback";
                              if [ "$API" -ge "24" ]; then
                                packagetarget="priv-app/Tubesky"
                              else
                                packagetarget="priv-app/PhoneskyKamikazeCanvas"
                              fi;;

    backdrop)                 packagetype="GApps"; packagename="com.google.android.backdrop.leanback"; packagetarget="app/Backdrop";;
    castreceiver)             packagetype="GApps"; packagename="com.google.android.apps.mediashell.leanback" packagetarget="priv-app/AndroidMediaShell";;
    gamepadpairing)           packagetype="GApps"; packagename="com.google.android.tv.remotepairing" packagetarget="priv-app/GamepadPairingService";;
    globalkey)                packagetype="GApps"; packagename="com.google.android.athome.globalkeyinterceptor" packagetarget="priv-app/GlobalKeyInterceptor";;
    livechannels)             packagetype="GApps"; packagename="com.google.android.tv.leanback" packagetarget="priv-app/TV";;
    overscan)                 packagetype="GApps"; packagename="com.google.android.tungsten.overscan" packagetarget="priv-app/Overscan";;
    remotecontrol)            packagetype="GApps"; packagename="com.google.android.athome.remotecontrol" packagetarget="priv-app/RemoteControlService";;
    secondscreensetup)        packagetype="GApps"; packagename="com.google.android.sss"; packagetarget="app/SecondScreenSetup";;
    secondscreenauthbridge)   packagetype="GApps"; packagename="com.google.android.sss.authbridge"; packagetarget="app/SecondScreenSetupAuthBridge";;
    tvcustomization)          packagetype="GApps"; packagename="com.google.android.atv.customization" packagetarget="priv-app/AtvCustomization";;
    tvlauncher)               packagetype="GApps"; packagename="com.google.android.leanbacklauncher.leanback" packagetarget="priv-app/LeanbackLauncher";;
    tvkeyboardgoogle)         packagetype="GApps"; packagename="com.google.android.leanback.ime"; packagetarget="app/LeanbackIme";;
    tvmovies)                 packagetype="GApps"; packagename="com.google.android.videos.leanback"; packagetarget="app/VideosPano";;
    tvmusic)                  packagetype="GApps"; packagename="com.google.android.music"; packagetarget="app/Music2Pano";;  # Only change is the foldername
    tvpackageinstallergoogle) packagetype="GApps"; packagename="com.google.android.pano.packageinstaller"; packagetarget="priv-app/CanvasPackageInstaller";;  # on 5.1 and 6.0 this was in 'app'
    tvpairing)                packagetype="GApps"; packagename="com.google.android.fugu.pairing"; packagetarget="app/FuguPairingTutorial";;
    tvplaygames)              packagetype="GApps"; packagename="com.google.android.play.games.leanback"; packagetarget="app/PlayGames";;  # Only change is leanback in the packagename
    tvrecommendations)        packagetype="GApps"; packagename="com.google.android.leanbacklauncher.recommendations.leanback"; packagetarget="priv-app/RecommendationsService";;
    tvremote)                 packagetype="GApps";  packagetarget="priv-app/AtvRemoteService";
                              if [ "$API" -ge "24" ]; then
                                packagename="com.google.android.tv.remote.service.leanback"
                              else
                                packagename="com.google.android.tv.remote"
                                packagelibs="libatv_uinputbridge.so"
                              fi;;
    tvsearch)                 packagetype="GApps"; packagename="com.google.android.katniss.leanback"; packagetarget="priv-app/Katniss";;
    tvvoiceinput)             packagetype="GApps"; packagename="com.google.android.tv.voiceinput"; packagetarget="app/TvVoiceInput";;  # Only in 5.1
    tvwallpaper)              packagetype="GApps"; packagename="com.google.android.landscape"; packagetarget="app/LandscapeWallpaper";;
    tvwidget)                 packagetype="GApps"; packagename="com.google.android.atv.widget"; packagetarget="app/AtvWidget";;
    tvyoutube)                packagetype="GApps"; packagename="com.google.android.youtube.tv.leanback"; packagetarget="app/YouTubeLeanback";;

    # Swypelibs
    swypelibs)                packagetype="Optional"; packagelibs="libjni_latinimegoogle.so";
                              if [ "$API" -eq "23" ]; then  # On Marshmallow there is an extra lib
                                packagelibs="$packagelibs libjni_keyboarddecoder.so"
                              fi;;

    *)              echo "ERROR! Missing build rule for application with keyword $1"; exit 1;;
  esac
}

gappstvcore="bugreport
configupdater
googlebackuptransport
googlecontactssync
gsfcore
notouch
setupwraith
tvetc
tvframework
tvgmscore
tvvending"

gappstvstock="backdrop
castreceiver
gamepadpairing
globalkey
livechannels
overscan
remotecontrol
secondscreensetup
secondscreenauthbridge
talkback
tvcustomization
tvlauncher
tvkeyboardgoogle
tvmovies
tvmusic
tvpackageinstallergoogle
tvpairing
tvplaygames
tvremote
tvsearch
tvwidget
tvyoutube
tvwallpaper
webviewgoogle"

opengapps_generate_android_mk() {
	cat <<EOF
LOCAL_PATH := .
include \$(CLEAR_VARS)
include \$(GAPPS_CLEAR_VARS)
LOCAL_MODULE := $name
LOCAL_PACKAGE_NAME := $packagename
EOF

	if [[ "$(dirname "$packagetarget")" == "priv-app" ]]; then
		echo "LOCAL_PRIVILEGED_MODULE := true"
	fi

	for i in $packagelibs; do
		echo "LOCAL_SHARED_LIBRARIES += $(basename "$i" .so)"
	done

	echo "include \$(BUILD_GAPPS_PREBUILT_APK)"

	echo ""


	for i in $packagelibs; do
cat <<EOF
include \$(CLEAR_VARS)
include \$(GAPPS_CLEAR_VARS)
LOCAL_MODULE := \$(basename "$i" .so)
include \$(BUILD_GAPPS_PREBUILT_SHARED_LIBRARY)

EOF
	done
}

opengapps_generate_atv_mk() {
  if [[ $# -ne 1 ]]; then
    echo "usage: opengapps_generate_atv_mk <api-level>"
    return 1
  fi

  local MODULES=$(gettop)/vendor/opengapps/atv-build/modules

  rm -rf "$MODULES/"
  mkdir -p "$MODULES"

  API="$1"

  for i in $gappstvcore $gappstvstock; do
  	opengapps_get_package_info "$i"

    if [[ -z "$packagetarget" ]]; then
      continue
    fi

  	name="$(basename "$packagetarget")"
  	if [[ -z "$name" ]]; then
  		echo "FAILURE: $name" 1>&2
      return 1
  	fi

    echo "$name"

    if [[ -f "$(gettop)/vendor/opengapps/build/modules/$name/Android.mk" ]]; then
      continue
    fi

    mkdir -p "$MODULES/$name"
  	opengapps_generate_android_mk > "$MODULES/$name/Android.mk"
  done
}
