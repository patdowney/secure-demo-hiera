
PACKAGE_PRODUCT=secure-demo-hiera
PACKAGE_VERSION=0.1.0
ARCH="386 amd64 arm"

default: bintray build package

clean:
	rm -rf .build
	rm -f .output/*.deb .output/*.rpm

bintray:
	cat .bintray/rpm.json.template | sed "s:%%PACKAGE_NAME%%:$(PACKAGE_PRODUCT):g;s:%%PACKAGE_VERSION%%:$(PACKAGE_VERSION):g;" > .bintray/rpm.json
	cat .bintray/deb.json.template | sed "s:%%PACKAGE_NAME%%:$(PACKAGE_PRODUCT):g;s:%%PACKAGE_VERSION%%:$(PACKAGE_VERSION):g;" > .bintray/deb.json

build:
	./build.sh
package:
	PACKAGE_PRODUCT=$(PACKAGE_PRODUCT) PACKAGE_VERSION=$(PACKAGE_VERSION) PACKAGE_ARCH=$(PACKAGE_ARCH) ./package.sh

