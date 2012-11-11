package com.ankamagames.dofus.logic.game.common.actions.craft
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangePlayerMultiCraftRequestAction extends Object implements Action
    {
        public var exchangeType:int;
        public var target:uint;
        public var skillId:uint;

        public function ExchangePlayerMultiCraftRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:uint, param3:uint) : ExchangePlayerMultiCraftRequestAction
        {
            var _loc_4:* = new ExchangePlayerMultiCraftRequestAction;
            new ExchangePlayerMultiCraftRequestAction.exchangeType = param1;
            _loc_4.target = param2;
            _loc_4.skillId = param3;
            return _loc_4;
        }// end function

    }
}
