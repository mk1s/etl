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
    {ok, { {one_for_one, 5, 10}, [?CHILD(etl_job_handler, worker)]} }.

stop() ->
	lager:warning("ETL is shutting down.~n"),
	application:stop(lager),
	application:stop(?MODULE).