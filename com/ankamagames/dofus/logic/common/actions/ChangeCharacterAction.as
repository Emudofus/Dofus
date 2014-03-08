package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChangeCharacterAction extends Object implements Action
   {
      
      public function ChangeCharacterAction() {
         super();
      }
      
      public static function create(serverId:uint) : ChangeCharacterAction {
         var a:ChangeCharacterAction = new ChangeCharacterAction();
         a.serverId = serverId;
         return a;
      }
      
      public var serverId:uint;
   }
}
