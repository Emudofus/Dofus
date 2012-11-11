package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.internalDatacenter.guild.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class GuildItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function GuildItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            if (_criterionValue == 0)
            {
                return I18n.getUiText("ui.criterion.noguild");
            }
            if (_criterionValue == 1)
            {
                return I18n.getUiText("ui.criterion.hasGuild");
            }
            return I18n.getUiText("ui.criterion.hasValidGuild");
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new GuildItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            var _loc_1:* = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild;
            if (_loc_1)
            {
                if (_loc_1.enabled)
                {
                    return 2;
                }
                return 1;
            }
            return 0;
        }// end function

    }
}
