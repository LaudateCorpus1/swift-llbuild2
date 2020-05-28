# This source file is part of the Swift.org open source project
#
# Copyright (c) 2020 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors

.PHONY:
generate: clean generate-protos

.PHONY:
update: clone-external-protos

# Clone external repositories.
.PHONY:
clone-external-repos:
	mkdir -p ExternalRepositories
	if [ ! -d ExternalRepositories/remote-apis ]; then \
		git -C ExternalRepositories clone --depth 1 https://github.com/bazelbuild/remote-apis; \
	else \
		git -C ExternalRepositories/remote-apis pull --rebase; \
	fi
	if [ ! -d ExternalRepositories/googleapis ]; then \
		git -C ExternalRepositories clone --depth 1 https://github.com/googleapis/googleapis; \
	else \
		git -C ExternalRepositories/googleapis pull --rebase; \
	fi

.PHONY:
clone-external-protos: clone-external-repos
	rm -rf Protos/BazelRemoteAPI
	mkdir -p Protos/BazelRemoteAPI
	rsync -arv --prune-empty-dirs --include \*/ \
		--include LICENSE \
		--include \*.proto \
		--exclude \* \
		ExternalRepositories/remote-apis Protos/BazelRemoteAPI
	rsync -arv --prune-empty-dirs --include \*/ \
		--include LICENSE \
		--include api/annotations.proto \
		--include api/client.proto \
		--include api/http.proto \
		--include bytestream/\*.proto \
		--include longrunning/\*.proto \
		--include rpc/\*.proto \
		--exclude \* \
		ExternalRepositories/googleapis Protos/BazelRemoteAPI

# These command should be executed any time the proto definitions change. It is
# not required to be generated as part of a regular `swift build` since we're
# checking in the generated sources.
.PHONY:
generate-protos: proto-toolchain Protos/BazelRemoteAPI
	mkdir -p Sources/LLBExecutionProtocol/Generated
	Utilities/tools/bin/protoc -I=Protos Protos/ExecutionProtocol/*.proto \
		--plugin=Utilities/tools/bin/protoc-gen-swift \
		--swift_out=Sources/LLBExecutionProtocol/Generated \
		--swift_opt=Visibility=Public \
		--swift_opt=ProtoPathModuleMappings=Protos/module_map.asciipb
	mkdir -p Sources/BazelRemoteAPI/Generated
	Utilities/tools/bin/protoc \
		-I=Protos/BazelRemoteAPI/googleapis \
		-I=Protos/BazelRemoteAPI/remote-apis \
		--plugin=Utilities/tools/bin/protoc-gen-swift \
		--swift_out=Sources/BazelRemoteAPI/Generated \
		--swift_opt=Visibility=Public \
		$$(find Protos/BazelRemoteAPI -name \*.proto)

.PHONY:
proto-toolchain:
	Utilities/build_proto_toolchain.sh

.PHONY:
clean:
	rm -rf Sources/BazelRemoteAPI/Generated
	rm -rf Sources/LLBExecutionProtocol/Generated

Protos/BazelRemoteAPI: clone-external-protos
