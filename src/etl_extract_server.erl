-module (etl_extract_server).
-author ("roux <roux@mk1s.com>").


-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
        code_change/3]).

-export([start_link/0, start/0]).

init([]) ->
	{ok, []}.

start_link() ->
	lager:info("Starting extract server instance."),
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

start() ->
	lager:info("Starting extract server instance."),
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

handle_call(Call, From, State) ->
	{reply, ok, State}.

handle_cast(Request, State) ->
	{noreply, State}.
	
handle_info(Request, State) ->
	{noreply, State}.
	
terminate(Reason, State) ->
	lager:info("Stopping extract server instance."),
	ok.
	
code_change(OldVsn, State, Extra) ->
	{ok, State}.