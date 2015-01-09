package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class CharacterReplayRequestAction implements Action 
    {

        public var characterId:uint;


        public static function create(characterId:uint):CharacterReplayRequestAction
        {
            var a:CharacterReplayRequestAction = new (CharacterReplayRequestAction)();
            a.characterId = characterId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.actions

