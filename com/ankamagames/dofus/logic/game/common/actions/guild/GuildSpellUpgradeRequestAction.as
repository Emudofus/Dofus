package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GuildSpellUpgradeRequestAction extends Object implements Action
    {
        public var spellId:uint;

        public function GuildSpellUpgradeRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : GuildSpellUpgradeRequestAction
        {
            var _loc_2:* = new GuildSpellUpgradeRequestAction;
            _loc_2.spellId = param1;
            return _loc_2;
        }// end function

    }
}
