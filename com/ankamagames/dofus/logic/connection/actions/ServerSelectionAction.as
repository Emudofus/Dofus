package com.ankamagames.dofus.logic.connection.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ServerSelectionAction extends Object implements Action
   {
      
      public function ServerSelectionAction() {
         super();
      }
      
      public static function create(serverId:int) : ServerSelectionAction {
         var a:ServerSelectionAction = new ServerSelectionAction();
         a.serverId = serverId;
         return a;
      }
      
      public var serverId:int;
   }
}
