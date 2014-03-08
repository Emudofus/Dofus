package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class KamaItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function KamaItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         var _loc1_:String = I18n.getUiText("ui.common.kamas");
         return _loc1_ + " " + _operator.text + " " + _criterionValue;
      }
      
      override public function get isRespected() : Boolean {
         return _operator.compare(uint(this.getCriterion()),_criterionValue);
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:KamaItemCriterion = new KamaItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         return PlayedCharacterManager.getInstance().characteristics.kamas;
      }
   }
}
