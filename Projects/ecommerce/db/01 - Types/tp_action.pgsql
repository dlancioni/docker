drop type if exists public.tp_action;
create type tp_action as
(
	id integer,	
	user_id integer,
	status integer,
	message text,
	last_id integer
);