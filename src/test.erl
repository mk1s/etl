-module (test).
-compile(export_all).

-include ("../lib/rabbitmq-erlang-client/include/amqp_client.hrl").

run () ->
	{ok, Connection} = amqp_connection:start(#amqp_params_network{host = 'localhost'}),
	{ok, Channel} = amqp_connection:open_channel(Connection),
	
	#'queue.declare_ok'{queue = Queue} = amqp_channel:call(Channel, #'queue.declare'{exclusive=true}),
	Binding = #'queue.bind'{
		queue = Queue,
	    exchange = <<"test">>,
	 	routing_key = <<"test">>},
	#'queue.bind_ok'{} = amqp_channel:call(Channel, Binding),
	Payload = <<"foobar">>,
	Publish = #'basic.publish'{exchange = <<"test">>, routing_key = <<"test">>},
	amqp_channel:cast(Channel, Publish, #amqp_msg{payload = Payload}),
	Get = #'basic.get'{queue = Queue, no_ack = true},
	{#'basic.get_ok'{}, Content} = amqp_channel:call(Channel, Get),
	#amqp_msg{payload = Data} = Content,
	Data.