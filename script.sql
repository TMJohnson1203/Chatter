USE [master]
GO
/****** Object:  Database [Chatter]    Script Date: 11/14/2017 1:31:50 PM ******/
CREATE DATABASE [Chatter]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Chatter', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Chatter.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Chatter_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Chatter_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Chatter] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Chatter].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Chatter] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Chatter] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Chatter] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Chatter] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Chatter] SET ARITHABORT OFF 
GO
ALTER DATABASE [Chatter] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Chatter] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Chatter] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Chatter] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Chatter] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Chatter] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Chatter] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Chatter] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Chatter] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Chatter] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Chatter] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Chatter] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Chatter] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Chatter] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Chatter] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Chatter] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Chatter] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Chatter] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Chatter] SET  MULTI_USER 
GO
ALTER DATABASE [Chatter] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Chatter] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Chatter] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Chatter] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Chatter] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Chatter]
GO
/****** Object:  Table [dbo].[Chat]    Script Date: 11/14/2017 1:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat](
	[ChatID] [int] IDENTITY(1,1) NOT NULL,
	[MessageText] [nvarchar](140) NOT NULL,
	[NumOfLikes] [int] NULL,
	[UserID] [nvarchar](150) NOT NULL,
	[LikeID] [int] NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_Chat] PRIMARY KEY CLUSTERED 
(
	[ChatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Follow]    Script Date: 11/14/2017 1:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Follow](
	[FollowID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Follow] PRIMARY KEY CLUSTERED 
(
	[FollowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Like]    Script Date: 11/14/2017 1:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Like](
	[LikeID] [int] IDENTITY(1,1) NOT NULL,
	[ChatID] [int] NOT NULL,
	[UserID] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Like] PRIMARY KEY CLUSTERED 
(
	[LikeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 11/14/2017 1:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfo](
	[UserID] [nvarchar](150) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[UserEmail] [nvarchar](100) NOT NULL,
	[FollowID] [int] NULL,
	[ChatID] [int] NULL,
 CONSTRAINT [PK_UserInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Chat]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Like] FOREIGN KEY([LikeID])
REFERENCES [dbo].[Like] ([LikeID])
GO
ALTER TABLE [dbo].[Chat] CHECK CONSTRAINT [FK_Chat_Like]
GO
ALTER TABLE [dbo].[Follow]  WITH CHECK ADD  CONSTRAINT [FK_Follow_UserInfo] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfo] ([UserID])
GO
ALTER TABLE [dbo].[Follow] CHECK CONSTRAINT [FK_Follow_UserInfo]
GO
ALTER TABLE [dbo].[Like]  WITH CHECK ADD  CONSTRAINT [FK_Like_Chat] FOREIGN KEY([ChatID])
REFERENCES [dbo].[Chat] ([ChatID])
GO
ALTER TABLE [dbo].[Like] CHECK CONSTRAINT [FK_Like_Chat]
GO
ALTER TABLE [dbo].[Like]  WITH CHECK ADD  CONSTRAINT [FK_Like_UserInfo] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfo] ([UserID])
GO
ALTER TABLE [dbo].[Like] CHECK CONSTRAINT [FK_Like_UserInfo]
GO
ALTER TABLE [dbo].[UserInfo]  WITH CHECK ADD  CONSTRAINT [FK_UserInfo_Chat] FOREIGN KEY([ChatID])
REFERENCES [dbo].[Chat] ([ChatID])
GO
ALTER TABLE [dbo].[UserInfo] CHECK CONSTRAINT [FK_UserInfo_Chat]
GO
ALTER TABLE [dbo].[UserInfo]  WITH CHECK ADD  CONSTRAINT [FK_UserInfo_Follow] FOREIGN KEY([FollowID])
REFERENCES [dbo].[Follow] ([FollowID])
GO
ALTER TABLE [dbo].[UserInfo] CHECK CONSTRAINT [FK_UserInfo_Follow]
GO
USE [master]
GO
ALTER DATABASE [Chatter] SET  READ_WRITE 
GO
