using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using ClassLibrary1;

namespace NugetTestMS
{
    [TestClass]
    public class CalculatorTest
    {
        [TestMethod]
        public void TestCalculate()
        {
            bool ret;
            int result=Calculator.Calculate(1,2,'A');
            Assert.AreEqual(result,3);
            
        }
    }
}
