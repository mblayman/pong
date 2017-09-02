install:
	test -d pong/vendor/anim8 || git clone --depth 1 https://github.com/kikito/anim8.git pong/vendor/anim8
	test -d pong/vendor/knife || git clone --depth 1 https://github.com/airstruck/knife.git pong/vendor/knife
	test -d pong/vendor/hump || git clone --depth 1 https://github.com/vrld/hump.git pong/vendor/hump
