package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.berilia.types.data.*;

    public class ChatHookList extends Object
    {
        public static const ChatSendPreInit:Hook = new Hook("ChatSendPreInit", false);
        public static const ChatAppendLine:Hook = new Hook("ChatAppendLine", false);
        public static const ChatError:Hook = new Hook("ChatError", false);
        public static const ChatServer:Hook = new Hook("ChatServer", false);
        public static const ChatServerWithObject:Hook = new Hook("ChatServerWithObject", false);
        public static const ChatServerCopy:Hook = new Hook("ChatServerCopy", false);
        public static const ChatServerCopyWithObject:Hook = new Hook("ChatServerCopyWithObject", false);
        public static const ChatSmiley:Hook = new Hook("ChatSmiley", false);
        public static const MoodResult:Hook = new Hook("MoodResult", false);
        public static const NewMessage:Hook = new Hook("NewMessage", false);
        public static const ChatSpeakingItem:Hook = new Hook("ChatSpeakingItem", false);
        public static const TextInformation:Hook = new Hook("TextInformation", false);
        public static const TextActionInformation:Hook = new Hook("TextActionInformation", false);
        public static const ChatFocus:Hook = new Hook("ChatFocus", false);
        public static const ChannelEnablingChange:Hook = new Hook("ChannelEnablingChange", false);
        public static const EnabledChannels:Hook = new Hook("EnabledChannels", false);
        public static const TabNameChange:Hook = new Hook("TabNameChange", false);
        public static const LivingObjectMessage:Hook = new Hook("LivingObjectMessage", false);
        public static const DisplayChatRecipe:Hook = new Hook("DisplayChatRecipe", false);
        public static const Notification:Hook = new Hook("Notification", false);
        public static const PopupWarning:Hook = new Hook("PopupWarning", false);
        public static const ChatWarning:Hook = new Hook("ChatWarning", false);
        public static const ChatLinkRelease:Hook = new Hook("ChatLinkRelease", false);
        public static const AddItemHyperlink:Hook = new Hook("AddItemHyperlink", false);
        public static const ShowObjectLinked:Hook = new Hook("ShowObjectLinked", false);
        public static const ToggleChatLog:Hook = new Hook("ToggleChatLog", true);
        public static const ClearChat:Hook = new Hook("ClearChat", true);
        public static const MailStatus:Hook = new Hook("MailStatus", true);
        public static const NumericWhoIs:Hook = new Hook("NumericWhoIs", true);

        public function ChatHookList()
        {
            return;
        }// end function

    }
}
