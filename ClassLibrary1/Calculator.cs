using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary1
{
    public static class Calculator
    {
        public static int Calculate(int x, int y,char opr)
        {
            int result=0;
            switch(opr)
            {
                case 'A':
                    result = x + y;
                    break;
                case 'M':
                    result = x - y;
                    break;
                default :
                    result = 0;
                    break;
            }
            return result;

        }
    }
}
