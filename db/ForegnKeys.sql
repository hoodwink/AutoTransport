alter table PDP.dbo.SampleData
 add CONSTRAINT FK_SampleData_Country FOREIGN KEY (COUNTRY)     
    REFERENCES PDP.dbo.Country_LU (COUNTRY);