package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class CharacterRecolorSelectionAction extends Object implements Action
    {
        public var characterId:int;
        public var characterColors:Array;

        public function CharacterRecolorSelectionAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:Array) : CharacterRecolorSelectionAction
        {
            var _loc_3:* = new CharacterRecolorSelectionAction;
            _loc_3.characterId = param1;
            _loc_3.characterColors = param2;
            return _loc_3;
        }// end function

    }
}
