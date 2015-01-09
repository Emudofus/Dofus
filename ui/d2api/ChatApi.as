package d2api
{
    import d2data.BasicChatSentence;
    import d2data.ChatSentenceWithSource;
    import d2data.ChatSentenceWithRecipient;
    import d2data.ItemWrapper;

    public class ChatApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function getChannelsId():Object
        {
            return (null);
        }

        [Untrusted]
        public function getDisallowedChannelsId():Object
        {
            return (null);
        }

        [Untrusted]
        public function getChatColors():Object
        {
            return (null);
        }

        [Untrusted]
        public function getSmileyMood():int
        {
            return (0);
        }

        [Untrusted]
        public function getMessagesByChannel(channel:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getParagraphByChannel(channel:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getHistoryMessagesByChannel(channel:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getMessagesStoredMax():uint
        {
            return (0);
        }

        [Untrusted]
        public function addParagraphToHistory(id:int, p:Object):void
        {
        }

        [Untrusted]
        public function removeLinesFromHistory(value:int, channel:int):void
        {
        }

        [Untrusted]
        public function setMaxMessagesStored(val:int):void
        {
        }

        [Untrusted]
        public function getMaxMessagesStored():int
        {
            return (0);
        }

        [Untrusted]
        public function newBasicChatSentence(id:uint, msg:String, channel:uint=0, time:Number=0, finger:String=""):BasicChatSentence
        {
            return (null);
        }

        [Untrusted]
        public function newChatSentenceWithSource(id:uint, msg:String, channel:uint=0, time:Number=0, finger:String="", senderId:uint=0, senderName:String="", objects:Object=null):ChatSentenceWithSource
        {
            return (null);
        }

        [Untrusted]
        public function newChatSentenceWithRecipient(id:uint, msg:String, channel:uint=0, time:Number=0, finger:String="", senderId:uint=0, senderName:String="", receiverName:String="", receiverId:uint=0, objects:Object=null):ChatSentenceWithRecipient
        {
            return (null);
        }

        [Untrusted]
        public function getTypeOfChatSentence(msg:Object):String
        {
            return (null);
        }

        [Untrusted]
        public function searchChannel(chan:String):int
        {
            return (0);
        }

        [Untrusted]
        public function getHistoryByIndex(name:String, index:uint):String
        {
            return (null);
        }

        [Untrusted]
        public function getRedChannelId():uint
        {
            return (0);
        }

        [Untrusted]
        public function getStaticHyperlink(string:String):String
        {
            return (null);
        }

        [Untrusted]
        public function newChatItem(item:ItemWrapper):String
        {
            return (null);
        }

        [Untrusted]
        public function addAutocompletionNameEntry(name:String, priority:int):void
        {
        }

        [Untrusted]
        public function getAutocompletion(subString:String, count:int):String
        {
            return (null);
        }

        [Untrusted]
        public function getGuildLink(pGuild:*, pText:String=null):String
        {
            return (null);
        }

        [Untrusted]
        public function getAllianceLink(pAlliance:*, pText:String=null, pLinkColor:String=null, pHoverColor:String=null):String
        {
            return (null);
        }

        [Trusted]
        public function changeCssHandler(val:String):void
        {
        }

        [Trusted]
        public function logChat(text:String, cssClass:String):void
        {
        }

        [Trusted]
        public function launchExternalChat():void
        {
        }

        [Untrusted]
        public function clearConsoleChat():void
        {
        }

        [Untrusted]
        public function isExternalChatOpened():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function setExternalChatChannels(pChannels:Object):void
        {
        }

        [Trusted]
        public function addHtmlLink(pText:String, pHref:String):String
        {
            return (null);
        }

        [Trusted]
        public function addSpan(pText:String, pStyle:Object):void
        {
        }

        [Trusted]
        public function escapeChatString(inStr:String):String
        {
            return (null);
        }

        [Trusted]
        public function unEscapeChatString(inStr:String):String
        {
            return (null);
        }


    }
}//package d2api

