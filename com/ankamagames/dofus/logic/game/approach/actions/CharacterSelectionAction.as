package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterSelectionAction extends Object implements Action
   {
      
      public function CharacterSelectionAction() {
         super();
      }
      
      public static function create(characterId:int, btutoriel:Boolean) : CharacterSelectionAction {
         var a:CharacterSelectionAction = new CharacterSelectionAction();
         a.characterId = characterId;
         a.btutoriel = btutoriel;
         return a;
      }
      
      public var characterId:int;
      
      public var btutoriel:Boolean;
   }
}
