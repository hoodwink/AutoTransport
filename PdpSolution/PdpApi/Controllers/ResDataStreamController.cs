using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.Http;
//using System.Web.Mvc;

namespace PdpApi.Controllers
{
    public class ResDataStreamController : ApiController {
		// GET: ResDataStream
		public HttpResponseMessage Get() {
			//new System.Text.UTF8Encoding().GetBytes(csv)
			//return File("App_Data/sample_data.csv", "text/csv", "Custom Report.csv");
			MemoryStream stream = new MemoryStream();
			StreamWriter writer = new StreamWriter(stream);
			writer.Write("Hello, World!");
			writer.Flush();
			stream.Position = 0;

			HttpResponseMessage result = new HttpResponseMessage(HttpStatusCode.OK);
			result.Content = new StreamContent(stream);
			result.Content.Headers.ContentType = new MediaTypeHeaderValue("text/csv");
			result.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment") { FileName = "Export.csv" };
			return result;// ResponseMessage(result);
		}
	}
}