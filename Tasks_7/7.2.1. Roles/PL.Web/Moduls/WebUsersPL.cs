﻿using BLL.Common;
using BLL.Dependencies;
using Entitiens;
using PL.Common;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;

namespace PL.Web
{
    public class WebUsersPL : IUserPL
    {
        private IUserBLL _bll;
        private readonly CultureInfo cultureInfo = new CultureInfo("en-US");
        private readonly DateTimeStyles styles = 0;

        public WebUsersPL() => _bll = DependenciesBLL.UserBLL;
        public bool DeleteUser(Guid id) => _bll.DeleteUser(id);
        public IEnumerable<Users> DisplayAllUsers() => _bll.AllUsers;
        public Users GetUserByID(Guid id) => _bll.GetUserByID(id);
        public Guid SelectedUser() => new Guid();
        public bool AddUser(string name, string data)
        {
            if (DateTime.TryParse(data, cultureInfo, styles, out DateTime birthday))
            {
                return _bll.SaveUser(new Users(name, birthday));
            }
            else
            {
                return false;
            }
        }
        

        public bool EditUser(Guid id, string name, string data)
        {
            if (DateTime.TryParse(data, cultureInfo, styles, out DateTime birthday))
            {
                return _bll.EditUser(id, name, birthday);
            }
            else
            {
                return false;
            }
        }

        public bool RegistrationUser(string login, string password, bool admin) =>_bll.RegistrationUser(login, password, admin);
       public bool CheckForExistence(string name) => _bll.CheckForExistence(name);
        public string GetPassword(string name) => _bll.GetPassword(name);
    }
}