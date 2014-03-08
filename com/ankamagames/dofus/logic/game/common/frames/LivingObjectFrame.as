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
      
      public function process(param1:Message) : Boolean {
         var _loc2_:LivingObjectDissociateAction = null;
         var _loc3_:LivingObjectDissociateMessage = null;
         var _loc4_:LivingObjectFeedAction = null;
         var _loc5_:ObjectFeedMessage = null;
         var _loc6_:LivingObjectChangeSkinRequestAction = null;
         var _loc7_:LivingObjectChangeSkinRequestMessage = null;
         var _loc8_:ObjectModifiedMessage = null;
         var _loc9_:ItemWrapper = null;
         var _loc10_:MimicryObjectFeedAndAssociateRequestAction = null;
         var _loc11_:MimicryObjectFeedAndAssociateRequestMessage = null;
         var _loc12_:MimicryObjectPreviewMessage = null;
         var _loc13_:ItemWrapper = null;
         var _loc14_:MimicryObjectErrorMessage = null;
         var _loc15_:MimicryObjectAssociatedMessage = null;
         var _loc16_:ItemWrapper = null;
         var _loc17_:MimicryObjectEraseRequestAction = null;
         var _loc18_:MimicryObjectEraseRequestMessage = null;
         var _loc19_:String = null;
         switch(true)
         {
            case param1 is LivingObjectDissociateAction:
               _loc2_ = param1 as LivingObjectDissociateAction;
               _loc3_ = new LivingObjectDissociateMessage();
               _loc3_.initLivingObjectDissociateMessage(_loc2_.livingUID,_loc2_.livingPosition);
               this.livingObjectUID = _loc2_.livingUID;
               this.action = ACTION_TODISSOCIATE;
               ConnectionsHandler.getConnection().send(_loc3_);
               return true;
            case param1 is LivingObjectFeedAction:
               _loc4_ = param1 as LivingObjectFeedAction;
               _loc5_ = new ObjectFeedMessage();
               _loc5_.initObjectFeedMessage(_loc4_.objectUID,_loc4_.foodUID,_loc4_.foodQuantity);
               this.livingObjectUID = _loc4_.objectUID;
               this.action = ACTION_TOFEED;
               ConnectionsHandler.getConnection().send(_loc5_);
               return true;
            case param1 is LivingObjectChangeSkinRequestAction:
               _loc6_ = param1 as LivingObjectChangeSkinRequestAction;
               _loc7_ = new LivingObjectChangeSkinRequestMessage();
               _loc7_.initLivingObjectChangeSkinRequestMessage(_loc6_.livingUID,_loc6_.livingPosition,_loc6_.skinId);
               this.livingObjectUID = _loc6_.livingUID;
               this.action = ACTION_TOSKIN;
               ConnectionsHandler.getConnection().send(_loc7_);
               return true;
            case param1 is ObjectModifiedMessage:
               _loc8_ = param1 as ObjectModifiedMessage;
               _loc9_ = ItemWrapper.create(_loc8_.object.position,_loc8_.object.objectUID,_loc8_.object.objectGID,_loc8_.object.quantity,_loc8_.object.effects,false);
               if(!_loc9_)
               {
                  return false;
               }
               if(this.livingObjectUID == _loc8_.object.objectUID)
               {
                  _loc9_.update(_loc8_.object.position,_loc8_.object.objectUID,_loc8_.object.objectGID,_loc8_.object.quantity,_loc8_.object.effects);
                  switch(this.action)
                  {
                     case ACTION_TOFEED:
                        KernelEventsManager.getInstance().processCallback(LivingObjectHookList.LivingObjectFeed,_loc9_);
                        break;
                     case ACTION_TODISSOCIATE:
                        KernelEventsManager.getInstance().processCallback(LivingObjectHookList.LivingObjectDissociate,_loc9_);
                        break;
                     case ACTION_TOSKIN:
                     default:
                        KernelEventsManager.getInstance().processCallback(LivingObjectHookList.LivingObjectUpdate,_loc9_);
                  }
               }
               else
               {
                  if(_loc9_.livingObjectId != 0)
                  {
                     KernelEventsManager.getInstance().processCallback(LivingObjectHookList.LivingObjectAssociate,_loc9_);
                  }
               }
               this.livingObjectUID = 0;
               return false;
            case param1 is MimicryObjectFeedAndAssociateRequestAction:
               _loc10_ = param1 as MimicryObjectFeedAndAssociateRequestAction;
               _loc11_ = new MimicryObjectFeedAndAssociateRequestMessage();
               _loc11_.initMimicryObjectFeedAndAssociateRequestMessage(_loc10_.mimicryUID,_loc10_.mimicryPos,_loc10_.foodUID,_loc10_.foodPos,_loc10_.hostUID,_loc10_.hostPos,_loc10_.preview);
               ConnectionsHandler.getConnection().send(_loc11_);
               return true;
            case param1 is MimicryObjectPreviewMessage:
               _loc12_ = param1 as MimicryObjectPreviewMessage;
               _loc13_ = ItemWrapper.create(_loc12_.result.position,_loc12_.result.objectUID,_loc12_.result.objectGID,_loc12_.result.quantity,_loc12_.result.effects,false);
               if(!_loc13_)
               {
                  return false;
               }
               KernelEventsManager.getInstance().processCallback(LivingObjectHookList.MimicryObjectPreview,_loc13_,"");
               return true;
            case param1 is MimicryObjectErrorMessage:
               _loc14_ = param1 as MimicryObjectErrorMessage;
               if(_loc14_.reason == ObjectErrorEnum.MIMICRY_OBJECT_ERROR)
               {
                  switch(_loc14_.errorCode)
                  {
                     case -1:
                        _loc19_ = I18n.getUiText("ui.error.state");
                        break;
                     case -2:
                        _loc19_ = I18n.getUiText("ui.charSel.deletionErrorUnsecureMode");
                        break;
                     case -7:
                        _loc19_ = I18n.getUiText("ui.mimicry.error.foodType");
                        break;
                     case -8:
                        _loc19_ = I18n.getUiText("ui.mimicry.error.foodLevel");
                        break;
                     case -9:
                        _loc19_ = I18n.getUiText("ui.mimicry.error.noValidMimicry");
                        break;
                     case -10:
                        _loc19_ = I18n.getUiText("ui.mimicry.error.noValidHost");
                        break;
                     case -11:
                        _loc19_ = I18n.getUiText("ui.mimicry.error.noValidFood");
                        break;
                     case -16:
                        _loc19_ = I18n.getUiText("ui.mimicry.error.noMimicryAssociated");
                        break;
                     case -17:
                        _loc19_ = I18n.getUiText("ui.mimicry.error.sameSkin");
                        break;
                     case -3:
                     case -4:
                     case -5:
                     case -6:
                     case -12:
                     case -13:
                     case -14:
                     case -15:
                        _loc19_ = I18n.getUiText("ui.popup.impossible_action");
                        break;
                     default:
                        _loc19_ = I18n.getUiText("ui.common.unknownFail");
                  }
                  if(_loc14_.preview)
                  {
                     KernelEventsManager.getInstance().processCallback(LivingObjectHookList.MimicryObjectPreview,null,_loc19_);
                  }
                  else
                  {
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc19_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
               }
               return true;
            case param1 is MimicryObjectAssociatedMessage:
               _loc15_ = param1 as MimicryObjectAssociatedMessage;
               _loc16_ = InventoryManager.getInstance().inventory.getItem(_loc15_.hostUID);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.mimicry.success",[_loc16_.name]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(LivingObjectHookList.MimicryObjectAssociated,_loc16_);
               return true;
            case param1 is MimicryObjectEraseRequestAction:
               _loc17_ = param1 as MimicryObjectEraseRequestAction;
               _loc18_ = new MimicryObjectEraseRequestMessage();
               _loc18_.initMimicryObjectEraseRequestMessage(_loc17_.hostUID,_loc17_.hostPos);
               ConnectionsHandler.getConnection().send(_loc18_);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
