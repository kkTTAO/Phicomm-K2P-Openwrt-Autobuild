#!/bin/bash
#=================================================
# DIY script - 极限精简默认包，给 xray 腾空间，争取塞进 16MB
#=================================================
# 运行时当前目录是 openwrt/，直接改 include/target.mk 里的 router 默认包
f="include/target.mk"

for pkg in \
  luci-app-ddns luci-app-upnp luci-app-autoreboot luci-theme-design \
  luci-app-arpbind luci-app-filetransfer luci-app-vsftpd luci-app-vlmcsd \
  luci-app-accesscontrol luci-app-nlbwmon luci-app-turboacc luci-app-wol \
  ddns-scripts_aliyun ddns-scripts_dnspod
do
  sed -i "s/${pkg}//g" "$f"
done

echo "[diy] trimmed default packages, remaining router defaults:"
grep "DEFAULT_PACKAGES.router" "$f" | head -n 3
