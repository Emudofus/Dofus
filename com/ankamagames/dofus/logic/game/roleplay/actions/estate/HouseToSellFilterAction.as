package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class HouseToSellFilterAction extends Object implements Action
    {
        public var areaId:int;
        public var atLeastNbRoom:uint;
        public var atLeastNbChest:uint;
        public var skillRequested:uint;
        public var maxPrice:uint;

        public function HouseToSellFilterAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:uint, param3:uint, param4:uint, param5:uint) : HouseToSellFilterAction
        {
            var _loc_6:* = new HouseToSellFilterAction;
            new HouseToSellFilterAction.areaId = param1;
            _loc_6.atLeastNbRoom = param2;
            _loc_6.atLeastNbChest = param3;
            _loc_6.skillRequested = param4;
            _loc_6.maxPrice = param5;
            return _loc_6;
        }// end function

    }
}
