.PHONY: clean all test

all: download-test-data

download-test-data:
	git clone https://github.com/rnowling/ala5-simulation-data.git

test: download-test-data

clean:
	rm -rf ala5-simulation-data
