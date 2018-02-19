.PHONY: clean all test

all: download-test-data

ala5-simulation-data:
	git clone https://github.com/rnowling/ala5-simulation-data.git

download-test-data: ala5-simulation-data

test: download-test-data
	bats tests/*.bats

clean:
	rm -rf ala5-simulation-data
