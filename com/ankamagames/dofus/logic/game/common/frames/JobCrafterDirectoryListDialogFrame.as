package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryListRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryListRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryEntryRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryEntryRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterContactLookRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryAddMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.social.ContactLookRequestByIdMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryListEntry;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.enums.SocialContactCategoryEnum;
   import com.ankamagames.dofus.internalDatacenter.jobs.CraftsmanWrapper;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryEntryMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class JobCrafterDirectoryListDialogFrame extends Object implements Frame
   {
      
      public function JobCrafterDirectoryListDialogFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(JobsFrame));
      
      private var _crafterList:Array = null;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:JobCrafterDirectoryListRequestAction = null;
         var _loc3_:JobCrafterDirectoryListRequestMessage = null;
         var _loc4_:JobCrafterDirectoryEntryRequestAction = null;
         var _loc5_:JobCrafterDirectoryEntryRequestMessage = null;
         var _loc6_:JobCrafterContactLookRequestAction = null;
         var _loc7_:JobCrafterDirectoryListMessage = null;
         var _loc8_:JobCrafterDirectoryRemoveMessage = null;
         var _loc9_:JobCrafterDirectoryAddMessage = null;
         var _loc10_:ExchangeLeaveMessage = null;
         var _loc11_:ContactLookRequestByIdMessage = null;
         var _loc12_:JobCrafterDirectoryListEntry = null;
         var _loc13_:uint = 0;
         var _loc14_:Object = null;
         var _loc15_:Object = null;
         switch(true)
         {
            case param1 is JobCrafterDirectoryListRequestAction:
               _loc2_ = param1 as JobCrafterDirectoryListRequestAction;
               _loc3_ = new JobCrafterDirectoryListRequestMessage();
               _loc3_.initJobCrafterDirectoryListRequestMessage(_loc2_.jobId);
               ConnectionsHandler.getConnection().send(_loc3_);
               return true;
            case param1 is JobCrafterDirectoryEntryRequestAction:
               _loc4_ = param1 as JobCrafterDirectoryEntryRequestAction;
               _loc5_ = new JobCrafterDirectoryEntryRequestMessage();
               _loc5_.initJobCrafterDirectoryEntryRequestMessage(_loc4_.playerId);
               ConnectionsHandler.getConnection().send(_loc5_);
               return true;
            case param1 is JobCrafterContactLookRequestAction:
               _loc6_ = param1 as JobCrafterContactLookRequestAction;
               if(_loc6_.crafterId == PlayedCharacterManager.getInstance().id)
               {
                  KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook,_loc6_.crafterId,PlayedCharacterManager.getInstance().infos.name,EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook));
               }
               else
               {
                  _loc11_ = new ContactLookRequestByIdMessage();
                  _loc11_.initContactLookRequestByIdMessage(0,SocialContactCategoryEnum.SOCIAL_CONTACT_CRAFTER,_loc6_.crafterId);
                  ConnectionsHandler.getConnection().send(_loc11_);
               }
               return true;
            case param1 is JobCrafterDirectoryListMessage:
               _loc7_ = param1 as JobCrafterDirectoryListMessage;
               this._crafterList = new Array();
               for each (_loc12_ in _loc7_.listEntries)
               {
                  this._crafterList.push(CraftsmanWrapper.create(_loc12_));
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectoryListUpdate,this._crafterList);
               return true;
            case param1 is JobCrafterDirectoryRemoveMessage:
               _loc8_ = param1 as JobCrafterDirectoryRemoveMessage;
               _loc13_ = 0;
               while(_loc13_ < this._crafterList.length)
               {
                  _loc14_ = this._crafterList[_loc13_];
                  if(_loc14_.jobId == _loc8_.jobId && _loc14_.playerId == _loc8_.playerId)
                  {
                     this._crafterList.splice(_loc13_,1);
                     break;
                  }
                  _loc13_++;
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectoryListUpdate,this._crafterList);
               return true;
            case param1 is JobCrafterDirectoryAddMessage:
               _loc9_ = param1 as JobCrafterDirectoryAddMessage;
               for (_loc15_ in this._crafterList)
               {
                  if(_loc9_.listEntry.playerInfo.playerId == this._crafterList[_loc15_].playerId)
                  {
                     this._crafterList.splice(_loc15_,1);
                  }
               }
               this._crafterList.push(CraftsmanWrapper.create(_loc9_.listEntry));
               KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectoryListUpdate,this._crafterList);
               return true;
            case param1 is JobCrafterDirectoryEntryMessage:
               return false;
            case param1 is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case param1 is ExchangeLeaveMessage:
               _loc10_ = param1 as ExchangeLeaveMessage;
               if(_loc10_.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
               {
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
         return true;
      }
   }
}
