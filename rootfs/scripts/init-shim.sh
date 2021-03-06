#!/bin/bash
# Copyright © 2022 sealyun.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

source common.sh
registry=${1:-sealos.hub}
registry_port=${2:-5000}
cp -rf ../etc/image-cri-shim.service /etc/systemd/system/
cp -rf ../etc/image-cri-shim.yaml /etc
sed -i "s/sealos.hub:5000/$registry:$registry_port/g" /etc/systemd/system/image-cri-shim.service
sed -i "s/sealos.hub:5000/$registry:$registry_port/g" /etc/image-cri-shim.yaml
chmod -R 755 ../cri
cp -rf ../cri/image-cri-shim /usr/bin
cp -rf ../etc/crictl.yaml /etc
chmod a+x /usr/bin/*
systemctl enable image-cri-shim.service
systemctl daemon-reload
systemctl restart image-cri-shim.service
check_status image-cri-shim
logger "init shim success"
