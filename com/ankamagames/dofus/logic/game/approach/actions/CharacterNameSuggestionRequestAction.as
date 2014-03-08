package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterNameSuggestionRequestAction extends Object implements Action
   {
      
      public function CharacterNameSuggestionRequestAction() {
         super();
      }
      
      public static function create() : CharacterNameSuggestionRequestAction {
         return new CharacterNameSuggestionRequestAction();
      }
   }
}
