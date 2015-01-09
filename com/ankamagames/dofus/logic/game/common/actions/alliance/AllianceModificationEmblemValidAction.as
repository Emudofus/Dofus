package com.ankamagames.dofus.logic.game.common.actions.alliance
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AllianceModificationEmblemValidAction implements Action 
    {

        public var upEmblemId:uint;
        public var upColorEmblem:uint;
        public var backEmblemId:uint;
        public var backColorEmblem:uint;


        public static function create(pUpEmblemId:uint, pUpColorEmblem:uint, pBackEmblemId:uint, pBackColorEmblem:uint):AllianceModificationEmblemValidAction
        {
            var action:AllianceModificationEmblemValidAction = new (AllianceModificationEmblemValidAction)();
            action.upEmblemId = pUpEmblemId;
            action.upColorEmblem = pUpColorEmblem;
            action.backEmblemId = pBackEmblemId;
            action.backColorEmblem = pBackColorEmblem;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.alliance

