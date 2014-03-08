package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterRenameSelectionAction extends Object implements Action
   {
      
      public function CharacterRenameSelectionAction() {
         super();
      }
      
      public static function create(param1:int, param2:String) : CharacterRenameSelectionAction {
         var _loc3_:CharacterRenameSelectionAction = new CharacterRenameSelectionAction();
         _loc3_.characterId = param1;
         _loc3_.characterName = param2;
         return _loc3_;
      }
      
      public var characterId:int;
      
      public var characterName:String;
   }
}
