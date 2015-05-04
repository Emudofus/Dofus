package com.ankamagames.jerakine.utils.misc
{
   public class CopyObject extends Object
   {
      
      public function CopyObject()
      {
         super();
      }
      
      public static function copyObject(param1:Object, param2:Array = null, param3:Object = null) : Object
      {
         var p:String = null;
         var o:Object = param1;
         var exclude:Array = param2;
         var output:Object = param3;
         if(!output)
         {
            output = new Object();
         }
         var properties:Array = DescribeTypeCache.getVariables(o);
         for each(p in properties)
         {
            if(!((exclude) && (!(exclude.indexOf(p) == -1)) || p == "prototype"))
            {
               try
               {
                  output[p] = o[p];
               }
               catch(e:SecurityError)
               {
                  trace("Error while copying field " + p);
                  continue;
               }
            }
         }
         return output;
      }
   }
}
