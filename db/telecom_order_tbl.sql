select * from dbo.telecom_order;
go
alter table PDP.dbo.telecom_order alter column [Request Number] nvarchar(255) NOT NULL;
go
ALTER TABLE pdp.dbo.telecom_order ADD CONSTRAINT
	PK_telecom_order PRIMARY KEY CLUSTERED 
	(
	[Request Number]
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO