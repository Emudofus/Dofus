package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class MimicryObjectFeedAndAssociateRequestAction implements Action 
    {

        public var mimicryUID:uint;
        public var symbiotePos:uint;
        public var foodUID:uint;
        public var foodPos:uint;
        public var hostUID:uint;
        public var hostPos:uint;
        public var preview:Boolean;


        public static function create(mimicryUID:uint, symbiotePos:uint, foodUID:uint, foodPos:uint, hostUID:uint, hostPos:uint, preview:Boolean):MimicryObjectFeedAndAssociateRequestAction
        {
            var action:MimicryObjectFeedAndAssociateRequestAction = new (MimicryObjectFeedAndAssociateRequestAction)();
            action.mimicryUID = mimicryUID;
            action.symbiotePos = symbiotePos;
            action.foodUID = foodUID;
            action.foodPos = foodPos;
            action.hostUID = hostUID;
            action.hostPos = hostPos;
            action.preview = preview;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.livingObject

