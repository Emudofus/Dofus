package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.datacenter.communication.ChatChannel;
   import com.ankamagames.dofus.internalDatacenter.communication.BasicChatSentence;
   import com.ankamagames.dofus.internalDatacenter.communication.ChatSentenceWithSource;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.communication.ChatSentenceWithRecipient;
   import com.ankamagames.dofus.internalDatacenter.communication.ChatInformationSentence;
   import com.ankamagames.berilia.factories.HyperlinkFactory;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkItemManager;
   import com.ankamagames.dofus.logic.game.common.managers.ChatAutocompleteNameManager;
   import com.ankamagames.berilia.managers.HtmlManager;
   import com.ankamagames.jerakine.logger.ModuleLogger;
   import com.ankamagames.dofus.console.moduleLogger.TypeMessage;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class ChatApi extends Object implements IApi
   {
      
      public function ChatApi() {
         this._log = Log.getLogger(getQualifiedClassName(ChatApi));
         super();
      }
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      private function get chatFrame() : ChatFrame {
         return Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
      }
      
      public function set module(value:UiModule) : void {
         this._module = value;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getChannelsId() : Array {
         var chan:* = undefined;
         var disallowed:Array = this.chatFrame.disallowedChannels;
         var list:Array = new Array();
         for each (chan in ChatChannel.getChannels())
         {
            if(disallowed.indexOf(chan.id) == -1)
            {
               list.push(chan.id);
            }
         }
         return list;
      }
      
      public function getDisallowedChannelsId() : Array {
         return this.chatFrame.disallowedChannels;
      }
      
      public function getChatColors() : Array {
         return this.chatFrame.chatColors;
      }
      
      public function getSmileyMood() : int {
         return this.chatFrame.smileyMood;
      }
      
      public function getMessagesByChannel(channel:uint) : Array {
         var list:Array = this.chatFrame.getMessages();
         return list[channel];
      }
      
      public function getParagraphByChannel(channel:uint) : Array {
         var list:Array = this.chatFrame.getParagraphes();
         return list[channel];
      }
      
      public function getMessagesStoredMax() : uint {
         return this.chatFrame.maxMessagesStored;
      }
      
      public function addParagraphToHistory(id:int, p:Object) : void {
         this.chatFrame.addParagraphToHistory(id,p);
      }
      
      public function removeLinesFromHistory(value:int, channel:int) : void {
         this.chatFrame.removeLinesFromHistory(value,channel);
      }
      
      public function setMaxMessagesStored(val:int) : void {
         this.chatFrame.maxMessagesStored = val;
      }
      
      public function getMaxMessagesStored() : int {
         return this.chatFrame.maxMessagesStored;
      }
      
      public function newBasicChatSentence(id:uint, msg:String, channel:uint=0, time:Number=0, finger:String="") : BasicChatSentence {
         var bsc:BasicChatSentence = new BasicChatSentence(id,msg,msg,channel,time,finger);
         return bsc;
      }
      
      public function newChatSentenceWithSource(id:uint, msg:String, channel:uint=0, time:Number=0, finger:String="", senderId:uint=0, senderName:String="", objects:Vector.<ItemWrapper>=null) : ChatSentenceWithSource {
         var csws:ChatSentenceWithSource = new ChatSentenceWithSource(id,msg,msg,channel,time,finger,senderId,senderName,objects);
         return csws;
      }
      
      public function newChatSentenceWithRecipient(id:uint, msg:String, channel:uint=0, time:Number=0, finger:String="", senderId:uint=0, senderName:String="", receiverName:String="", receiverId:uint=0, objects:Vector.<ItemWrapper>=null) : ChatSentenceWithRecipient {
         var cswr:ChatSentenceWithRecipient = new ChatSentenceWithRecipient(id,msg,msg,channel,time,finger,senderId,senderName,receiverName,receiverId,objects);
         return cswr;
      }
      
      public function getTypeOfChatSentence(msg:Object) : String {
         if(msg is ChatSentenceWithRecipient)
         {
            return "recipientSentence";
         }
         if(msg is ChatSentenceWithSource)
         {
            return "sourceSentence";
         }
         if(msg is ChatInformationSentence)
         {
            return "informationSentence";
         }
         return "basicSentence";
      }
      
      public function searchChannel(chan:String) : int {
         var i:* = undefined;
         var channels:Array = ChatChannel.getChannels();
         for (i in channels)
         {
            if(chan == channels[i].shortcut)
            {
               return channels[i].id;
            }
         }
         return -1;
      }
      
      public function getHistoryByIndex(name:String, index:uint) : String {
         return "";
      }
      
      public function getRedChannelId() : uint {
         return this.chatFrame.getRedId();
      }
      
      public function getStaticHyperlink(string:String) : String {
         return HyperlinkFactory.decode(string,false);
      }
      
      public function newChatItem(item:ItemWrapper) : String {
         return HyperlinkItemManager.newChatItem(item);
      }
      
      public function addAutocompletionNameEntry(name:String, priority:int) : void {
         ChatAutocompleteNameManager.getInstance().addEntry(name,priority);
      }
      
      public function getAutocompletion(subString:String, count:int) : String {
         return ChatAutocompleteNameManager.getInstance().autocomplete(subString,count);
      }
      
      public function changeCssHandler(val:String) : void {
         HtmlManager.changeCssHandler(val);
      }
      
      public function logChat(text:String) : void {
         ModuleLogger.log(text,TypeMessage.LOG_CHAT);
      }
      
      public function addHtmlLink(pText:String, pHref:String) : String {
         return HtmlManager.addLink(pText,pHref);
      }
      
      public function addSpan(pText:String, pStyle:Object) : void {
         HtmlManager.addTag(pText,HtmlManager.SPAN,pStyle);
      }
      
      public function escapeChatString(inStr:String) : String {
         var pattern:RegExp = new RegExp("&","g");
         var inStr:String = inStr.replace(pattern,"&amp;");
         pattern = new RegExp("{","g");
         inStr = inStr.replace(pattern,"&#123;");
         pattern = new RegExp("}","g");
         inStr = inStr.replace(pattern,"&#125;");
         return inStr;
      }
      
      public function unEscapeChatString(inStr:String) : String {
         var inStr:String = inStr.split("&amp;#123;").join("&#123;");
         inStr = inStr.split("&amp;#125;").join("&#125;");
         inStr = inStr.split("&amp;amp;").join("&amp;");
         return inStr;
      }
   }
}
