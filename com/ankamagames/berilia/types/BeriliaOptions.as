package com.ankamagames.berilia.types
{
   import com.ankamagames.jerakine.managers.OptionManager;
   
   public dynamic class BeriliaOptions extends OptionManager
   {
      
      public function BeriliaOptions() {
         super("berilia");
         add("uiShadows",true);
      }
   }
}
