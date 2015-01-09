package com.ankamagames.dofus.logic.game.common.actions.craft
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction implements Action 
    {

        public var allow:Boolean;


        public static function create(pAllow:Boolean):ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction
        {
            var action:ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction = new (ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction)();
            action.allow = pAllow;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.craft

