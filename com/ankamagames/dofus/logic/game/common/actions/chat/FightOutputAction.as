package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FightOutputAction extends Object implements Action
   {
      
      public function FightOutputAction() {
         super();
      }
      
      public static function create(msg:String, channel:uint=0) : FightOutputAction {
         var a:FightOutputAction = new FightOutputAction();
         a.content = msg;
         a.channel = channel;
         return a;
      }
      
      public var content:String;
      
      public var channel:uint;
   }
}
