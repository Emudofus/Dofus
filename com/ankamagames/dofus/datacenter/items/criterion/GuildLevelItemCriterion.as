package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.internalDatacenter.guild.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class GuildLevelItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function GuildLevelItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = _criterionValue.toString();
            var _loc_2:* = I18n.getUiText("ui.guild.guildLevel");
            return _loc_2 + " " + _operator.text + " " + _loc_1;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new GuildLevelItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            var _loc_1:* = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild;
            if (_loc_1)
            {
                return _loc_1.level;
            }
            return 0;
        }// end function

    }
}
