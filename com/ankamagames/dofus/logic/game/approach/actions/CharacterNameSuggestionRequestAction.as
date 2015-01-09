package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class CharacterNameSuggestionRequestAction implements Action 
    {


        public static function create():CharacterNameSuggestionRequestAction
        {
            return (new (CharacterNameSuggestionRequestAction)());
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.actions

