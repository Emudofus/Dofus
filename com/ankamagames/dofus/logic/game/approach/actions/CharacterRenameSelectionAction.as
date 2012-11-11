package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class CharacterRenameSelectionAction extends Object implements Action
    {
        public var characterId:int;
        public var characterName:String;

        public function CharacterRenameSelectionAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:String) : CharacterRenameSelectionAction
        {
            var _loc_3:* = new CharacterRenameSelectionAction;
            _loc_3.characterId = param1;
            _loc_3.characterName = param2;
            return _loc_3;
        }// end function

    }
}
