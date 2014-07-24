package com.ankamagames.arena.dofusmodule.adapter
{
   import flash.events.EventDispatcher;
   import flash.events.TextEvent;
   import flash.utils.describeType;
   import d2hooks.TextInformation;
   import d2hooks.ChatSendPreInit;
   import d2api.TimeApi;
   import d2api.SystemApi;
   
   public class ChatDofusCommnunicator extends EventDispatcher implements IChatCommunicator
   {
      
      public function ChatDofusCommnunicator(sysApi:SystemApi, timeApi:TimeApi) {
         super();
         this._sysApi = sysApi;
         this._timeApi = timeApi;
         this.init();
      }
      
      public static const EVT_LOG_REQUEST:String = "com.ankamagames.arena.dofusmodule.adapter.ChatDofusCommnunicator.EVT_LOG_REQUEST";
      
      public static const EVT_SEND_MESSAGE_REQUEST:String = "com.ankamagames.arena.dofusmodule.adapter.ChatDofusCommnunicator.EVT_SEND_MESSAGE_REQUEST";
      
      public function destroy() : void {
         this._timeApi = null;
         this._sysApi = null;
      }
      
      public function onChatSendPreInit(content:String, controller:Object) : void {
         if(content.indexOf("[Arena]") != -1)
         {
            controller["cancel"] = true;
            content = content.substr(7);
            dispatchEvent(new TextEvent(EVT_SEND_MESSAGE_REQUEST,false,false,content));
            dispatchEvent(new TextEvent(EVT_LOG_REQUEST,false,false,describeType(controller)));
         }
      }
      
      public function addUserMessage(author:String, message:String) : void {
         this._sysApi.dispatchHook(TextInformation,author + " : " + message,0,this._timeApi.getTimestamp());
      }
      
      public function addInfoMessage(message:String) : void {
         this._sysApi.dispatchHook(TextInformation,message,0,this._timeApi.getTimestamp());
      }
      
      private function init() : void {
         this._sysApi.addHook(ChatSendPreInit,this.onChatSendPreInit);
      }
      
      private var _timeApi:TimeApi;
      
      private var _sysApi:SystemApi;
   }
}
