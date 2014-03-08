package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterRelookSelectionAction extends Object implements Action
   {
      
      public function CharacterRelookSelectionAction() {
         super();
      }
      
      public static function create(param1:int, param2:int) : CharacterRelookSelectionAction {
         var _loc3_:CharacterRelookSelectionAction = new CharacterRelookSelectionAction();
         _loc3_.characterId = param1;
         _loc3_.characterHead = param2;
         return _loc3_;
      }
      
      public var characterId:int;
      
      public var characterHead:int;
   }
}
