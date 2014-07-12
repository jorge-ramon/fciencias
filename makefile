.PHONY: all coffee clean_coffee stylus clean_stylus clean_jade clean

define \n


endef

archivos_coffee := $(notdir $(wildcard coffee/*.coffee))
churritos_coffee := $(notdir $(wildcard coffee/*.coffee~))
archivos_stylus := $(notdir $(wildcard stylus/*.styl))
churritos_jade := $(notdir $(wildcard jade/*.jade~))
churritos_stylus := $(notdir $(wildcard stylus/*.styl~))
churritos := $(notdir $(wildcard *~))
churritos_servers := $(notdir $(wildcard servers/*.coffee~))

all:
	make clean
	make clean_coffee
	make coffee
	make clean_stylus
	make stylus
	make clean_jade
	make clean_servers

coffee:
	make clean_coffee
	$(foreach archivo,$(archivos_coffee),coffee -c -b -p coffee/$(archivo) > coffee/js/$(patsubst %.coffee,%.js,$(archivo))${\n})

clean_coffee:
	$(foreach archivo,$(churritos_coffee),rm coffee/$(archivo)${\n})

stylus:
	make clean_stylus
	$(foreach archivo,$(archivos_stylus),stylus -o stylus/css stylus/$(archivo)${\n})

clean_stylus:
	$(foreach archivo,$(churritos_stylus),rm stylus/$(archivo)${\n})

clean_jade:
	$(foreach archivo,$(churritos_jade),rm jade/$(archivo)${\n})

clean:
	$(foreach archivo,$(churritos),rm $(archivo)${\n})

clean_servers:
	$(foreach archivo,$(churritos_servers),rm servers/$(archivo)${\n})
