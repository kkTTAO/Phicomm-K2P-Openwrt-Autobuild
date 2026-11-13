#!/bin/bash
#=================================================
# DIY script
#  1) 精简 lean 默认 router 包，给 xray 腾空间，争取塞进 16MB
#  2) 去掉 erofs-utils 主机工具（其源码镜像 404，K2P 用 squashfs 不需要它）
#=================================================
# 运行时当前目录是 openwrt/

# --- 1) 精简默认包 ---
f="include/target.mk"
for pkg in \
  luci-app-ddns luci-app-upnp luci-app-autoreboot luci-theme-design \
  luci-app-arpbind luci-app-filetransfer luci-app-vsftpd luci-app-vlmcsd \
  luci-app-accesscontrol luci-app-nlbwmon luci-app-turboacc luci-app-wol \
  ddns-scripts_aliyun ddns-scripts_dnspod
do
  sed -i "s/${pkg}//g" "$f"
done

# --- 2) 跳过 erofs-utils 主机工具 ---
sed -i '/^tools-y += erofs-utils/d' tools/Makefile

echo "[diy] trimmed default packages:"
grep "DEFAULT_PACKAGES.router" "$f" | head -n 3
echo "[diy] erofs-utils in tools-y after patch (should be 0):"
grep -c '^tools-y += erofs-utils' tools/Makefile || true
