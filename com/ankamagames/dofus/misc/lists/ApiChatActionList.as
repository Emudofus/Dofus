package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChannelEnablingAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.TabsUpdateAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatSmileyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.MoodSmileyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatRefreshChannelAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatRefreshChatAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatTextOutputAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.SaveMessageAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.FightOutputAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.LivingObjectMessageRequestAction;
   
   public class ApiChatActionList extends Object
   {
      
      public function ApiChatActionList() {
         super();
      }
      
      public static const ChannelEnabling:DofusApiAction = new DofusApiAction("ChannelEnabling",ChannelEnablingAction);
      
      public static const TabsUpdate:DofusApiAction = new DofusApiAction("TabsUpdate",TabsUpdateAction);
      
      public static const ChatSmileyRequest:DofusApiAction = new DofusApiAction("ChatSmileyRequest",ChatSmileyRequestAction);
      
      public static const MoodSmileyRequest:DofusApiAction = new DofusApiAction("MoodSmileyRequest",MoodSmileyRequestAction);
      
      public static const ChatRefreshChannel:DofusApiAction = new DofusApiAction("ChatRefreshChannel",ChatRefreshChannelAction);
      
      public static const ChatRefreshChat:DofusApiAction = new DofusApiAction("ChatRefreshChat",ChatRefreshChatAction);
      
      public static const ChatTextOutput:DofusApiAction = new DofusApiAction("ChatTextOutput",ChatTextOutputAction);
      
      public static const SaveMessage:DofusApiAction = new DofusApiAction("SaveMessage",SaveMessageAction);
      
      public static const FightOutput:DofusApiAction = new DofusApiAction("FightOutput",FightOutputAction);
      
      public static const LivingObjectMessageRequest:DofusApiAction = new DofusApiAction("LivingObjectMessageRequest",LivingObjectMessageRequestAction);
   }
}
