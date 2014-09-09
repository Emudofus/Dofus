package com.ankamagames.dofus.misc.stats
{
   import com.ankamagames.jerakine.messages.Message;
   
   public interface IStatsClass
   {
      
      function process(param1:Message) : void;
      
      function remove() : void;
   }
}
