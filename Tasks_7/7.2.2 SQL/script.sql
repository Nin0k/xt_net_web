USE [master]
GO
/****** Object:  Database [UsersAndAwards]    Script Date: 24.09.2020 19:41:40 ******/
CREATE DATABASE [UsersAndAwards]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UsersAndAwards', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\UsersAndAwards.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'UsersAndAwards_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\UsersAndAwards_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [UsersAndAwards] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UsersAndAwards].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UsersAndAwards] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UsersAndAwards] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UsersAndAwards] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UsersAndAwards] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UsersAndAwards] SET ARITHABORT OFF 
GO
ALTER DATABASE [UsersAndAwards] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UsersAndAwards] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UsersAndAwards] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UsersAndAwards] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UsersAndAwards] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UsersAndAwards] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UsersAndAwards] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UsersAndAwards] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UsersAndAwards] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UsersAndAwards] SET  DISABLE_BROKER 
GO
ALTER DATABASE [UsersAndAwards] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UsersAndAwards] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UsersAndAwards] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UsersAndAwards] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UsersAndAwards] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UsersAndAwards] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UsersAndAwards] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UsersAndAwards] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [UsersAndAwards] SET  MULTI_USER 
GO
ALTER DATABASE [UsersAndAwards] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UsersAndAwards] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UsersAndAwards] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UsersAndAwards] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [UsersAndAwards] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [UsersAndAwards] SET QUERY_STORE = OFF
GO
USE [UsersAndAwards]
GO
/****** Object:  Table [dbo].[Awards]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Awards](
	[IDAward] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Awards] PRIMARY KEY CLUSTERED 
(
	[IDAward] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegisteredUsers]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegisteredUsers](
	[Name] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Admin] [bit] NOT NULL,
 CONSTRAINT [PK_RegisteredUsers] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rewards]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rewards](
	[IDUser] [uniqueidentifier] NOT NULL,
	[IDAward] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[IDUser] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[DateOfBirth] [datetime] NOT NULL,
	[Age] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[IDUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Rewards]  WITH CHECK ADD  CONSTRAINT [FK_Rewards_Awards] FOREIGN KEY([IDAward])
REFERENCES [dbo].[Awards] ([IDAward])
GO
ALTER TABLE [dbo].[Rewards] CHECK CONSTRAINT [FK_Rewards_Awards]
GO
ALTER TABLE [dbo].[Rewards]  WITH CHECK ADD  CONSTRAINT [FK_Rewards_Users1] FOREIGN KEY([IDUser])
REFERENCES [dbo].[Users] ([IDUser])
GO
ALTER TABLE [dbo].[Rewards] CHECK CONSTRAINT [FK_Rewards_Users1]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Users] FOREIGN KEY([IDUser])
REFERENCES [dbo].[Users] ([IDUser])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Users]
GO
/****** Object:  StoredProcedure [dbo].[Awards_DeleteAward]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Awards_DeleteAward] 
	@id uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM Awards
		WHERE IDAward = @id
END
GO
/****** Object:  StoredProcedure [dbo].[Awards_GetAllAwards]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Awards_GetAllAwards] 

	AS
BEGIN
	SET NOCOUNT ON;

	SELECT IDAward, Title FROM Awards
END
GO
/****** Object:  StoredProcedure [dbo].[Awards_GetById]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Awards_GetById] 
	@id uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP 1 
		IDAward, Title FROM Awards
		WHERE IDAward = @id
END
GO
/****** Object:  StoredProcedure [dbo].[Awards_SaveAward]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Awards_SaveAward]
	@ID uniqueidentifier,
	@Title nvarchar(50)
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO Awards(IDAward, Title) VALUES (@ID, @Title)
END
GO
/****** Object:  StoredProcedure [dbo].[Awards_UpdateAward]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Awards_UpdateAward]
@ID uniqueidentifier, 
@Title nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

   UPDATE Awards SET Title=@Title WHERE IDAward=@ID
END
GO
/****** Object:  StoredProcedure [dbo].[RegisteredUsers_GetByName]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegisteredUsers_GetByName] 
	@Name nvarchar(50)
	AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP 1 
		Name FROM RegisteredUsers
		WHERE Name = @Name
END
GO
/****** Object:  StoredProcedure [dbo].[RegisteredUsers_GetPassword]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegisteredUsers_GetPassword]
	@Name nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

   SELECT Password FROM RegisteredUsers
   WHERE Name = @Name
END
GO
/****** Object:  StoredProcedure [dbo].[RegisteredUsers_GetRolesForUser]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegisteredUsers_GetRolesForUser]
	@Name nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

   SELECT Admin FROM RegisteredUsers
   WHERE Name = @Name
END
GO
/****** Object:  StoredProcedure [dbo].[RegisteredUsers_RegistrationUser]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegisteredUsers_RegistrationUser]
	@Name nvarchar(50),
	@Password nvarchar(50),
	@Admin bit
AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO RegisteredUsers(Name, Password, Admin) VALUES (@Name, @Password, @Admin)
END
GO
/****** Object:  StoredProcedure [dbo].[Rewards_AllRewards]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Rewards_AllRewards] 
	AS
BEGIN
	SET NOCOUNT ON;

	SELECT Users.IDUser, Users.Name, Users.DateOfBirth, Users.Age, Awards.IDAward, Awards.Title 
	FROM Users
	INNER JOIN Rewards
		ON Users.IDUser = Rewards.IDUser
	INNER JOIN Awards
		ON Awards.IDAward = Rewards.IDAward
END
GO
/****** Object:  StoredProcedure [dbo].[Rewards_DeleteAward]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Rewards_DeleteAward] 
	@IDAward uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM Rewards
		WHERE IDAward = @IDAward
END
GO
/****** Object:  StoredProcedure [dbo].[Rewards_DeleteReward]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Rewards_DeleteReward] 
	@IDUser uniqueidentifier,
	@IDAward uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM Rewards
		WHERE IDUser = @IDUser AND IDAward = @IDAward
END
GO
/****** Object:  StoredProcedure [dbo].[Rewards_DeleteUser]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Rewards_DeleteUser]
	@IDUser uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM Rewards
		WHERE IDUser = @IDUser
END
GO
/****** Object:  StoredProcedure [dbo].[Rewards_SaveRaward]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Rewards_SaveRaward]
	@IDUser uniqueidentifier,
	@IDAward uniqueidentifier
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO Rewards(IDUser, IDAward) VALUES (@IDUser, @IDAward)
END
GO
/****** Object:  StoredProcedure [dbo].[Rewards_SaveReward]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Rewards_SaveReward]
	@IDUser uniqueidentifier,
	@IDAward uniqueidentifier
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO Rewards(IDUser, IDAward) VALUES (@IDUser, @IDAward)
END
GO
/****** Object:  StoredProcedure [dbo].[Rewards_UsersWithAward]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Rewards_UsersWithAward]
@ID uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	SELECT Users.IDUser, Users.Name, Users.DateOfBirth, Users.Age 
	FROM Users
	INNER JOIN Rewards
		ON Users.IDUser = Rewards.IDUser
	WHERE Rewards.IDAward = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[Users_DeleteUser]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_DeleteUser] 
	@id uniqueidentifier
	AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM Users
		WHERE IDUser = @id
		
END
GO
/****** Object:  StoredProcedure [dbo].[Users_GetAllUsers]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_GetAllUsers]

AS
BEGIN
	SET NOCOUNT ON;

   SELECT IDUser, Name, DateOfBirth, Age FROM Users
END
GO
/****** Object:  StoredProcedure [dbo].[Users_GetById]    Script Date: 24.09.2020 19:41:41 ******/
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
		IDUser, Name, DateOfBirth, Age FROM Users
		WHERE IDUser = @id
END
GO
/****** Object:  StoredProcedure [dbo].[Users_SaveUser]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_SaveUser]
	@ID uniqueidentifier,
	@Name nvarchar(50),
	@DateOfBirth datetime,
	@Age int
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO Users(IDUser, Name, DateOfBirth, Age) VALUES (@ID, @Name, @DateOfBirth, @Age)
END
GO
/****** Object:  StoredProcedure [dbo].[Users_UpdateUsers]    Script Date: 24.09.2020 19:41:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_UpdateUsers]
@ID uniqueidentifier, 
@Name nvarchar(50),
@DateOfBirth datetime,
@Age int
AS
BEGIN
	SET NOCOUNT ON;

   UPDATE Users SET Name=@Name, DateOfBirth=@DateOfBirth, Age=@Age  WHERE IDUser=@ID
END
GO
USE [master]
GO
ALTER DATABASE [UsersAndAwards] SET  READ_WRITE 
GO
