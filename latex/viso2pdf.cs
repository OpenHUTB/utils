// 测试平台：win10, vs2015
// 构建生成viso2pdf.exe供pdf_crop.bat调用
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Microsoft.Office.Interop.Visio;
using System.Diagnostics;
using System.IO;

namespace pdfcrop
{
    class viso2pdf
    {
        static void Main(string[] args)
        {
            // Console.WriteLine(Directory.GetCurrentDirectory());
            String sourceFileName = args[0];

            String sourceDir = System.Environment.CurrentDirectory;
            String sourcePath = System.IO.Path.Combine(sourceDir, sourceFileName);

            String targetFileName = System.IO.Path.GetFileNameWithoutExtension(sourceFileName) + ".pdf";
            String targetPath = System.IO.Path.Combine(sourceDir, targetFileName);

            viso2pdf.VisioToPDF(sourcePath, targetPath);
            //String sourceDir = "Z:\\data2\\whd\\workspace\\MOT\\SST\\latex\\tip\\imgs\\";
            //String sourcePath = "end-to-end.vsdx";
            //String targetPath = "./end-to-end.pdf";


            // Crop: pdfcrop end-to-end.pdf end-to-end.pdf
            //String strInput = "pdfcrop Z:\\data2\\whd\\workspace\\MOT\\SST\\latex\\tip\\imgs\\end-to-end.pdf Z:\\data2\\whd\\workspace\\MOT\\SST\\latex\\tip\\imgs\\end-to-end.pdf";
            //Program.executeCommand(strInput, 10);
            //Program.RunCmd("pdfcrop.exe", targetPath);

            //Console.WriteLine("hello");
        }


        ///<summary>
        ///executes a system command from inside csharp
        ///</summary>
        ///<param name="cmd">a dos type command like "isql ..."</param>
        ///<param name ="millsecTimeOut">how long to wait on the command</param>
        public static int executeCommand(string cmd, int millsecTimeOut)
        {
            System.Diagnostics.ProcessStartInfo processStartInfo = new System.Diagnostics.ProcessStartInfo("CMD.exe", "/C " + cmd);
            processStartInfo.CreateNoWindow = true;
            processStartInfo.UseShellExecute = false;
            System.Diagnostics.Process process = System.Diagnostics.Process.Start(processStartInfo);
            process.WaitForExit(millsecTimeOut); //wait for 20 sec
            int exitCode = process.ExitCode;
            process.Close();
            return exitCode;
        }


        /// 把Visio文件转换成PDF格式文件
        /// </summary>
        /// <param name="sourcePath">源文件路径</param>
        /// <param name="targetPath">目标文件路径</param>
        /// <returns>true=转换成功</returns>
        public static bool VisioToPDF(string sourcePath, string targetPath)
        {
            bool result;
            Microsoft.Office.Interop.Visio.VisFixedFormatTypes targetType = Microsoft.Office.Interop.Visio.VisFixedFormatTypes.visFixedFormatPDF;
            object missing = Type.Missing;
            Microsoft.Office.Interop.Visio.Application application = null;
            Microsoft.Office.Interop.Visio.Document document = null;
            try
            {
                application = new Microsoft.Office.Interop.Visio.Application();
                application.Visible = false;
                document = application.Documents.Open(sourcePath);
                document.Save();
                document.ExportAsFixedFormat(targetType, targetPath, Microsoft.Office.Interop.Visio.VisDocExIntent.visDocExIntentScreen, Microsoft.Office.Interop.Visio.VisPrintOutRange.visPrintAll);
                result = true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                result = false;
            }
            finally
            {
                if (application != null)
                {
                    application.Quit();
                    application = null;
                }
                GC.Collect();
                GC.WaitForPendingFinalizers();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
            return result;
        }
    }
}
