package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DirectSelectionCharacterAction extends Object implements Action
   {
      
      public function DirectSelectionCharacterAction() {
         super();
      }
      
      public static function create(serverId:uint, characterId:uint) : DirectSelectionCharacterAction {
         var a:DirectSelectionCharacterAction = new DirectSelectionCharacterAction();
         a.serverId = serverId;
         a.characterId = characterId;
         return a;
      }
      
      public var serverId:uint;
      
      public var characterId:uint;
   }
}
