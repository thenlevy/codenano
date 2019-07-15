all: codenano-gui server nanostructure dockerimage

server:
	cd server; cargo b

cadnano-gui:
	cd cadnano-gui; cargo b --target wasm32-unknown-unknown --release
	rm -Rf target/wasm
	mkdir -p target/wasm
	wasm-bindgen target/wasm32-unknown-unknown/release/codenano_gui.wasm --out-dir target/wasm
	cp index.js bootstrap.js package.json webpack.config.js target/wasm
	cd target/wasm; webpack-cli
	# rm -Rf static
	# cp -R static.template static
	cp target/wasm/dist/* static

# static: static.template
# 	mkdir -p static
# 	cp static.template/* static

cando: autoimpl finiteelement
	cargo test -p autoimpl -- from_cadnano
	cargo test -p finiteelement

nanostructure:
	cd nanostructure; cargo r

dockerimage:
	docker build . -t codenano

.PHONY: codenano-gui server nanostructure dockerimage
