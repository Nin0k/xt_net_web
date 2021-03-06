﻿using Entitiens;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Common
{
    public interface IAwardBLL
    {
        bool SaveAward(Awards award);
        bool DeleteAward(Guid id);
        IEnumerable<Awards> GetAllAwards();
        Awards GetAwardByID(Guid id);
        bool EditAward(Guid id, string title);
    }
}
