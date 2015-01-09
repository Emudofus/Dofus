package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
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
    import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryEntryMessage;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
    import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
    import com.ankamagames.dofus.network.enums.DialogTypeEnum;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.misc.lists.HookList;

    public class JobCrafterDirectoryListDialogFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(JobsFrame));

        private var _crafterList:Array = null;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:JobCrafterDirectoryListRequestAction;
            var _local_3:JobCrafterDirectoryListRequestMessage;
            var _local_4:JobCrafterDirectoryEntryRequestAction;
            var _local_5:JobCrafterDirectoryEntryRequestMessage;
            var _local_6:JobCrafterContactLookRequestAction;
            var _local_7:JobCrafterDirectoryListMessage;
            var _local_8:JobCrafterDirectoryRemoveMessage;
            var _local_9:JobCrafterDirectoryAddMessage;
            var _local_10:ExchangeLeaveMessage;
            var _local_11:ContactLookRequestByIdMessage;
            var entry:JobCrafterDirectoryListEntry;
            var i:uint;
            var jobInfo:Object;
            var iCrafter:Object;
            switch (true)
            {
                case (msg is JobCrafterDirectoryListRequestAction):
                    _local_2 = (msg as JobCrafterDirectoryListRequestAction);
                    _local_3 = new JobCrafterDirectoryListRequestMessage();
                    _local_3.initJobCrafterDirectoryListRequestMessage(_local_2.jobId);
                    ConnectionsHandler.getConnection().send(_local_3);
                    return (true);
                case (msg is JobCrafterDirectoryEntryRequestAction):
                    _local_4 = (msg as JobCrafterDirectoryEntryRequestAction);
                    _local_5 = new JobCrafterDirectoryEntryRequestMessage();
                    _local_5.initJobCrafterDirectoryEntryRequestMessage(_local_4.playerId);
                    ConnectionsHandler.getConnection().send(_local_5);
                    return (true);
                case (msg is JobCrafterContactLookRequestAction):
                    _local_6 = (msg as JobCrafterContactLookRequestAction);
                    if (_local_6.crafterId == PlayedCharacterManager.getInstance().id)
                    {
                        KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook, _local_6.crafterId, PlayedCharacterManager.getInstance().infos.name, EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook));
                    }
                    else
                    {
                        _local_11 = new ContactLookRequestByIdMessage();
                        _local_11.initContactLookRequestByIdMessage(0, SocialContactCategoryEnum.SOCIAL_CONTACT_CRAFTER, _local_6.crafterId);
                        ConnectionsHandler.getConnection().send(_local_11);
                    };
                    return (true);
                case (msg is JobCrafterDirectoryListMessage):
                    _local_7 = (msg as JobCrafterDirectoryListMessage);
                    this._crafterList = new Array();
                    for each (entry in _local_7.listEntries)
                    {
                        this._crafterList.push(CraftsmanWrapper.create(entry));
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectoryListUpdate, this._crafterList);
                    return (true);
                case (msg is JobCrafterDirectoryRemoveMessage):
                    _local_8 = (msg as JobCrafterDirectoryRemoveMessage);
                    i = 0;
                    while (i < this._crafterList.length)
                    {
                        jobInfo = this._crafterList[i];
                        if ((((jobInfo.jobId == _local_8.jobId)) && ((jobInfo.playerId == _local_8.playerId))))
                        {
                            this._crafterList.splice(i, 1);
                            break;
                        };
                        i++;
                    };
                    KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectoryListUpdate, this._crafterList);
                    return (true);
                case (msg is JobCrafterDirectoryAddMessage):
                    _local_9 = (msg as JobCrafterDirectoryAddMessage);
                    for (iCrafter in this._crafterList)
                    {
                        if (_local_9.listEntry.playerInfo.playerId == this._crafterList[iCrafter].playerId)
                        {
                            this._crafterList.splice(iCrafter, 1);
                        };
                    };
                    this._crafterList.push(CraftsmanWrapper.create(_local_9.listEntry));
                    KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectoryListUpdate, this._crafterList);
                    return (true);
                case (msg is JobCrafterDirectoryEntryMessage):
                    return (false);
                case (msg is LeaveDialogRequestAction):
                    ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
                    return (true);
                case (msg is ExchangeLeaveMessage):
                    _local_10 = (msg as ExchangeLeaveMessage);
                    if (_local_10.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
                    {
                        Kernel.getWorker().removeFrame(this);
                    };
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
            return (true);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

