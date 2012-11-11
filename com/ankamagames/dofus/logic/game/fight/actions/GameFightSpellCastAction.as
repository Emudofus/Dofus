package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GameFightSpellCastAction extends Object implements Action
    {
        public var spellId:uint;

        public function GameFightSpellCastAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : GameFightSpellCastAction
        {
            var _loc_2:* = new GameFightSpellCastAction;
            _loc_2.spellId = param1;
            return _loc_2;
        }// end function

    }
}
