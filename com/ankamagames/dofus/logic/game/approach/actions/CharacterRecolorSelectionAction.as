package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterRecolorSelectionAction extends Object implements Action
   {
      
      public function CharacterRecolorSelectionAction() {
         super();
      }
      
      public static function create(characterId:int, characterColors:Array) : CharacterRecolorSelectionAction {
         var a:CharacterRecolorSelectionAction = new CharacterRecolorSelectionAction();
         a.characterId = characterId;
         a.characterColors = characterColors;
         return a;
      }
      
      public var characterId:int;
      
      public var characterColors:Array;
   }
}
