package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectDissociateAction;
   import com.ankamagames.dofus.network.messages.game.inventory.items.LivingObjectDissociateMessage;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectFeedAction;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectFeedMessage;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectChangeSkinRequestAction;
   import com.ankamagames.dofus.network.messages.game.inventory.items.LivingObjectChangeSkinRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectModifiedMessage;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.MimicryObjectFeedAndAssociateRequestAction;
   import com.ankamagames.dofus.network.messages.game.inventory.items.MimicryObjectFeedAndAssociateRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.MimicryObjectPreviewMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.MimicryObjectErrorMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.MimicryObjectAssociatedMessage;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.MimicryObjectEraseRequestAction;
   import com.ankamagames.dofus.network.messages.game.inventory.items.MimicryObjectEraseRequestMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.LivingObjectHookList;
   import com.ankamagames.dofus.network.enums.ObjectErrorEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   
   public class LivingObjectFrame extends Object implements Frame
   {
      
      public function LivingObjectFrame() {
         super();
      }
      
      private static const ACTION_TOSKIN:uint = 1;
      
      private static const ACTION_TOFEED:uint = 2;
      
      private static const ACTION_TODISSOCIATE:uint = 3;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LivingObjectFrame));
      
      private var livingObjectUID:uint = 0;
      
      private var action:uint = 0;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var loda:LivingObjectDissociateAction = null;
         var lodmsg:LivingObjectDissociateMessage = null;
         var lofa:LivingObjectFeedAction = null;
         var ofmsg:ObjectFeedMessage = null;
         var locsra:LivingObjectChangeSkinRequestAction = null;
         var locsrmsg:LivingObjectChangeSkinRequestMessage = null;
         var omdmsg:ObjectModifiedMessage = null;
         var itemModified:ItemWrapper = null;
         var mofaara:MimicryObjectFeedAndAssociateRequestAction = null;
         var mofaarmsg:MimicryObjectFeedAndAssociateRequestMessage = null;
         var mopmsg:MimicryObjectPreviewMessage = null;
         var mimicryObject:ItemWrapper = null;
         var moemsg:MimicryObjectErrorMessage = null;
         var moamsg:MimicryObjectAssociatedMessage = null;
         var itwm:ItemWrapper = null;
         var moera:MimicryObjectEraseRequestAction = null;
         var moermsg:MimicryObjectEraseRequestMessage = null;
         var mimicryErrorText:String = null;
         switch(true)
         {
            case msg is LivingObjectDissociateAction:
               loda = msg as LivingObjectDissociateAction;
               lodmsg = new LivingObjectDissociateMessage();
               lodmsg.initLivingObjectDissociateMessage(loda.livingUID,loda.livingPosition);
               this.livingObjectUID = loda.livingUID;
               this.action = ACTION_TODISSOCIATE;
               ConnectionsHandler.getConnection().send(lodmsg);
               return true;
            case msg is LivingObjectFeedAction:
               lofa = msg as LivingObjectFeedAction;
               ofmsg = new ObjectFeedMessage();
               ofmsg.initObjectFeedMessage(lofa.objectUID,lofa.foodUID,lofa.foodQuantity);
               this.livingObjectUID = lofa.objectUID;
               this.action = ACTION_TOFEED;
               ConnectionsHandler.getConnection().send(ofmsg);
               return true;
            case msg is LivingObjectChangeSkinRequestAction:
               locsra = msg as LivingObjectChangeSkinRequestAction;
               locsrmsg = new LivingObjectChangeSkinRequestMessage();
               locsrmsg.initLivingObjectChangeSkinRequestMessage(locsra.livingUID,locsra.livingPosition,locsra.skinId);
               this.livingObjectUID = locsra.livingUID;
               this.action = ACTION_TOSKIN;
               ConnectionsHandler.getConnection().send(locsrmsg);
               return true;
            case msg is ObjectModifiedMessage:
               omdmsg = msg as ObjectModifiedMessage;
               itemModified = ItemWrapper.create(omdmsg.object.position,omdmsg.object.objectUID,omdmsg.object.objectGID,omdmsg.object.quantity,omdmsg.object.effects,false);
               if(!itemModified)
               {
                  return false;
               }
               if(this.livingObjectUID == omdmsg.object.objectUID)
               {
                  itemModified.update(omdmsg.object.position,omdmsg.object.objectUID,omdmsg.object.objectGID,omdmsg.object.quantity,omdmsg.object.effects);
                  switch(this.action)
                  {
                     case ACTION_TOFEED:
                        KernelEventsManager.getInstance().processCallback(LivingObjectHookList.LivingObjectFeed,itemModified);
                        break;
                     case ACTION_TODISSOCIATE:
                        KernelEventsManager.getInstance().processCallback(LivingObjectHookList.LivingObjectDissociate,itemModified);
                        break;
                     case ACTION_TOSKIN:
                        KernelEventsManager.getInstance().processCallback(LivingObjectHookList.LivingObjectUpdate,itemModified);
                        break;
                  }
               }
               else
               {
                  if(itemModified.livingObjectId != 0)
                  {
                     KernelEventsManager.getInstance().processCallback(LivingObjectHookList.LivingObjectAssociate,itemModified);
                  }
               }
               this.livingObjectUID = 0;
               return false;
            case msg is MimicryObjectFeedAndAssociateRequestAction:
               mofaara = msg as MimicryObjectFeedAndAssociateRequestAction;
               mofaarmsg = new MimicryObjectFeedAndAssociateRequestMessage();
               mofaarmsg.initMimicryObjectFeedAndAssociateRequestMessage(mofaara.mimicryUID,mofaara.mimicryPos,mofaara.foodUID,mofaara.foodPos,mofaara.hostUID,mofaara.hostPos,mofaara.preview);
               ConnectionsHandler.getConnection().send(mofaarmsg);
               return true;
            case msg is MimicryObjectPreviewMessage:
               mopmsg = msg as MimicryObjectPreviewMessage;
               mimicryObject = ItemWrapper.create(mopmsg.result.position,mopmsg.result.objectUID,mopmsg.result.objectGID,mopmsg.result.quantity,mopmsg.result.effects,false);
               if(!mimicryObject)
               {
                  return false;
               }
               KernelEventsManager.getInstance().processCallback(LivingObjectHookList.MimicryObjectPreview,mimicryObject,"");
               return true;
            case msg is MimicryObjectErrorMessage:
               moemsg = msg as MimicryObjectErrorMessage;
               if(moemsg.reason == ObjectErrorEnum.MIMICRY_OBJECT_ERROR)
               {
                  switch(moemsg.errorCode)
                  {
                     case -1:
                        mimicryErrorText = I18n.getUiText("ui.error.state");
                        break;
                     case -2:
                        mimicryErrorText = I18n.getUiText("ui.charSel.deletionErrorUnsecureMode");
                        break;
                     case -7:
                        mimicryErrorText = I18n.getUiText("ui.mimicry.error.foodType");
                        break;
                     case -8:
                        mimicryErrorText = I18n.getUiText("ui.mimicry.error.foodLevel");
                        break;
                     case -9:
                        mimicryErrorText = I18n.getUiText("ui.mimicry.error.noValidMimicry");
                        break;
                     case -10:
                        mimicryErrorText = I18n.getUiText("ui.mimicry.error.noValidHost");
                        break;
                     case -11:
                        mimicryErrorText = I18n.getUiText("ui.mimicry.error.noValidFood");
                        break;
                     case -16:
                        mimicryErrorText = I18n.getUiText("ui.mimicry.error.noMimicryAssociated");
                        break;
                     case -17:
                        mimicryErrorText = I18n.getUiText("ui.mimicry.error.sameSkin");
                        break;
                     case -3:
                     case -4:
                     case -5:
                     case -6:
                     case -12:
                     case -13:
                     case -14:
                     case -15:
                        mimicryErrorText = I18n.getUiText("ui.popup.impossible_action");
                        break;
                  }
                  if(moemsg.preview)
                  {
                     KernelEventsManager.getInstance().processCallback(LivingObjectHookList.MimicryObjectPreview,null,mimicryErrorText);
                  }
                  else
                  {
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,mimicryErrorText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
               }
               return true;
            case msg is MimicryObjectAssociatedMessage:
               moamsg = msg as MimicryObjectAssociatedMessage;
               itwm = InventoryManager.getInstance().inventory.getItem(moamsg.hostUID);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.mimicry.success",[itwm.name]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(LivingObjectHookList.MimicryObjectAssociated,itwm);
               return true;
            case msg is MimicryObjectEraseRequestAction:
               moera = msg as MimicryObjectEraseRequestAction;
               moermsg = new MimicryObjectEraseRequestMessage();
               moermsg.initMimicryObjectEraseRequestMessage(moera.hostUID,moera.hostPos);
               ConnectionsHandler.getConnection().send(moermsg);
               return true;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
