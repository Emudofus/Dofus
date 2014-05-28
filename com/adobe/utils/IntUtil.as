package com.adobe.utils
{


   public class IntUtil extends Object
   {
         

      public function IntUtil() {
         super();
      }

      public static function toHex(n:int, bigEndian:Boolean=false) : String {
         var i:* = 0;
         var x:* = 0;
         var s:String = "";
         if(bigEndian)
         {
            i=0;
            while(i<4)
            {
               s=s+(hexChars.charAt(n>>(3-i)*8+4&15)+hexChars.charAt(n>>(3-i)*8&15));
               i++;
            }
         }
         else
         {
            x=0;
            while(x<4)
            {
               s=s+(hexChars.charAt(n>>x*8+4&15)+hexChars.charAt(n>>x*8&15));
               x++;
            }
         }
         return s;
      }

      private static var hexChars:String = "0123456789abcdef";

      public static function ror(x:int, n:int) : uint {
         var nn:int = 32-n;
         return x<<nn|x>>>32-nn;
      }

      public static function rol(x:int, n:int) : int {
         return x<<n|x>>>32-n;
      }


   }

}