LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := AtvRemoteService
ifneq ($(filter $(call get-allowed-api-levels),24),)
LOCAL_PACKAGE_NAME := com.google.android.tv.remote.service.leanback
else
LOCAL_PACKAGE_NAME := com.google.android.tv.remote
LOCAL_SHARED_LIBRARIES += libatv_uinputbridge
endif
LOCAL_PRIVILEGED_MODULE := true
LOCAL_DEX_PREOPT := false
include $(BUILD_GAPPS_PREBUILT_APK)

include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := libatv_uinputbridge
ifdef TARGET_2ND_ARCH
  LOCAL_MULTILIB := both
endif
include $(BUILD_GAPPS_PREBUILT_SHARED_LIBRARY)
