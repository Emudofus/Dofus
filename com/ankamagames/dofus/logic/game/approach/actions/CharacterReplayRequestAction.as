package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class CharacterReplayRequestAction extends Object implements Action
    {
        public var characterId:uint;

        public function CharacterReplayRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : CharacterReplayRequestAction
        {
            var _loc_2:* = new CharacterReplayRequestAction;
            _loc_2.characterId = param1;
            return _loc_2;
        }// end function

    }
}
