using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using PdpApi;
using PdpApi.Models;
using PdpApi.BL;

namespace PdpApi.Controllers {
	public class ResultsDataController : ApiController {
		// GET: api/ResultsData
		//public IQueryable<ResultsData> GetResultsDatas(int MaxRecordCount=1000)
		public CountedDbResult GetResultsDatas(int FirstRow = 0, int PageSize = 1000, string Filter=null, string Sort=null) {
			//return db.ResultsDatas.Take(MaxRecordCount);
			//return db.get_pdp_result_tbl(FirstRow, PageSize);
			return new ResDataManager().GetResultsDatas(FirstRow, PageSize, Filter, Sort);
		}
	}
}