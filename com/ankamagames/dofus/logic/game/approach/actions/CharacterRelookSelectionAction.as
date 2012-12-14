package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class CharacterRelookSelectionAction extends Object implements Action
    {
        public var characterId:int;
        public var characterHead:int;

        public function CharacterRelookSelectionAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:int) : CharacterRelookSelectionAction
        {
            var _loc_3:* = new CharacterRelookSelectionAction;
            _loc_3.characterId = param1;
            _loc_3.characterHead = param2;
            return _loc_3;
        }// end function

    }
}
