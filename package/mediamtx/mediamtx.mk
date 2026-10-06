################################################################################
#
# mediamtx
#
################################################################################

MEDIAMTX_VERSION = 1.7.0
MEDIAMTX_SOURCE = mediamtx-$(MEDIAMTX_VERSION).tar.gz
MEDIAMTX_SITE = https://github.com/bluenviron/mediamtx/archive/refs/tags/v$(MEDIAMTX_VERSION)
MEDIAMTX_LICENSE = MIT
MEDIAMTX_LICENSE_FILES = LICENSE

MEDIAMTX_DEPENDENCIES = host-go

define MEDIAMTX_FIX_EMBED
	sed -i '/\/\/go:embed hls.min.js/d' $(@D)/internal/servers/hls/http_server.go
	sed -i 's/var hlsJS \[\]byte/var hlsJS = []byte("\/\/ HLS JavaScript")/' $(@D)/internal/servers/hls/http_server.go
	echo "// HLS JavaScript" > $(@D)/hls.min.js
endef

MEDIAMTX_POST_EXTRACT_HOOKS += MEDIAMTX_FIX_EMBED

define MEDIAMTX_BUILD_CMDS
	cd $(@D) && \
	CGO_ENABLED=0 \
	GO111MODULE=on \
	GOOS=linux \
	GOARCH=arm64 \
	GOPROXY=https://goproxy.cn,direct \
	GOSUMDB=off \
	$(HOST_DIR)/bin/go build \
		-mod=readonly \
		-trimpath \
		-ldflags "-X github.com/bluenviron/mediamtx/internal/core.version=v$(MEDIAMTX_VERSION) -s -w" \
		-o mediamtx \
		.
endef

define MEDIAMTX_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/mediamtx $(TARGET_DIR)/usr/bin/mediamtx
	$(INSTALL) -D -m 0644 $(@D)/mediamtx.yml $(TARGET_DIR)/etc/mediamtx.yml
endef

$(eval $(generic-package))
