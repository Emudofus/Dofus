package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GiftAssignAllRequestAction implements Action 
    {

        public var characterId:uint;


        public static function create(characterId:uint):GiftAssignAllRequestAction
        {
            var a:GiftAssignAllRequestAction = new (GiftAssignAllRequestAction)();
            a.characterId = characterId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.actions

