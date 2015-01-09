package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class CharacterRelookSelectionAction implements Action 
    {

        public var characterId:int;
        public var characterHead:int;


        public static function create(characterId:int, characterHead:int):CharacterRelookSelectionAction
        {
            var a:CharacterRelookSelectionAction = new (CharacterRelookSelectionAction)();
            a.characterId = characterId;
            a.characterHead = characterHead;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.actions

