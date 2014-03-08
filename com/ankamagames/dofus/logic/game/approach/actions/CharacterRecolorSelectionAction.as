package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterRecolorSelectionAction extends Object implements Action
   {
      
      public function CharacterRecolorSelectionAction() {
         super();
      }
      
      public static function create(param1:int, param2:Array) : CharacterRecolorSelectionAction {
         var _loc3_:CharacterRecolorSelectionAction = new CharacterRecolorSelectionAction();
         _loc3_.characterId = param1;
         _loc3_.characterColors = param2;
         return _loc3_;
      }
      
      public var characterId:int;
      
      public var characterColors:Array;
   }
}
