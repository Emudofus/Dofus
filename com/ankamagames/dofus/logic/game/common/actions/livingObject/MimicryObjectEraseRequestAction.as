package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class MimicryObjectEraseRequestAction implements Action 
    {

        public var hostUID:uint;
        public var hostPos:uint;


        public static function create(hostUID:uint, hostPos:uint):MimicryObjectEraseRequestAction
        {
            var action:MimicryObjectEraseRequestAction = new (MimicryObjectEraseRequestAction)();
            action.hostUID = hostUID;
            action.hostPos = hostPos;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.livingObject

