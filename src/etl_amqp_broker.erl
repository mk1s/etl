-module (etl_amqp_broker).
-author ("roux <roux@mk1s.com>").

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
        code_change/3]).

-export([start_link/0, start/0]).

-include ("../lib/rabbitmq-erlang-client/include/amqp_client.hrl").

-record (state, {}).

init([]) ->
	State = #state{},
	{ok, State}.

start_link() ->
	lager:info("Starting amqp broker."),
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

start() ->
	lager:info("Starting amqp broker."),
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

handle_call(Call, From, State) ->
	{reply, ok, State}.

handle_cast(Request, State) ->
	{noreply, State}.
	
handle_info(Request, State) ->
	{noreply, State}.
	
terminate(Reason, State) ->
	lager:info("Stopping amqp broker."),
	ok.
	
code_change(OldVsn, State, Extra) ->
	{ok, State}.