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

namespace PdpApi.Controllers
{
    public class ResultsDataController : ApiController
    {
        private PDPEntities db = new PDPEntities();

		// GET: api/ResultsData
		//public IQueryable<ResultsData> GetResultsDatas(int MaxRecordCount=1000)
		public IQueryable<get_pdp_result_tbl_Result> GetResultsDatas(int MaxRecordCount = 1000) {
			//return db.ResultsDatas.Take(MaxRecordCount);
			return db.get_pdp_result_tbl(10000, MaxRecordCount);
        }

        // GET: api/ResultsData/5
        [ResponseType(typeof(ResultsData))]
        public IHttpActionResult GetResultsData(short id)
        {
            ResultsData resultsData = db.ResultsDatas.Find(id);
            if (resultsData == null)
            {
                return NotFound();
            }

            return Ok(resultsData);
        }

        // PUT: api/ResultsData/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutResultsData(short id, ResultsData resultsData)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != resultsData.PDP_YEAR)
            {
                return BadRequest();
            }

            db.Entry(resultsData).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ResultsDataExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/ResultsData
        [ResponseType(typeof(ResultsData))]
        public IHttpActionResult PostResultsData(ResultsData resultsData)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.ResultsDatas.Add(resultsData);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (ResultsDataExists(resultsData.PDP_YEAR))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = resultsData.PDP_YEAR }, resultsData);
        }

        // DELETE: api/ResultsData/5
        [ResponseType(typeof(ResultsData))]
        public IHttpActionResult DeleteResultsData(short id)
        {
            ResultsData resultsData = db.ResultsDatas.Find(id);
            if (resultsData == null)
            {
                return NotFound();
            }

            db.ResultsDatas.Remove(resultsData);
            db.SaveChanges();

            return Ok(resultsData);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ResultsDataExists(short id)
        {
            return db.ResultsDatas.Count(e => e.PDP_YEAR == id) > 0;
        }
    }
}