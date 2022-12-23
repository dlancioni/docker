drop type if exists public.tp_action;
create type tp_action as
(
	user_id integer,
	action_id integer,
	status_id integer,
	message text,
	last_id integer
);