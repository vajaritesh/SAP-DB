USE [dbDemo]
GO

/****** Object:  Table [dbo].[Schools]    Script Date: 8/22/2023 8:56:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Schools](
	[SchoolId] [int] NULL,
	[SchoolName] [text] NULL,
	[City] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


