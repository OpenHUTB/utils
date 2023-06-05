// 测试平台：win10, vs2015
// 构建生成viso2pdf.exe供pdf_crop.bat调用

// 错误：命名空间“Microsoft”中不存在类型或命名空间名“Office”(是否缺少程序集引用?)
// 右键工程中的引用 -> 添加Microsoft Viso  16.0***（三个）

// todo 新建脚本用于将该脚本编译为可执行文件

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
        // 右键项目(viso2pdf) -->属性 -->调试 --> 命令参数
        // 参数1：当前路径，即相对于工程dong的相对路径，比如：ai\tools\latex\viso2pdf\viso2pdf\bin\Debug
        // 参数输入为：pdfcrop.exe的绝对路径，
        // 默认为：C:\texlive\2016\bin\win32\pdfcrop.exe
        // 调试用的命令参数为：brain\auditory\latex\figs  C:\texlive\2016\bin\win32\pdfcrop.exe
        static void Main(string[] args)
        {
            // Console.WriteLine(Directory.GetCurrentDirectory());

            // 获取当前路径所有以.vsdx为后缀的文件
            String sourceDir;  // viso文件的绝对路径
            if (args[0] == "")
            {
                sourceDir = System.Environment.CurrentDirectory;
            }
            else
            {
                sourceDir = args[0];
            }

            // 获取当前运行路径的上级目录（父目录）
            // System.IO.DirectoryInfo topDir = System.IO.Directory.GetParent(System.Environment.CurrentDirectory);
            //继续获取上级的上级的上级的目录。
            // string projDir = topDir.Parent.Parent.Parent.Parent.Parent.Parent.FullName;
            // 回退到工程dong的目录

            // String sourceFileName = args[0];
            // 遍历当前目录获取所有viso文件（.vsdx）
            // String sourceDir = System.IO.Path.Combine(projDir, sourceRelativeDir);
            // String sourceDir = sourceRelativeDir;
            List <FileInfo> viso_lst = GetFile(sourceDir, ".vsdx");
            foreach (var item in viso_lst)
            {
                var index = viso_lst.IndexOf(item);
                Console.WriteLine($"循环第{index}次  -  取到对应的文件信息：{item}");
                String source_filename = item.Name;  // 得到文件名*.vsdx

                String sourcePath = System.IO.Path.Combine(sourceDir, source_filename);

                String targetFileName = System.IO.Path.GetFileNameWithoutExtension(source_filename) + ".pdf";
                String targetPath = System.IO.Path.Combine(sourceDir, targetFileName);

                viso2pdf.VisioToPDF(sourcePath, targetPath);


                // 执行pdf裁剪：pdfcrop consistency.pdf consistency.pdf
                // pdfcrop D:\\workspace\\dong\\ai\\tools\\latex\\viso2pdf\\viso2pdf\\bin\\ablation.pdf D:\\workspace\\dong\\ai\\tools\\latex\\viso2pdf\\viso2pdf\\bin\\ablation.pdf
                // 内存资源不足，无法处理此命令。
                String[] cmdParts = { "pdfcrop", targetPath, targetPath };
                String cropCmd = string.Join(" ", cmdParts);
                String crop_output = executeCommand(cropCmd, 10);
                Console.WriteLine(crop_output);
            }

        }

        // 获得指定数目个父路径
        public static String getSeveralParent(string path, int N)
        {
            String curDir = path;
            for (int i = 0; i < N; i++)
            {
                // curDir = System.IO.Directory.GetParent(curDir);
            }
            return curDir;
        }


        #region 获取指定文件夹下的指定后缀文件

        /// <summary>
        /// 获取文件夹下的某个后缀的所有文件
        /// </summary>
        /// <param name="path">文件路劲</param>
        /// <param name="ExtName">文件后缀</param>
        /// <returns></returns>
        public static List<FileInfo> GetFile(string path, string ExtName)
        {

            try
            {
                List<FileInfo> lst = new List<FileInfo>();
                string[] dir = Directory.GetDirectories(path);// 文件夹列表
                DirectoryInfo directoryInfo = new DirectoryInfo(path);
                FileInfo[] files = directoryInfo.GetFiles();
                if (files.Length != 0 || dir.Length != 0) // 当前目录文件或文件夹不能为空
                {
                    foreach (FileInfo f in files)
                    {
                        if (ExtName.ToLower().IndexOf(f.Extension.ToLower()) >= 0)
                        {
                            lst.Add(f);
                        }
                    }
                    foreach (string d in dir)
                    {
                        GetFile(d, ExtName);
                    }
                }
                return lst;
            }
            catch (Exception ex)
            {

                throw ex;

            }
        }
        #endregion


        ///<summary>
        ///executes a system command from inside csharp
        ///</summary>
        ///<param name="cmd">a dos type command like "isql ..."</param>
        ///<param name ="millsecTimeOut">how long to wait on the command</param>
        public static string executeCommand(string cmd, int millsecTimeOut)
        {
            System.Diagnostics.Process p = new System.Diagnostics.Process();
            p.StartInfo.FileName = "cmd.exe";
            p.StartInfo.UseShellExecute = false;    //是否使用操作系统shell启动
            p.StartInfo.RedirectStandardInput = true;//接受来自调用程序的输入信息
            p.StartInfo.RedirectStandardOutput = true;//由调用程序获取输出信息
            p.StartInfo.RedirectStandardError = true;//重定向标准错误输出
            p.StartInfo.CreateNoWindow = true;//不显示程序窗口
            p.Start();//启动程序

            //向cmd窗口发送输入信息
            p.StandardInput.WriteLine(cmd + "&exit");

            p.StandardInput.AutoFlush = true;
            //p.StandardInput.WriteLine("exit");
            //向标准输入写入要执行的命令。这里使用&是批处理命令的符号，表示前面一个命令不管是否执行成功都执行后面(exit)命令，如果不执行exit命令，后面调用ReadToEnd()方法会假死
            //同类的符号还有&&和||前者表示必须前一个命令执行成功才会执行后面的命令，后者表示必须前一个命令执行失败才会执行后面的命令

            //获取cmd窗口的输出信息
            string output = p.StandardOutput.ReadToEnd();

            p.WaitForExit();//等待程序执行完退出进程
            p.Close();

            return output;
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

            // 备份文件（解决viso文件在.Save()时发生了改变）
            String back_filename = sourcePath + ".bak";
            File.Copy(sourcePath, back_filename);
            try
            {
                application = new Microsoft.Office.Interop.Visio.Application();
                application.Visible = false;
                document = application.Documents.Open(sourcePath);
                document.Save();  // viso文件发生了改变？
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

                // 恢复备份文件
                File.Delete(sourcePath);
                File.Move(back_filename, sourcePath);
            }
            return result;
        }
    }
}
