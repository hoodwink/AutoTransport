-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gzinger
-- Create date: 2016-06-16
-- Description:	
-- =============================================
CREATE FUNCTION dbo.get_pdp_result_tbl 
(	
	-- Add the parameters for the function here
	@start_offset int, 
	@numb_rows int
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT --TOP 10000
 sd.[STATE]+sd.[YEAR]+sd.[MONTH]+sd.[DAY]+sd.[SITE]+sd.COMMOD+rd.LAB+sd.SOURCE_ID AS [PDP Sample ID],
		rd.COMMOD As [Com], rd.PESTCODE As [Pest Code], pc.Descrip as [Pesticide Name],
		[CONCEN] As [Concen],[LOD],[CONUNIT] As [pp_],[ANNOTATE] As [Ann],[QUANTITATE] As [Qua],[MEAN] As [Mean],
		sd.COMMTYPE As [Type],sd.VARIETY As [Variety], sd.CLAIM As [Clm],sd.DISTTYPE As [Fac],sd.ORIGIN As [Origin],
		c.DESCRIP As Country, [ORIGST] As [State],[QUANTITY] As [Qty], t.EPATOL As [Tol (ppm)]
FROM PDP.dbo.ResultsData rd --with (forceseek)
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
--WHERE 
--PDP.dbo.[ResultsData].[COMMOD]='CU' AND PDP.dbo.[ResultsData].[PESTCODE]='204' and 
--rd.PDP_YEAR= 2014
order by rd.PDP_YEAR
OFFSET  @start_offset ROWS 
FETCH NEXT @numb_rows ROWS ONLY 
)
GO
