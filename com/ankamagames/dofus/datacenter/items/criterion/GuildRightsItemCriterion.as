package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.internalDatacenter.guild.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class GuildRightsItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function GuildRightsItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            if (_criterionValue == 1)
            {
                return I18n.getUiText("ui.criterion.guildRights", [I18n.getUiText("ui.guild.right.leader")]);
            }
            return "";
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new GuildRightsItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            var _loc_1:* = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild;
            if (_loc_1 && _loc_1.isBoss)
            {
                return 1;
            }
            return 0;
        }// end function

    }
}
