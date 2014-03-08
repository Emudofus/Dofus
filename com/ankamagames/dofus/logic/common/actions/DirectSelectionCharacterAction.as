package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DirectSelectionCharacterAction extends Object implements Action
   {
      
      public function DirectSelectionCharacterAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : DirectSelectionCharacterAction {
         var _loc3_:DirectSelectionCharacterAction = new DirectSelectionCharacterAction();
         _loc3_.serverId = param1;
         _loc3_.characterId = param2;
         return _loc3_;
      }
      
      public var serverId:uint;
      
      public var characterId:uint;
   }
}
