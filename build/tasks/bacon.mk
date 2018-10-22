# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017 The LineageOS Project
# Copyright (C) 2018 The PixelExperience Project
# Copyright (C) 2019-2020 Komodo OS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

KOMODO_TARGET_PACKAGE := $(PRODUCT_OUT)/$(KOMODO_VERSION).zip

.PHONY: bacon
bacon: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(KOMODO_TARGET_PACKAGE)
	$(hide) $(MD5SUM) $(KOMODO_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(KOMODO_TARGET_PACKAGE).md5sum
	$(hide) ./vendor/komodo/tools/generate_json_build_info.sh $(KOMODO_TARGET_PACKAGE)
	@echo -e ""
	@echo -e "Finnish ${cya}Building ${bldcya}Komodo ${txtrst}";
	@echo -e ""
	@echo -e ${CL_GRN}"	▄▄   ▄▄▄    ▄▄▄▄    ▄▄▄  ▄▄▄    ▄▄▄▄    ▄▄▄▄▄       ▄▄▄▄	"
	@echo -e ${CL_GRN}"	██  ██▀    ██▀▀██   ███  ███   ██▀▀██   ██▀▀▀██    ██▀▀██	"
	@echo -e ${CL_GRN}"	██▄██     ██    ██  ████████  ██    ██  ██    ██  ██    ██	"
	@echo -e ${CL_GRN}"	█████     ██    ██  ██ ██ ██  ██    ██  ██    ██  ██    ██	"
	@echo -e ${CL_GRN}"	██  ██▄   ██    ██  ██ ▀▀ ██  ██    ██  ██    ██  ██    ██	"
	@echo -e ${CL_GRN}"	██   ██▄   ██▄▄██   ██    ██   ██▄▄██   ██▄▄▄██    ██▄▄██	"
	@echo -e ${CL_GRN}"	▀▀    ▀▀    ▀▀▀▀    ▀▀    ▀▀    ▀▀▀▀    ▀▀▀▀▀       ▀▀▀▀	"
	@echo -e ""
	@echo -e "================================================"
	@echo -e ${CL_RED} "Komodo Dragon Islands"
	@echo -e "zip: "$(KOMODO_TARGET_PACKAGE)
	@echo -e "md5: `cat $(KOMODO_TARGET_PACKAGE).md5sum | cut -d ' ' -f 1`"
	@echo -e "size:`ls -lah $(KOMODO_TARGET_PACKAGE) | cut -d ' ' -f 5`"
	@echo -e "================================================"
	@echo -e ""
