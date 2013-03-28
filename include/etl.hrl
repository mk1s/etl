-ifndef(ETL_HRL).
-define (ETL_HRL).

-record (DEF_EXCHANGE, <<"roux_etl">>).

-record (job, {
	job_id 		=			:: list(),
	datafile	= undefined	:: undefined | string(),
	queue_type	= local 	:: local | bucket,
	mod 		= 			:: atom(),
	func		=			:: atom(),
	args		= 			:: proplist()	
}).

-endif

