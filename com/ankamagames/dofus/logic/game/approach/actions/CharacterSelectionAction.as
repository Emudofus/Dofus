package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class CharacterSelectionAction extends Object implements Action
    {
        public var characterId:int;
        public var btutoriel:Boolean;

        public function CharacterSelectionAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:Boolean) : CharacterSelectionAction
        {
            var _loc_3:* = new CharacterSelectionAction;
            _loc_3.characterId = param1;
            _loc_3.btutoriel = param2;
            return _loc_3;
        }// end function

    }
}
