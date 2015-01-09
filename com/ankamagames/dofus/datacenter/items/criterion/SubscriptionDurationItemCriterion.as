package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;

    public class SubscriptionDurationItemCriterion extends ItemCriterion implements IDataCenter 
    {

        public function SubscriptionDurationItemCriterion(pCriterion:String)
        {
            super(pCriterion);
        }

        override public function get text():String
        {
            var readableCriterionValue:String = PatternDecoder.combine(I18n.getUiText("ui.social.daysSinceLastConnection", [_criterionValue]), "n", (_criterionValue <= 1));
            var readableCriterionRef:String = I18n.getUiText("ui.veteran.totalSubscriptionDuration");
            return (((((readableCriterionRef + " ") + _operator.text) + " ") + readableCriterionValue));
        }

        override public function clone():IItemCriterion
        {
            var clonedCriterion:SubscriptionDurationItemCriterion = new SubscriptionDurationItemCriterion(this.basicText);
            return (clonedCriterion);
        }

        override protected function getCriterion():int
        {
            return (Math.floor((PlayerManager.getInstance().subscriptionDurationElapsed / ((24 * 60) * 60))));
        }


    }
}//package com.ankamagames.dofus.datacenter.items.criterion

