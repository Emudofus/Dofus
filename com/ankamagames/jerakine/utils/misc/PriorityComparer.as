package com.ankamagames.jerakine.utils.misc
{
   public final class PriorityComparer extends Object
   {
      
      public function PriorityComparer() {
         super();
      }
      
      public static function compare(param1:Prioritizable, param2:Prioritizable) : Number {
         if(param1.priority > param2.priority)
         {
            return -1;
         }
         if(param1.priority < param2.priority)
         {
            return 1;
         }
         return 0;
      }
   }
}
