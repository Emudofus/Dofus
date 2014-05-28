package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   
   public class AllianceItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function AllianceItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get text() : String {
         if(_criterionValue == 0)
         {
            return I18n.getUiText("ui.criterion.noAlliance");
         }
         if(_criterionValue == 1)
         {
            return I18n.getUiText("ui.criterion.hasAlliance");
         }
         return I18n.getUiText("ui.criterion.hasValidAlliance");
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:AllianceItemCriterion = new AllianceItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         var alliance:AllianceWrapper = AllianceFrame.getInstance().alliance;
         if(alliance)
         {
            if(alliance.enabled)
            {
               return 2;
            }
            return 1;
         }
         return 0;
      }
   }
}
