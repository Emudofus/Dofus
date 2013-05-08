package com.ankamagames.tiphon.types
{
   import com.ankamagames.jerakine.managers.OptionManager;


   public dynamic class TiphonOptions extends OptionManager
   {
         

      public function TiphonOptions() {
         super("tiphon");
         add("pointsOverhead",2);
         add("aura",true);
         add("alwaysShowAuraOnFront",false);
         add("creaturesMode",20);
      }




   }

}