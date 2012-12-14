package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class CharacterCreationAction extends Object implements Action
    {
        public var name:String;
        public var breed:uint;
        public var head:int;
        public var sex:Boolean;
        public var colors:Array;

        public function CharacterCreationAction()
        {
            return;
        }// end function

        public static function create(param1:String, param2:uint, param3:Boolean, param4:Array, param5:int) : CharacterCreationAction
        {
            var _loc_6:* = new CharacterCreationAction;
            new CharacterCreationAction.name = param1;
            _loc_6.breed = param2;
            _loc_6.sex = param3;
            _loc_6.colors = param4;
            _loc_6.head = param5;
            return _loc_6;
        }// end function

    }
}
