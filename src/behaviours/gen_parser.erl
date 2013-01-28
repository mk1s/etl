-module (gen_parser).
-export ([behaviour_info/1]).
-author ("roux <roux@mk1s.com").

behaviour_info (callbacks) ->
	[];
behaviour_info (_) ->
	undefined.
