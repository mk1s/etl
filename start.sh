#!/bin/sh
cd `dirname $0`
ERL_LIBS=deps:lib/rabbitmq-erlang-client/dist
exec erl -pa $PWD/lib/*/ebin $PWD/ebin -pa $PWD/deps/*/ebin -sname etl