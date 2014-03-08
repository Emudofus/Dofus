package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   
   public class HyperlinkShowCellManager extends Object
   {
      
      public function HyperlinkShowCellManager() {
         super();
      }
      
      public static function showCell(... rest) : void {
         var _loc2_:SerialSequencer = null;
         try
         {
            _loc2_ = new SerialSequencer();
            _loc2_.addStep(new AddGfxEntityStep(645,rest[int(Math.random() * rest.length)]));
            _loc2_.start();
         }
         catch(e:Error)
         {
         }
      }
   }
}
