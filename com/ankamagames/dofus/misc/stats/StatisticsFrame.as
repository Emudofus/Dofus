package com.ankamagames.dofus.misc.stats
{
   import com.ankamagames.jerakine.messages.Frame;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   
   public class StatisticsFrame extends Object implements Frame
   {
      
      public function StatisticsFrame(param1:Dictionary)
      {
         super();
         this._framesStats = param1;
      }
      
      private var _framesStats:Dictionary;
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:IStatsClass = null;
         for each(_loc2_ in this._framesStats)
         {
            _loc2_.process(param1);
         }
         return false;
      }
      
      public function get priority() : int
      {
         return Priority.LOG;
      }
   }
}
