alter table PDP.dbo.SampleData
 add CONSTRAINT FK_SampleData_Country FOREIGN KEY (COUNTRY)     
    REFERENCES PDP.dbo.Country_LU (COUNTRY);
/*
alter table PDP.dbo.ResultsData
 add CONSTRAINT FK_ResultsData_Tolerance FOREIGN KEY (PDP_YEAR, PESTCODE, COMMOD)     
    REFERENCES PDP.dbo.Tolerance_LU (PDP_YEAR, PESTCODE, COMMOD);

	select * from PDP.dbo.ResultsData rd where
	rd.PESTCODE='024' AND rd.PDP_YEAR=2010 AND rd.COMMOD='WG'
	select * from PDP.dbo.Tolerance_LU t where
	 t.PESTCODE='024' AND t.PDP_YEAR=2010 AND t.COMMOD='WG'
*/