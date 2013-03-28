
all: dep compile

dep:
	./rebar get-deps

compile:
	./rebar compile

rel: all
	./rebar generate

clean:
	rm -rf log/*
	./rebar clean

dist-clean: clean
	./rebar delete-deps

current: clean
	git pull
	./rebar update-deps compile