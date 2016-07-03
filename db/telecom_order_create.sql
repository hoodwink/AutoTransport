USE [PDP]
GO

/****** Object:  Table [dbo].[telecom_order]    Script Date: 7/3/2016 12:19:03 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[telecom_order](
	[Request Number] [nvarchar](255) NOT NULL,
	[Order Date] [datetime] NULL,
	[Fiscal Year] [float] NULL,
	[Submitter] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[Program] [nvarchar](255) NULL,
	[Branch] [nvarchar](255) NULL,
	[Group] [nvarchar](255) NULL,
	[Option] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[Link] [nvarchar](255) NULL,
 CONSTRAINT [PK_telecom_order] PRIMARY KEY CLUSTERED 
(
	[Request Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


