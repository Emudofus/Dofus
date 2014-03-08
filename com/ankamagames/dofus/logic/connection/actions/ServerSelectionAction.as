package com.ankamagames.dofus.logic.connection.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ServerSelectionAction extends Object implements Action
   {
      
      public function ServerSelectionAction() {
         super();
      }
      
      public static function create(param1:int) : ServerSelectionAction {
         var _loc2_:ServerSelectionAction = new ServerSelectionAction();
         _loc2_.serverId = param1;
         return _loc2_;
      }
      
      public var serverId:int;
   }
}
