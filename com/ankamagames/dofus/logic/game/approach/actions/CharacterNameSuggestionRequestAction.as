package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class CharacterNameSuggestionRequestAction extends Object implements Action
    {

        public function CharacterNameSuggestionRequestAction()
        {
            return;
        }// end function

        public static function create() : CharacterNameSuggestionRequestAction
        {
            return new CharacterNameSuggestionRequestAction;
        }// end function

    }
}
