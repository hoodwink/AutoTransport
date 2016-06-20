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

namespace PdpApi.Controllers {
	public class ResultsDataController : ApiController {
		private PDPEntities db = new PDPEntities();

		// GET: api/ResultsData
		//public IQueryable<ResultsData> GetResultsDatas(int MaxRecordCount=1000)
		public CountedDbResult GetResultsDatas(int FirstRow = 0, int PageSize = 1000, string Filter=null, string Sort=null) {
			//return db.ResultsDatas.Take(MaxRecordCount);
			//return db.get_pdp_result_tbl(FirstRow, PageSize);
			CountedDbResult resOut = new CountedDbResult();
			string[] asSort = (Sort ?? string.Empty).Split(',');
			var qry = from rd in db.ResultsDatas
					  join sd in db.SampleDatas
						 on rd.SAMPLE_PK equals sd.SAMPLE_PK
					  join pc in db.PestCode_LU
						 on rd.PESTCODE equals pc.PESTCODE
					  join t in db.Tolerance_LU
						 on new { rd.PDP_YEAR, rd.PESTCODE, rd.COMMOD } equals new { t.PDP_YEAR, t.PESTCODE, t.COMMOD } into gt
					  from subTl in gt.DefaultIfEmpty()
					  select new {
						  PDP_Sample_ID= sd.STATE + sd.YEAR + sd.MONTH + sd.DAY + sd.SITE + sd.COMMOD + rd.LAB + sd.SOURCE_ID,
						  PdpYear = rd.PDP_YEAR,
						  Com = rd.COMMOD,
						  Pest_Code = rd.PESTCODE,
						  Pesticide_Name= pc.DESCRIP,
						  Concen=rd.CONCEN,
						  LOD=rd.LOD,
						  pp_=rd.CONUNIT,
						  Ann=rd.ANNOTATE,
						  Qua=rd.QUANTITATE,
						  Mean=rd.MEAN,
						  Type=sd.COMMTYPE,
						  Variety=sd.VARIETY,
						  Clm=sd.CLAIM,
						  Fac=sd.DISTTYPE,
						  Origin=sd.ORIGIN,
						  Country=(null== sd.Country_LU)? null: sd.Country_LU.DESCRIP,
						  State=sd.ORIGST,
						  Qty =sd.QUANTITY,
						  Tol_ppm= subTl.EPATOL
					  };
			string[] asFilter = (Filter ?? string.Empty).Split(',');
			foreach(string sColFilter in asFilter) {
				if (string.IsNullOrEmpty(sColFilter)) continue;
				string[] asColFilter= sColFilter.Split('#');
				if (asColFilter.Length != 2) throw new ApplicationException("invalid filter specification");
				string sTerm = asColFilter[1];
				switch (asColFilter[0]) {
					case "Com": qry = qry.Where(s => s.Com == sTerm); break;
					case "PdpYear":
						short iYear;
						if (short.TryParse(sTerm, out iYear)) {
							qry = qry.Where(s => s.PdpYear == iYear);
						}
						break;
					case "Pesticide_Name": qry = qry.Where(s => s.Pesticide_Name.Contains(sTerm)); break;
					case "Pest_Code": qry = qry.Where(s => s.Pest_Code == sTerm); break;
					case "Variety": qry = qry.Where(s => null!=s.Variety && s.Variety.Contains(sTerm)); break;
				}
			}

			resOut.RecordCount = qry.Count();
			if (string.IsNullOrWhiteSpace(Sort)) {
				qry = qry.OrderBy(s => s.PdpYear);
			} else {
				foreach(string sColSort in asSort) {
					string[] asColSort=sColSort.Split('#');
					if (asColSort.Length != 2) throw new ApplicationException("invalid sort specification");
					if (string.Compare(asColSort[1], "desc", true)==0) {
						switch (asColSort[0]) {
							case "Com": qry = qry.OrderByDescending(s => s.Com); break;
							case "PdpYear": qry = qry.OrderByDescending(s => s.PdpYear); break;
							case "Pesticide_Name": qry = qry.OrderByDescending(s => s.Pesticide_Name); break;
							case "Pest_Code": qry = qry.OrderByDescending(s => s.Pest_Code); break;
							case "Variety": qry = qry.OrderByDescending(s => s.Variety); break;
						}
					} else {
						switch (asColSort[0]) {
							case "Com": qry = qry.OrderBy(s => s.Com); break;
							case "PdpYear": qry = qry.OrderBy(s => s.PdpYear); break;
							case "Pesticide_Name": qry = qry.OrderBy(s => s.Pesticide_Name); break;
							case "Pest_Code": qry = qry.OrderBy(s => s.Pest_Code); break;
							case "Variety": qry = qry.OrderBy(s => s.Variety); break;
								
						}
					}
				}
			}
			resOut.Data = qry.Skip(FirstRow).Take(PageSize);
			return resOut;
		}

		// GET: api/ResultsData/5
		[ResponseType(typeof(ResultsData))]
		public IHttpActionResult GetResultsData(short id) {
			ResultsData resultsData = db.ResultsDatas.Find(id);
			if (resultsData == null) {
				return NotFound();
			}

			return Ok(resultsData);
		}

		// PUT: api/ResultsData/5
		[ResponseType(typeof(void))]
		public IHttpActionResult PutResultsData(short id, ResultsData resultsData) {
			if (!ModelState.IsValid) {
				return BadRequest(ModelState);
			}

			if (id != resultsData.PDP_YEAR) {
				return BadRequest();
			}

			db.Entry(resultsData).State = EntityState.Modified;

			try {
				db.SaveChanges();
			} catch (DbUpdateConcurrencyException) {
				if (!ResultsDataExists(id)) {
					return NotFound();
				} else {
					throw;
				}
			}

			return StatusCode(HttpStatusCode.NoContent);
		}

		// POST: api/ResultsData
		[ResponseType(typeof(ResultsData))]
		public IHttpActionResult PostResultsData(ResultsData resultsData) {
			if (!ModelState.IsValid) {
				return BadRequest(ModelState);
			}

			db.ResultsDatas.Add(resultsData);

			try {
				db.SaveChanges();
			} catch (DbUpdateException) {
				if (ResultsDataExists(resultsData.PDP_YEAR)) {
					return Conflict();
				} else {
					throw;
				}
			}

			return CreatedAtRoute("DefaultApi", new { id = resultsData.PDP_YEAR }, resultsData);
		}

		// DELETE: api/ResultsData/5
		[ResponseType(typeof(ResultsData))]
		public IHttpActionResult DeleteResultsData(short id) {
			ResultsData resultsData = db.ResultsDatas.Find(id);
			if (resultsData == null) {
				return NotFound();
			}

			db.ResultsDatas.Remove(resultsData);
			db.SaveChanges();

			return Ok(resultsData);
		}

		protected override void Dispose(bool disposing) {
			if (disposing) {
				db.Dispose();
			}
			base.Dispose(disposing);
		}

		private bool ResultsDataExists(short id) {
			return db.ResultsDatas.Count(e => e.PDP_YEAR == id) > 0;
		}
	}
}