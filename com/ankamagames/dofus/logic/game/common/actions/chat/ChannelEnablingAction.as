package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChannelEnablingAction extends Object implements Action
   {
      
      public function ChannelEnablingAction() {
         super();
      }
      
      public static function create(channel:uint, enable:Boolean = true) : ChannelEnablingAction {
         var a:ChannelEnablingAction = new ChannelEnablingAction();
         a.channel = channel;
         a.enable = enable;
         return a;
      }
      
      public var channel:uint;
      
      public var enable:Boolean;
   }
}
