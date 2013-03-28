-module(etl_sup).
-author ("roux <roux@mk1s.com>").
-behaviour(supervisor).
-export([start_link/0, stop/0]).
-export([init/1]).

-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

start_link() ->
	application:start(lager),
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
	Children = [
		?CHILD(etl_extract_server, worker),
		?CHILD(etl_transform_server, worker),
		?CHILD(etl_load_server, worker),
		?CHILD(etl_amqp_broker, worker)
	],
	
    {ok, { {one_for_one, 5, 10}, Children} }.

stop() ->
	application:stop(etl_extract_server),
	application:stop(etl_transform_server),
	application:stop(etl_load_server),
	application:stop(lager),
	application:stop(?MODULE).