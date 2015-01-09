package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class CharacterRecolorSelectionAction implements Action 
    {

        public var characterId:int;
        public var characterColors:Array;


        public static function create(characterId:int, characterColors:Array):CharacterRecolorSelectionAction
        {
            var a:CharacterRecolorSelectionAction = new (CharacterRecolorSelectionAction)();
            a.characterId = characterId;
            a.characterColors = characterColors;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.actions

