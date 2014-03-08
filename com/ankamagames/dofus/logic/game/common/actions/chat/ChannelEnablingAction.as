package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChannelEnablingAction extends Object implements Action
   {
      
      public function ChannelEnablingAction() {
         super();
      }
      
      public static function create(param1:uint, param2:Boolean=true) : ChannelEnablingAction {
         var _loc3_:ChannelEnablingAction = new ChannelEnablingAction();
         _loc3_.channel = param1;
         _loc3_.enable = param2;
         return _loc3_;
      }
      
      public var channel:uint;
      
      public var enable:Boolean;
   }
}
