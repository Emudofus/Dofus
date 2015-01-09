package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PortalUseRequestAction implements Action 
    {

        public var portalId:int;


        public static function create(portalId:int):PortalUseRequestAction
        {
            var action:PortalUseRequestAction = new (PortalUseRequestAction)();
            action.portalId = portalId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt

