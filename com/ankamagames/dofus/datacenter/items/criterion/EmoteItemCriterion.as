package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   
   public class EmoteItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function EmoteItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get isRespected() : Boolean {
         var _loc2_:* = 0;
         var _loc1_:Array = (Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame).emotes;
         for each (_loc2_ in _loc1_)
         {
            if(_loc2_ == _criterionValue)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function get text() : String {
         var _loc1_:String = I18n.getUiText("ui.tooltip.possessEmote");
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            _loc1_ = I18n.getUiText("ui.tooltip.dontPossessEmote");
         }
         return _loc1_ + " \'" + Emoticon.getEmoticonById(_criterionValue).name + "\'";
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:EmoteItemCriterion = new EmoteItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         var _loc2_:* = 0;
         var _loc1_:Array = (Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame).emotes;
         for each (_loc2_ in _loc1_)
         {
            if(_loc2_ == _criterionValue)
            {
               return 1;
            }
         }
         return 0;
      }
   }
}
