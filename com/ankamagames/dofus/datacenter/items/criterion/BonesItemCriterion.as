package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class BonesItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function BonesItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get text() : String {
         if((_criterionValue == 0) && (_criterionValueText == "B"))
         {
            return I18n.getUiText("ui.criterion.initialBones");
         }
         return I18n.getUiText("ui.criterion.bones") + " " + _operator.text + " " + _criterionValue.toString();
      }
      
      override public function get isRespected() : Boolean {
         if((_criterionValue == 0) && (_criterionValueText == "B"))
         {
            return PlayedCharacterManager.getInstance().infos.entityLook.bonesId == 1;
         }
         return PlayedCharacterManager.getInstance().infos.entityLook.bonesId == _criterionValue;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:BonesItemCriterion = new BonesItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         return PlayedCharacterManager.getInstance().infos.entityLook.bonesId;
      }
   }
}
