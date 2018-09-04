USE [CES_Practice]
GO

/****** Object:  Table [dbo].[DU_Login]    Script Date: 04-09-2018 17:06:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DU_Login](
	[LoginID] [int] IDENTITY(100,1) NOT NULL,
	[LoginEmail] [nvarchar](100) NOT NULL,
	[LoginPassword] [nvarchar](30) NOT NULL,
	[OldLoginPassword] [nvarchar](30) NULL,
	[LastLoginTime] [datetime] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_DU_Login] PRIMARY KEY CLUSTERED 
(
	[LoginID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


