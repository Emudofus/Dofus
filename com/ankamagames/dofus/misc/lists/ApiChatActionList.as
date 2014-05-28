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
      
      public static const ChannelEnabling:DofusApiAction;
      
      public static const TabsUpdate:DofusApiAction;
      
      public static const ChatSmileyRequest:DofusApiAction;
      
      public static const MoodSmileyRequest:DofusApiAction;
      
      public static const ChatRefreshChannel:DofusApiAction;
      
      public static const ChatRefreshChat:DofusApiAction;
      
      public static const ChatTextOutput:DofusApiAction;
      
      public static const SaveMessage:DofusApiAction;
      
      public static const FightOutput:DofusApiAction;
      
      public static const LivingObjectMessageRequest:DofusApiAction;
   }
}
