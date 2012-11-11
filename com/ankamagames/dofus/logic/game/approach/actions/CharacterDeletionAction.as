package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class CharacterDeletionAction extends Object implements Action
    {
        public var id:int;
        public var answer:String;

        public function CharacterDeletionAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:String) : CharacterDeletionAction
        {
            var _loc_3:* = new CharacterDeletionAction;
            _loc_3.id = param1;
            _loc_3.answer = param2;
            return _loc_3;
        }// end function

    }
}
