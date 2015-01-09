package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class LivingObjectChangeSkinRequestAction implements Action 
    {

        public var livingUID:uint;
        public var livingPosition:uint;
        public var skinId:uint;


        public static function create(livingUID:uint, livingPosition:uint, skinId:uint):LivingObjectChangeSkinRequestAction
        {
            var action:LivingObjectChangeSkinRequestAction = new (LivingObjectChangeSkinRequestAction)();
            action.livingUID = livingUID;
            action.livingPosition = livingPosition;
            action.skinId = skinId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.livingObject

