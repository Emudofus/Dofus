package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GiftAssignRequestAction implements Action 
    {

        public var giftId:uint;
        public var characterId:uint;


        public static function create(giftId:uint, characterId:uint):GiftAssignRequestAction
        {
            var action:GiftAssignRequestAction = new (GiftAssignRequestAction)();
            action.giftId = giftId;
            action.characterId = characterId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.actions

