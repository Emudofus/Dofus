package com.ankamagames.dofus.uiApi
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.console.moduleLogger.*;
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.dofus.internalDatacenter.communication.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ChatApi extends Object implements IApi
    {
        protected var _log:Logger;
        private var _module:UiModule;

        public function ChatApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(ChatApi));
            return;
        }// end function

        private function get chatFrame() : ChatFrame
        {
            return Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getChannelsId() : Array
        {
            var _loc_3:* = undefined;
            var _loc_1:* = this.chatFrame.disallowedChannels;
            var _loc_2:* = new Array();
            for each (_loc_3 in ChatChannel.getChannels())
            {
                
                if (_loc_1.indexOf(_loc_3.id) == -1)
                {
                    _loc_2.push(_loc_3.id);
                }
            }
            return _loc_2;
        }// end function

        public function getDisallowedChannelsId() : Array
        {
            return this.chatFrame.disallowedChannels;
        }// end function

        public function getChatColors() : Array
        {
            return this.chatFrame.chatColors;
        }// end function

        public function getSmileyMood() : int
        {
            return this.chatFrame.smileyMood;
        }// end function

        public function getMessagesByChannel(param1:uint) : Array
        {
            var _loc_2:* = this.chatFrame.getMessages();
            return _loc_2[param1];
        }// end function

        public function getParagraphByChannel(param1:uint) : Array
        {
            var _loc_2:* = this.chatFrame.getParagraphes();
            return _loc_2[param1];
        }// end function

        public function getMessagesStoredMax() : uint
        {
            return this.chatFrame.maxMessagesStored;
        }// end function

        public function addParagraphToHistory(param1:int, param2:Object) : void
        {
            this.chatFrame.addParagraphToHistory(param1, param2);
            return;
        }// end function

        public function removeLinesFromHistory(param1:int, param2:int) : void
        {
            this.chatFrame.removeLinesFromHistory(param1, param2);
            return;
        }// end function

        public function setMaxMessagesStored(param1:int) : void
        {
            this.chatFrame.maxMessagesStored = param1;
            return;
        }// end function

        public function getMaxMessagesStored() : int
        {
            return this.chatFrame.maxMessagesStored;
        }// end function

        public function newBasicChatSentence(param1:uint, param2:String, param3:uint = 0, param4:Number = 0, param5:String = "") : BasicChatSentence
        {
            var _loc_6:* = new BasicChatSentence(param1, param2, param2, param3, param4, param5);
            return new BasicChatSentence(param1, param2, param2, param3, param4, param5);
        }// end function

        public function newChatSentenceWithSource(param1:uint, param2:String, param3:uint = 0, param4:Number = 0, param5:String = "", param6:uint = 0, param7:String = "", param8:Vector.<ItemWrapper> = null) : ChatSentenceWithSource
        {
            var _loc_9:* = new ChatSentenceWithSource(param1, param2, param2, param3, param4, param5, param6, param7, param8);
            return new ChatSentenceWithSource(param1, param2, param2, param3, param4, param5, param6, param7, param8);
        }// end function

        public function newChatSentenceWithRecipient(param1:uint, param2:String, param3:uint = 0, param4:Number = 0, param5:String = "", param6:uint = 0, param7:String = "", param8:String = "", param9:uint = 0, param10:Vector.<ItemWrapper> = null) : ChatSentenceWithRecipient
        {
            var _loc_11:* = new ChatSentenceWithRecipient(param1, param2, param2, param3, param4, param5, param6, param7, param8, param9, param10);
            return new ChatSentenceWithRecipient(param1, param2, param2, param3, param4, param5, param6, param7, param8, param9, param10);
        }// end function

        public function getTypeOfChatSentence(param1:Object) : String
        {
            if (param1 is ChatSentenceWithRecipient)
            {
                return "recipientSentence";
            }
            if (param1 is ChatSentenceWithSource)
            {
                return "sourceSentence";
            }
            if (param1 is ChatInformationSentence)
            {
                return "informationSentence";
            }
            return "basicSentence";
        }// end function

        public function searchChannel(param1:String) : int
        {
            var _loc_3:* = undefined;
            var _loc_2:* = ChatChannel.getChannels();
            for (_loc_3 in _loc_2)
            {
                
                if (param1 == _loc_2[_loc_3].shortcut)
                {
                    return _loc_2[_loc_3].id;
                }
            }
            return -1;
        }// end function

        public function getHistoryByIndex(param1:String, param2:uint) : String
        {
            return "";
        }// end function

        public function getRedChannelId() : uint
        {
            return this.chatFrame.getRedId();
        }// end function

        public function getStaticHyperlink(param1:String) : String
        {
            return HyperlinkFactory.decode(param1, false);
        }// end function

        public function newChatItem(param1:ItemWrapper) : String
        {
            return HyperlinkItemManager.newChatItem(param1);
        }// end function

        public function addAutocompletionNameEntry(param1:String, param2:int) : void
        {
            ChatAutocompleteNameManager.getInstance().addEntry(param1, param2);
            return;
        }// end function

        public function getAutocompletion(param1:String, param2:int) : String
        {
            return ChatAutocompleteNameManager.getInstance().autocomplete(param1, param2);
        }// end function

        public function changeCssHandler(param1:String) : void
        {
            HtmlManager.changeCssHandler(param1);
            return;
        }// end function

        public function logChat(param1:String) : void
        {
            ModuleLogger.log(param1, TypeMessage.LOG_CHAT);
            return;
        }// end function

        public function addHtmlLink(param1:String, param2:String) : String
        {
            return HtmlManager.addLink(param1, param2);
        }// end function

        public function addSpan(param1:String, param2:Object) : void
        {
            HtmlManager.addTag(param1, HtmlManager.SPAN, param2);
            return;
        }// end function

        public function escapeChatString(param1:String) : String
        {
            var _loc_2:* = /&""&/g;
            param1 = param1.replace(_loc_2, "&amp;");
            _loc_2 = /{""{/g;
            param1 = param1.replace(_loc_2, "&#123;");
            _loc_2 = /}""}/g;
            param1 = param1.replace(_loc_2, "&#125;");
            return param1;
        }// end function

        public function unEscapeChatString(param1:String) : String
        {
            param1 = param1.split("&amp;#123;").join("&#123;");
            param1 = param1.split("&amp;#125;").join("&#125;");
            param1 = param1.split("&amp;amp;").join("&amp;");
            return param1;
        }// end function

    }
}
