package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChangeCharacterAction extends Object implements Action
   {
      
      public function ChangeCharacterAction() {
         super();
      }
      
      public static function create(param1:uint) : ChangeCharacterAction {
         var _loc2_:ChangeCharacterAction = new ChangeCharacterAction();
         _loc2_.serverId = param1;
         return _loc2_;
      }
      
      public var serverId:uint;
   }
}
