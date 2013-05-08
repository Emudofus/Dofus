package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryListEntry;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryEntryJobInfo;
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.dofus.network.enums.CrafterDirectoryParamBitEnum;
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
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.enums.SocialContactCategoryEnum;
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

      private static function createCrafterDirectoryListEntry(entry:JobCrafterDirectoryListEntry) : Object {
         var obj:Object = new Object();
         obj.playerInfo=entry.playerInfo;
         obj.jobInfo=createCrafterDirectoryJobInfo(entry.jobInfo);
         return obj;
      }

      private static function createCrafterDirectoryJobInfo(settings:JobCrafterDirectoryEntryJobInfo) : Object {
         var obj:Object = new Object();
         obj.jobId=settings.jobId;
         obj.jobLevel=settings.jobLevel;
         obj.minSlots=settings.minSlots;
         obj.specialization=Job.getJobById(settings.jobId).specializationOfId<0;
         obj.notFree=!((settings.userDefinedParams&CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE)==0);
         obj.notFreeExceptOnFail=!((settings.userDefinedParams&CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE_EXCEPT_ON_FAIL)==0);
         obj.resourcesRequired=!((settings.userDefinedParams&CrafterDirectoryParamBitEnum.CRAFT_OPTION_RESOURCES_REQUIRED)==0);
         return obj;
      }

      private var _crafterList:Array = null;

      public function get priority() : int {
         return Priority.NORMAL;
      }

      public function pushed() : Boolean {
         return true;
      }

      public function process(msg:Message) : Boolean {
         var jcdlra:JobCrafterDirectoryListRequestAction = null;
         var jcdlrmsg:JobCrafterDirectoryListRequestMessage = null;
         var jcdera:JobCrafterDirectoryEntryRequestAction = null;
         var jcdermsg:JobCrafterDirectoryEntryRequestMessage = null;
         var jcclra:JobCrafterContactLookRequestAction = null;
         var jcdlmsg:JobCrafterDirectoryListMessage = null;
         var jcdrmsg:JobCrafterDirectoryRemoveMessage = null;
         var jcdamsg:JobCrafterDirectoryAddMessage = null;
         var elm:ExchangeLeaveMessage = null;
         var clrbimsg:ContactLookRequestByIdMessage = null;
         var entry:JobCrafterDirectoryListEntry = null;
         var i:uint = 0;
         var jobInfo:Object = null;
         var iCrafter:Object = null;
         switch(true)
         {
            case msg is JobCrafterDirectoryListRequestAction:
               jcdlra=msg as JobCrafterDirectoryListRequestAction;
               jcdlrmsg=new JobCrafterDirectoryListRequestMessage();
               jcdlrmsg.initJobCrafterDirectoryListRequestMessage(jcdlra.jobId);
               ConnectionsHandler.getConnection().send(jcdlrmsg);
               return true;
            case msg is JobCrafterDirectoryEntryRequestAction:
               jcdera=msg as JobCrafterDirectoryEntryRequestAction;
               jcdermsg=new JobCrafterDirectoryEntryRequestMessage();
               jcdermsg.initJobCrafterDirectoryEntryRequestMessage(jcdera.playerId);
               ConnectionsHandler.getConnection().send(jcdermsg);
               return true;
            case msg is JobCrafterContactLookRequestAction:
               jcclra=msg as JobCrafterContactLookRequestAction;
               if(jcclra.crafterId==PlayedCharacterManager.getInstance().infos.id)
               {
                  KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook,jcclra.crafterId,PlayedCharacterManager.getInstance().infos.name,EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook));
               }
               else
               {
                  clrbimsg=new ContactLookRequestByIdMessage();
                  clrbimsg.initContactLookRequestByIdMessage(0,SocialContactCategoryEnum.SOCIAL_CONTACT_CRAFTER,jcclra.crafterId);
                  ConnectionsHandler.getConnection().send(clrbimsg);
               }
               return true;
            case msg is JobCrafterDirectoryListMessage:
               jcdlmsg=msg as JobCrafterDirectoryListMessage;
               this._crafterList=new Array();
               for each (entry in jcdlmsg.listEntries)
               {
                  this._crafterList.push(createCrafterDirectoryListEntry(entry));
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectoryListUpdate,this._crafterList);
               return true;
            case msg is JobCrafterDirectoryRemoveMessage:
               jcdrmsg=msg as JobCrafterDirectoryRemoveMessage;
               i=0;
               while(i<this._crafterList.length)
               {
                  jobInfo=this._crafterList[i];
                  if((jobInfo.jobInfo.jobId==jcdrmsg.jobId)&&(jobInfo.playerInfo.playerId==jcdrmsg.playerId))
                  {
                     this._crafterList.splice(i,1);
                  }
                  else
                  {
                     i++;
                     continue;
                  }
               }
            case msg is JobCrafterDirectoryAddMessage:
               jcdamsg=msg as JobCrafterDirectoryAddMessage;
               for (iCrafter in this._crafterList)
               {
                  if(jcdamsg.listEntry.playerInfo.playerId==this._crafterList[iCrafter].playerInfo.playerId)
                  {
                     this._crafterList.splice(iCrafter,1);
                  }
               }
               this._crafterList.push(createCrafterDirectoryListEntry(jcdamsg.listEntry));
               KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectoryListUpdate,this._crafterList);
               return true;
            case msg is JobCrafterDirectoryEntryMessage:
               return false;
            case msg is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case msg is ExchangeLeaveMessage:
               elm=msg as ExchangeLeaveMessage;
               if(elm.dialogType==DialogTypeEnum.DIALOG_EXCHANGE)
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