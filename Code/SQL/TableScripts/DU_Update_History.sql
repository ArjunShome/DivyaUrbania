USE [CES_Practice]
GO

/****** Object:  Table [dbo].[DU_Update_History]    Script Date: 04-09-2018 16:34:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DU_Update_History](
	[UpdateID] [int] IDENTITY(1,1) NOT NULL,
	[UpdateTable] [nvarchar](50) NOT NULL,
	[UpdateText] [nvarchar](50) NOT NULL,
	[UpdateUser] [nvarchar](50) NOT NULL,
	[UpdateDate] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DU_Update_History] PRIMARY KEY CLUSTERED 
(
	[UpdateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


