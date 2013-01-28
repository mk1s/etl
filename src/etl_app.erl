-module(etl_app).
-author ("roux <roux@mk1s.com>").
-behaviour(application).
-export([start/0, start/2, stop/1]).

start() ->
    etl_sup:start_link().

start(_StartType, _StartArgs) ->
    etl_sup:start_link().

stop(_State) ->
    ok.
