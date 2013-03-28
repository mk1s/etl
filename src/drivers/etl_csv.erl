-module (etl_csv).

-export ([init/1, init/2, parse/1]).
-export ([validate_line/2, parse_line/2]).

-type queue_type() :: local | bucket.

-record (state, {
	filename = "" 		:: string(),
	queue = local 		:: queue_type(),
	field_sep = ',' 	:: char(),
	field_delim = undefined 	:: undefined | char(),
	headers = []		:: list(),
	header_count = 	0	:: pos_integer(),
	line_count = 0		:: pos_integer(),
	error_count = 0		:: pos_integer(),
	errors = undefined	:: term()
}).

-define (DEF_QUEUE_DIR, "queue/parser").

init ({QueueType, FileName}) ->
	case QueueType of
		local ->
			case filelib:is_file(filename:join(?DEF_QUEUE_DIR, FileName)) of
				true -> {ok, #state{filename=FileName, queue=QueueType}};
				false -> {error, "File Not Found"}					
			end;
		bucket -> {error, "Feature not yet implemented."}
	end.
	
init ({QueueType, FileName}, Opts) ->
	case QueueType of
		local -> 
			case filelib:is_file(FileName) of
				true -> {ok, #state{}};
				_ -> {error, "File Not Found"}
			end;
		bucket -> {error, "Feature not yet implemented."}
	end.

parse (State) when is_record(State, state) ->
	{ok, IoDevice} = file:open(filename:join(?DEF_QUEUE_DIR, State#state.filename), ""),
	read_line(IoDevice, fun validate_line/2, State),
	file:close(IoDevice),
	State.

read_line(IoDevice, Func, State) ->
	case io:get_line(IoDevice, "") of
		eof ->
			State#state.line_count;
		Line -> 
			Val = Func(Line),
			NewState = State#state{line_count=State#state.line_count + 1},
			read_line(IoDevice, Func, NewState)			
	end.

validate_line (Line, State) ->
	case State#state.line_count of
		0 ->		%% Extract headers
			Data = parse_line(Line, State);
		_ ->		%% Qualify against headers
			Data = parse_line(Line, State)
	end,
	Data.

parse_line(Line, State) ->	
	FieldData = string:tokens(Line, State#state.field_sep).
		
		
		