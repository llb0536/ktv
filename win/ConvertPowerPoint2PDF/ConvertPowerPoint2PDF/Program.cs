using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

using Microsoft.Office.Interop.PowerPoint;

namespace Microsoft.PPT2pdf
{
    class Program
    {
        public static void ConvertPowerPoint2PDF(string pptInputPath, string pdfOutputPath, string pdfName)
        {
            string pdfExtension = ".pdf";

            // validate patameter
            if (!Directory.Exists(pdfOutputPath)) { Directory.CreateDirectory(pdfOutputPath); }
            if (pdfName.Trim().Length == 0) { pdfName = Path.GetFileNameWithoutExtension(pptInputPath); }
            if (!(Path.GetExtension(pdfName).ToUpper() == pdfExtension.ToUpper())) { pdfName = pdfName + pdfExtension; }

            string paramExportFilePath = Path.Combine(pdfOutputPath, pdfName);

            Microsoft.Office.Interop.PowerPoint.Application ppApp = new Microsoft.Office.Interop.PowerPoint.Application();
            Microsoft.Office.Interop.PowerPoint.Presentation presentation = ppApp.Presentations.Open(pptInputPath, Microsoft.Office.Core.MsoTriState.msoTrue, Microsoft.Office.Core.MsoTriState.msoFalse, Microsoft.Office.Core.MsoTriState.msoFalse);
            presentation.ExportAsFixedFormat(paramExportFilePath,
                PpFixedFormatType.ppFixedFormatTypePDF,
                PpFixedFormatIntent.ppFixedFormatIntentPrint,
                Microsoft.Office.Core.MsoTriState.msoFalse,
                PpPrintHandoutOrder.ppPrintHandoutHorizontalFirst,
                PpPrintOutputType.ppPrintOutputSlides,
                Microsoft.Office.Core.MsoTriState.msoFalse,
                null,
                PpPrintRangeType.ppPrintAll,
                "",
                false,
                false,
                false,
                true,
                true,
                System.Reflection.Missing.Value);
            presentation.Close();
            presentation = null;
            ppApp = null;
            GC.Collect();
        }

        static void Main(string[] args)
        {
            ConvertPowerPoint2PDF(args[0], args[1], args[2]);
        }
    }
}
