package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class WrapperObjectDissociateRequestAction implements Action 
    {

        public var hostUID:uint;
        public var hostPosition:uint;


        public static function create(hostUID:uint, hostPosition:uint):WrapperObjectDissociateRequestAction
        {
            var action:WrapperObjectDissociateRequestAction = new (WrapperObjectDissociateRequestAction)();
            action.hostUID = hostUID;
            action.hostPosition = hostPosition;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.livingObject

