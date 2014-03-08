package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChatReportAction extends Object implements Action
   {
      
      public function ChatReportAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:String, param4:uint, param5:String, param6:String, param7:Number) : ChatReportAction {
         var _loc8_:ChatReportAction = new ChatReportAction();
         _loc8_.reportedId = param1;
         _loc8_.reason = param2;
         _loc8_.channel = param4;
         _loc8_.timestamp = param7;
         _loc8_.fingerprint = param5;
         _loc8_.message = param6;
         _loc8_.name = param3;
         return _loc8_;
      }
      
      public var reportedId:uint;
      
      public var reason:uint;
      
      public var channel:uint;
      
      public var timestamp:Number;
      
      public var fingerprint:String;
      
      public var message:String;
      
      public var name:String;
   }
}
