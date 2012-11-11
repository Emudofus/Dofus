package com.ankamagames.dofus.logic.game.common.actions.craft
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction extends Object implements Action
    {
        public var allow:Boolean;

        public function ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction
        {
            var _loc_2:* = new ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction;
            _loc_2.allow = param1;
            return _loc_2;
        }// end function

    }
}
