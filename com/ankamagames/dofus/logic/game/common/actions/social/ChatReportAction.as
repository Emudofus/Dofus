package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChatReportAction extends Object implements Action
   {
      
      public function ChatReportAction() {
         super();
      }
      
      public static function create(reportedId:uint, reason:uint, name:String, channel:uint, fingerprint:String, message:String, timestamp:Number) : ChatReportAction {
         var a:ChatReportAction = new ChatReportAction();
         a.reportedId = reportedId;
         a.reason = reason;
         a.channel = channel;
         a.timestamp = timestamp;
         a.fingerprint = fingerprint;
         a.message = message;
         a.name = name;
         return a;
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
