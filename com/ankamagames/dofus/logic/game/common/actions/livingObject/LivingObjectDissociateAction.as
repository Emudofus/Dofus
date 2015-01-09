package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class LivingObjectDissociateAction implements Action 
    {

        public var livingUID:uint;
        public var livingPosition:uint;


        public static function create(livingUID:uint, livingPosition:uint):LivingObjectDissociateAction
        {
            var action:LivingObjectDissociateAction = new (LivingObjectDissociateAction)();
            action.livingUID = livingUID;
            action.livingPosition = livingPosition;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.livingObject

