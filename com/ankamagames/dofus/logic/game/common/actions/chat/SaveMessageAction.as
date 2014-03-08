package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SaveMessageAction extends Object implements Action
   {
      
      public function SaveMessageAction() {
         super();
      }
      
      public static function create(param1:String, param2:uint, param3:Number) : SaveMessageAction {
         var _loc4_:SaveMessageAction = new SaveMessageAction();
         _loc4_.content = param1;
         _loc4_.channel = param2;
         _loc4_.timestamp = param3;
         return _loc4_;
      }
      
      public var content:String;
      
      public var channel:uint;
      
      public var timestamp:Number;
   }
}
