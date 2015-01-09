package com.ankamagames.dofus.logic.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class DirectSelectionCharacterAction implements Action 
    {

        public var serverId:uint;
        public var characterId:uint;


        public static function create(serverId:uint, characterId:uint):DirectSelectionCharacterAction
        {
            var a:DirectSelectionCharacterAction = new (DirectSelectionCharacterAction)();
            a.serverId = serverId;
            a.characterId = characterId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.common.actions

