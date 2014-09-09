package com.ankamagames.dofus.misc.stats
{
   import com.ankamagames.jerakine.messages.Frame;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   
   public class StatisticsFrame extends Object implements Frame
   {
      
      public function StatisticsFrame(pFramesStats:Dictionary) {
         super();
         this._framesStats = pFramesStats;
      }
      
      private var _framesStats:Dictionary;
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var stats:IStatsClass = null;
         for each(stats in this._framesStats)
         {
            stats.process(msg);
         }
         return false;
      }
      
      public function get priority() : int {
         return Priority.LOG;
      }
   }
}
