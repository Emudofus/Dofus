package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class CharacterCreationAction extends Object implements Action
    {
        public var name:String;
        public var breed:uint;
        public var sex:Boolean;
        public var colors:Array;

        public function CharacterCreationAction()
        {
            return;
        }// end function

        public static function create(param1:String, param2:uint, param3:Boolean, param4:Array) : CharacterCreationAction
        {
            var _loc_5:* = new CharacterCreationAction;
            new CharacterCreationAction.name = param1;
            _loc_5.breed = param2;
            _loc_5.sex = param3;
            _loc_5.colors = param4;
            return _loc_5;
        }// end function

    }
}
