SELECT 
 --TOP 10
 sd.[STATE]+sd.[YEAR]+sd.[MONTH]+sd.[DAY]+sd.[SITE]+sd.COMMOD+rd.LAB+sd.SOURCE_ID AS [PDP Sample ID],
		rd.COMMOD As [Com], rd.PESTCODE As [Pest Code], pc.Descrip as [Pesticide Name],
		[CONCEN] As [Concen],[LOD],[CONUNIT] As [pp_],[ANNOTATE] As [Ann],[QUANTITATE] As [Qua],[MEAN] As [Mean],
		sd.COMMTYPE As [Type],sd.VARIETY As [Variety], sd.CLAIM As [Clm],sd.DISTTYPE As [Fac],sd.ORIGIN As [Origin],
		c.DESCRIP As Country, [ORIGST] As [State],[QUANTITY] As [Qty], t.EPATOL As [Tol (ppm)]
FROM PDP.dbo.ResultsData rd with (forceseek)
	INNER JOIN PDP.dbo.SampleData sd
		on rd.SAMPLE_PK = sd.SAMPLE_PK
	INNER JOIN PDP.dbo.PestCode_LU pc
		on rd.PESTCODE = pc.PESTCODE
	LEFT JOIN PDP.dbo.Country_LU c
		on sd.COUNTRY = c.COUNTRY
	LEFT JOIN PDP.dbo.Tolerance_LU t
		on rd.PDP_YEAR = t.PDP_YEAR
		AND rd.PESTCODE = t.PESTCODE
		AND rd.COMMOD = t.COMMOD
WHERE 
--PDP.dbo.[ResultsData].[COMMOD]='CU' AND PDP.dbo.[ResultsData].[PESTCODE]='204' and 
rd.PDP_YEAR= 2014
order by [PDP Sample ID]
OFFSET  5 ROWS 
FETCH NEXT 20 ROWS ONLY 

alter table PDP.dbo.ResultsData alter column SAMPLE_PK int NOT NULL;
alter table PDP.dbo.ResultsData alter column PESTCODE nvarchar(3) NOT NULL;
alter table PDP.dbo.ResultsData alter column PDP_YEAR smallint NOT NULL;
alter table PDP.dbo.ResultsData alter column COMMOD nvarchar(2) NOT NULL;


alter table PDP.dbo.ResultsData 
ADD CONSTRAINT PK_ResultsData PRIMARY KEY CLUSTERED (SAMPLE_PK, PESTCODE, PDP_YEAR, COMMOD);

create index indx_pdp_year on PDP.dbo.ResultsData (PDP_YEAR, SAMPLE_PK);

update statistics PDP.dbo.ResultsData;
update statistics PDP.dbo.SampleData;

select * from PDP.dbo.SampleData
select * from PDP.dbo.ResultsData
select PDP_YEAR, count(*) from PDP.dbo.ResultsData group by PDP_YEAR

SELECT  rd.PDP_YEAR, sd.[STATE]+sd.[YEAR]+sd.[MONTH]+sd.[DAY]+sd.[SITE]+sd.COMMOD+rd.LAB+sd.SOURCE_ID AS [PDP Sample ID],
		rd.COMMOD As [Com], rd.PESTCODE As [Pest Code], pc.Descrip as [Pesticide Name],
		[CONCEN] As [Concen],[LOD],[CONUNIT] As [pp_],[ANNOTATE] As [Ann],[QUANTITATE] As [Qua],[MEAN] As [Mean],
		sd.COMMTYPE As [Type],sd.VARIETY As [Variety], sd.CLAIM As [Clm],sd.DISTTYPE As [Fac],sd.ORIGIN As [Origin],
		c.DESCRIP As Country, [ORIGST] As [State],[QUANTITY] As [Qty], t.EPATOL As [Tol (ppm)]
FROM PDP.dbo.ResultsData rd
	INNER JOIN PDP.dbo.SampleData sd
		on rd.SAMPLE_PK = sd.SAMPLE_PK
	INNER JOIN PDP.dbo.PestCode_LU pc
		on rd.PESTCODE = pc.PESTCODE
	LEFT JOIN PDP.dbo.Country_LU c
		on sd.COUNTRY = c.COUNTRY
	LEFT JOIN PDP.dbo.Tolerance_LU t
		on rd.PDP_YEAR = t.PDP_YEAR
		AND rd.PESTCODE = t.PESTCODE
		AND rd.COMMOD = t.COMMOD
WHERE rd.PDP_YEAR= 2014 --rd.SAMPLE_PK=200000 AND rd.COMMOD='CU' AND rd.PESTCODE='204' and 
