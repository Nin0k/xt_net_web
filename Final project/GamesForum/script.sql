USE [master]
GO
/****** Object:  Database [forum]    Script Date: 28.10.2020 23:54:43 ******/
CREATE DATABASE [forum]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'forum', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\forum.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'forum_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\forum_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [forum] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [forum].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [forum] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [forum] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [forum] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [forum] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [forum] SET ARITHABORT OFF 
GO
ALTER DATABASE [forum] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [forum] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [forum] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [forum] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [forum] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [forum] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [forum] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [forum] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [forum] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [forum] SET  DISABLE_BROKER 
GO
ALTER DATABASE [forum] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [forum] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [forum] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [forum] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [forum] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [forum] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [forum] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [forum] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [forum] SET  MULTI_USER 
GO
ALTER DATABASE [forum] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [forum] SET DB_CHAINING OFF 
GO
ALTER DATABASE [forum] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [forum] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [forum] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [forum] SET QUERY_STORE = OFF
GO
USE [forum]
GO
/****** Object:  Table [dbo].[forums]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[forums](
	[id_forum] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[massages]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[massages](
	[id_massages] [uniqueidentifier] NOT NULL,
	[id_user] [uniqueidentifier] NOT NULL,
	[id_topic] [uniqueidentifier] NOT NULL,
	[data] [datetime] NOT NULL,
	[reputation] [int] NOT NULL,
	[text] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[topics]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[topics](
	[id_topic] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[important] [bit] NOT NULL,
	[id_forum] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id_user] [uniqueidentifier] NOT NULL,
	[nickname] [nvarchar](50) NOT NULL,
	[date_registration] [datetime] NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[reputation] [int] NOT NULL,
	[admin] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Forum_GetById]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Forum_GetById]
	@id uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP 1 
		name FROM forums
		WHERE id_forum = @id
END
GO
/****** Object:  StoredProcedure [dbo].[Forum_GetByName]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Forum_GetByName]
	@name nvarchar(50)
	AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP 1 
		id_forum FROM forums
		WHERE name = @name
END
GO
/****** Object:  StoredProcedure [dbo].[Forums_GetAllForums]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Forums_GetAllForums] 
	AS
BEGIN
	SET NOCOUNT ON;
	SELECT id_forum, name FROM forums
END
GO
/****** Object:  StoredProcedure [dbo].[Massages_GetByMassagesWhisIdTopic]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Massages_GetByMassagesWhisIdTopic]
	@id uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
	id_massages, id_user, data, reputation, text FROM massages
		WHERE id_topic = @id
END
GO
/****** Object:  StoredProcedure [dbo].[Message_GetById]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Message_GetById]
	@id uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP 1 
		id_user, id_topic, data, reputation, text FROM massages
		WHERE id_massages = @id
END
GO
/****** Object:  StoredProcedure [dbo].[Message_UpdateMessang]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Message_UpdateMessang]
	@id_messange uniqueidentifier, 
	@text nvarchar(max),
	@reputation int
AS
BEGIN
	SET NOCOUNT ON;

   UPDATE massages SET text=@text, reputation=@reputation WHERE id_massages=@id_messange
END
GO
/****** Object:  StoredProcedure [dbo].[Messages_CreateNewMessage]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
CREATE PROCEDURE [dbo].[Messages_CreateNewMessage]
	@id_messange uniqueidentifier,
	@id_user uniqueidentifier,
	@id_topic uniqueidentifier,
	@text nvarchar(max),
	@reputation int,
	@data datetime
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO massages(id_massages, id_user, id_topic, data, reputation, text) VALUES (@id_messange, @id_user, @id_topic, @data, @reputation, @text)
END
GO
/****** Object:  StoredProcedure [dbo].[Messages_DeleteMessage]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Messages_DeleteMessage]
	@id uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM massages
		WHERE id_massages = @id
END
GO
/****** Object:  StoredProcedure [dbo].[Topic_CreateNewTopi]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Topic_CreateNewTopi] 
	@id_topic uniqueidentifier,
	@name nvarchar(50),
	@important bit,
	@id_forum uniqueidentifier
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO topics(id_topic, name, important, id_forum) VALUES (@id_topic, @name, @important, @id_forum)
END
GO
/****** Object:  StoredProcedure [dbo].[Topic_GetById]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Topic_GetById] 
	@id uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP 1 
		name, important, id_forum FROM topics
		WHERE id_topic = @id
END
GO
/****** Object:  StoredProcedure [dbo].[Topic_GetByIdForum]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Topic_GetByIdForum]
	@idForum uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		id_topic, name, important FROM topics
		WHERE id_forum = @idForum
END
GO
/****** Object:  StoredProcedure [dbo].[Topics_DeleteTopic]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Topics_DeleteTopic]
	@id uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM topics
		WHERE id_topic = @id
END
GO
/****** Object:  StoredProcedure [dbo].[User_UpdateUser]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[User_UpdateUser]
	@id_user uniqueidentifier, 
	@admin bit,
	@reputation int
AS
BEGIN
	SET NOCOUNT ON;

   UPDATE users SET admin=@admin, reputation=@reputation WHERE id_user=@id_user
END
GO
/****** Object:  StoredProcedure [dbo].[Users_DeleteUser]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_DeleteUser]
	@id uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM users
		WHERE id_user = @id
		
END
GO
/****** Object:  StoredProcedure [dbo].[Users_GetAllUsers]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
CREATE PROCEDURE [dbo].[Users_GetAllUsers]
AS
BEGIN
	SET NOCOUNT ON;

   SELECT id_user, nickname, admin, reputation, password, date_registration FROM users
END
GO
/****** Object:  StoredProcedure [dbo].[Users_GetById]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_GetById]
	@id uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP 1 
		nickname,date_registration, password,reputation,admin FROM users
		WHERE id_user = @id
END
GO
/****** Object:  StoredProcedure [dbo].[Users_GetByName]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_GetByName]
	
	@nickname nvarchar(50)
	
AS
BEGIN
	SET NOCOUNT ON;

   SELECT TOP 1 
		nickname FROM users
		WHERE nickname = @nickname
END
GO
/****** Object:  StoredProcedure [dbo].[Users_GetPassword]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_GetPassword]
	
	@nickname nvarchar(50)
	
AS
BEGIN
	SET NOCOUNT ON;

SELECT password FROM users
   WHERE nickname  = @nickname
END
GO
/****** Object:  StoredProcedure [dbo].[Users_GetRolesForUser]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_GetRolesForUser]
	
	@nickname nvarchar(50)
	
AS
BEGIN
	SET NOCOUNT ON;

 SELECT admin FROM users
   WHERE nickname = @nickname
END
GO
/****** Object:  StoredProcedure [dbo].[Users_GetUserByName]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
CREATE PROCEDURE [dbo].[Users_GetUserByName]
	@nickname nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;

  SELECT TOP 1 
		id_user,date_registration,password,reputation,admin FROM users
		WHERE nickname = @nickname
END
GO
/****** Object:  StoredProcedure [dbo].[Users_RegistrationUser]    Script Date: 28.10.2020 23:54:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_RegistrationUser]
	
	@nickname nvarchar(50),
	@password nvarchar(50),
	@admin bit,
	@id_user uniqueidentifier,
	@data datetime,
	@reputation int

AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO users(id_user, nickname, date_registration, password, reputation, admin) VALUES (@id_user, @nickname, @data, @password, @reputation, @admin)
END
GO
USE [master]
GO
ALTER DATABASE [forum] SET  READ_WRITE 
GO
