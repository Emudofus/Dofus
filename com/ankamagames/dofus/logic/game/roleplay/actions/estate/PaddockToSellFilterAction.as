package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PaddockToSellFilterAction extends Object implements Action
    {
        public var areaId:int;
        public var atLeastNbMount:uint;
        public var atLeastNbMachine:uint;
        public var maxPrice:uint;

        public function PaddockToSellFilterAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:uint, param3:uint, param4:uint) : PaddockToSellFilterAction
        {
            var _loc_5:* = new PaddockToSellFilterAction;
            new PaddockToSellFilterAction.areaId = param1;
            _loc_5.atLeastNbMount = param2;
            _loc_5.atLeastNbMachine = param3;
            _loc_5.maxPrice = param4;
            return _loc_5;
        }// end function

    }
}
