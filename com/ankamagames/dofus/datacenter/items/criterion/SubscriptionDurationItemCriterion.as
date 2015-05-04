package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   
   public class SubscriptionDurationItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function SubscriptionDurationItemCriterion(param1:String)
      {
         super(param1);
      }
      
      override public function get text() : String
      {
         var _loc1_:String = PatternDecoder.combine(I18n.getUiText("ui.social.daysSinceLastConnection",[_criterionValue]),"n",_criterionValue <= 1);
         var _loc2_:String = I18n.getUiText("ui.veteran.totalSubscriptionDuration");
         return _loc2_ + " " + _operator.text + " " + _loc1_;
      }
      
      override public function clone() : IItemCriterion
      {
         var _loc1_:SubscriptionDurationItemCriterion = new SubscriptionDurationItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int
      {
         return Math.floor(PlayerManager.getInstance().subscriptionDurationElapsed / (24 * 60 * 60));
      }
   }
}
