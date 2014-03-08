package com.ankamagames.jerakine.utils.misc
{
   public class Levenshtein extends Object
   {
      
      public function Levenshtein() {
         super();
      }
      
      public static function distance(a:String, b:String) : Number {
         var i:uint = 0;
         var j:uint = 0;
         var cost:* = NaN;
         var d:Array = new Array();
         if(a.length == 0)
         {
            return b.length;
         }
         if(b.length == 0)
         {
            return a.length;
         }
         i = 0;
         while(i <= a.length)
         {
            d[i] = new Array();
            d[i][0] = i;
            i++;
         }
         j = 0;
         while(j <= b.length)
         {
            d[0][j] = j;
            j++;
         }
         i = 1;
         while(i <= a.length)
         {
            j = 1;
            while(j <= b.length)
            {
               if(a.charAt(i - 1) == b.charAt(j - 1))
               {
                  cost = 0;
               }
               else
               {
                  cost = 1;
               }
               d[i][j] = Math.min(d[i - 1][j] + 1,d[i][j - 1] + 1,d[i - 1][j - 1] + cost);
               j++;
            }
            i++;
         }
         return d[a.length][b.length];
      }
      
      public static function suggest(word:String, aPossibility:Array, max:uint=5) : String {
         var res:String = null;
         var value:uint = 0;
         var min:uint = 100000;
         var i:uint = 0;
         while(i < aPossibility.length)
         {
            value = distance(word,aPossibility[i]);
            if((min > value) && (value <= max))
            {
               min = value;
               res = aPossibility[i];
            }
            i++;
         }
         return res;
      }
   }
}
