use [PDP]
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [_dta_index_ResultsData_5_2053582354__K3_K2_K4_K1_6_8_9_10_13_14_15] ON [dbo].[ResultsData]
(
	[PDP_YEAR] ASC,
	[PESTCODE] ASC,
	[COMMOD] ASC,
	[SAMPLE_PK] ASC
)
INCLUDE ( 	[LAB],
	[CONCEN],
	[LOD],
	[CONUNIT],
	[ANNOTATE],
	[QUANTITATE],
	[MEAN]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

ALTER TABLE pdp.dbo.ResultsData ADD CONSTRAINT
	PK_ResultsData PRIMARY KEY CLUSTERED 
	(
	PDP_YEAR,
	PESTCODE,
	COMMOD,
	SAMPLE_PK
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE STATISTICS [_dta_stat_2053582354_2_3_4] ON [dbo].[ResultsData]([PESTCODE], [PDP_YEAR], [COMMOD])
go

CREATE STATISTICS [_dta_stat_2053582354_2_4_1] ON [dbo].[ResultsData]([PESTCODE], [COMMOD], [SAMPLE_PK])
go

CREATE STATISTICS [_dta_stat_2053582354_1_3_2_4] ON [dbo].[ResultsData]([SAMPLE_PK], [PDP_YEAR], [PESTCODE], [COMMOD])
go

grant update on pdp.dbo.resultsdata to pdp_user;

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [_dta_index_SampleData_5_66099276__K11_K1_2_3_4_5_6_7_8_9_10_12_13_14_15_19] ON [dbo].[SampleData]
(
	[COUNTRY] ASC,
	[SAMPLE_PK] ASC
)
INCLUDE ( 	[STATE],
	[YEAR],
	[MONTH],
	[DAY],
	[SITE],
	[COMMOD],
	[SOURCE_ID],
	[VARIETY],
	[ORIGIN],
	[DISTTYPE],
	[COMMTYPE],
	[CLAIM],
	[QUANTITY],
	[ORIGST]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

SET ANSI_PADDING ON

go

--drop index [_dta_index_Tolerance_LU_5_613577224__K1_K2_K3_4] ON pdp.[dbo].[Tolerance_LU];
/*CREATE NONCLUSTERED INDEX [_dta_index_Tolerance_LU_5_613577224__K1_K2_K3_4] ON [dbo].[Tolerance_LU]
(
	[PDP_YEAR] ASC,
	[PESTCODE] ASC,
	[COMMOD] ASC
)*/

alter table PDP.dbo.Tolerance_LU alter column PDP_YEAR smallint NOT NULL;
alter table PDP.dbo.Tolerance_LU alter column PESTCODE nvarchar(3) NOT NULL;
alter table PDP.dbo.Tolerance_LU alter column COMMOD nvarchar(2) NOT NULL;
alter table PDP.dbo.Tolerance_LU alter column EPATOL nvarchar(15) NOT NULL;
alter table PDP.dbo.Tolerance_LU ADD CONSTRAINT PK_Tolerance_LU PRIMARY KEY
 CLUSTERED (PDP_YEAR, PESTCODE, COMMOD);



use pdp;

--drop STATISTICS [dbo].[Tolerance_LU].[_dta_stat_613577224_2_3];
CREATE STATISTICS [_dta_stat_613577224_2_3] ON [dbo].[Tolerance_LU]([PESTCODE], [COMMOD])
go

--drop INDEX [Tolerance_LU$PESTCODE] ON [dbo].[Tolerance_LU];
CREATE NONCLUSTERED INDEX [Tolerance_LU$PESTCODE] ON [dbo].[Tolerance_LU]
(
	[PESTCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO





