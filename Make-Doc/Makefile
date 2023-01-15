.Phony: all
all: generate

generate: ContextView.png ComponentView.png

%.png: %.drawio
	/Applications/draw.io.app/Contents/MacOS/draw.io -x -f png -o $@ $<

.Phony: clean
clean:
	rm -f *.png