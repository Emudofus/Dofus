package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   
   public class EmoteItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function EmoteItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean {
         var id:* = 0;
         var emoticonList:Array = (Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame).emotes;
         for each (id in emoticonList)
         {
            if(id == _criterionValue)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function get text() : String {
         var readableCriterion:String = I18n.getUiText("ui.tooltip.possessEmote");
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            readableCriterion = I18n.getUiText("ui.tooltip.dontPossessEmote");
         }
         return readableCriterion + " \'" + Emoticon.getEmoticonById(_criterionValue).name + "\'";
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:EmoteItemCriterion = new EmoteItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         var id:* = 0;
         var emoticonList:Array = (Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame).emotes;
         for each (id in emoticonList)
         {
            if(id == _criterionValue)
            {
               return 1;
            }
         }
         return 0;
      }
   }
}
