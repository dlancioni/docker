CREATE TABLE [dbo].[tb_log]
(
	id int IDENTITY(1,1) NOT NULL,
	dt date NOT NULL,
	tm time NOT NULL
	CONSTRAINT [pk_price_id] PRIMARY KEY CLUSTERED ( id ASC )
)

select * FROM dbo.tb_log

TRUNCAte table dbo.tb_log


exec dbo.sp_log
as
begin
insert into dbo.tb_log (dt, tm) values (GETDATE(), GETDATE())
end