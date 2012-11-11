package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.jobs.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.job.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.dofus.network.messages.game.social.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class JobCrafterDirectoryListDialogFrame extends Object implements Frame
    {
        private var _crafterList:Array = null;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(JobsFrame));

        public function JobCrafterDirectoryListDialogFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            switch(true)
            {
                case param1 is JobCrafterDirectoryListRequestAction:
                {
                    _loc_2 = param1 as JobCrafterDirectoryListRequestAction;
                    _loc_3 = new JobCrafterDirectoryListRequestMessage();
                    _loc_3.initJobCrafterDirectoryListRequestMessage(_loc_2.jobId);
                    ConnectionsHandler.getConnection().send(_loc_3);
                    return true;
                }
                case param1 is JobCrafterDirectoryEntryRequestAction:
                {
                    _loc_4 = param1 as JobCrafterDirectoryEntryRequestAction;
                    _loc_5 = new JobCrafterDirectoryEntryRequestMessage();
                    _loc_5.initJobCrafterDirectoryEntryRequestMessage(_loc_4.playerId);
                    ConnectionsHandler.getConnection().send(_loc_5);
                    return true;
                }
                case param1 is JobCrafterContactLookRequestAction:
                {
                    _loc_6 = param1 as JobCrafterContactLookRequestAction;
                    if (_loc_6.crafterId == PlayedCharacterManager.getInstance().infos.id)
                    {
                        KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook, _loc_6.crafterId, PlayedCharacterManager.getInstance().infos.name, EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook));
                    }
                    else
                    {
                        _loc_11 = new ContactLookRequestByIdMessage();
                        _loc_11.initContactLookRequestByIdMessage(0, SocialContactCategoryEnum.SOCIAL_CONTACT_CRAFTER, _loc_6.crafterId);
                        ConnectionsHandler.getConnection().send(_loc_11);
                    }
                    return true;
                }
                case param1 is JobCrafterDirectoryListMessage:
                {
                    _loc_7 = param1 as JobCrafterDirectoryListMessage;
                    this._crafterList = new Array();
                    for each (_loc_12 in _loc_7.listEntries)
                    {
                        
                        this._crafterList.push(createCrafterDirectoryListEntry(_loc_12));
                    }
                    KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectoryListUpdate, this._crafterList);
                    return true;
                }
                case param1 is JobCrafterDirectoryRemoveMessage:
                {
                    _loc_8 = param1 as JobCrafterDirectoryRemoveMessage;
                    _loc_13 = 0;
                    while (_loc_13 < this._crafterList.length)
                    {
                        
                        _loc_14 = this._crafterList[_loc_13];
                        if (_loc_14.jobInfo.jobId == _loc_8.jobId && _loc_14.playerInfo.playerId == _loc_8.playerId)
                        {
                            this._crafterList.splice(_loc_13, 1);
                            break;
                        }
                        _loc_13 = _loc_13 + 1;
                    }
                    KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectoryListUpdate, this._crafterList);
                    return true;
                }
                case param1 is JobCrafterDirectoryAddMessage:
                {
                    _loc_9 = param1 as JobCrafterDirectoryAddMessage;
                    for (_loc_15 in this._crafterList)
                    {
                        
                        if (_loc_9.listEntry.playerInfo.playerId == this._crafterList[_loc_15].playerInfo.playerId)
                        {
                            this._crafterList.splice(_loc_15, 1);
                        }
                    }
                    this._crafterList.push(createCrafterDirectoryListEntry(_loc_9.listEntry));
                    KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectoryListUpdate, this._crafterList);
                    return true;
                }
                case param1 is JobCrafterDirectoryEntryMessage:
                {
                    return false;
                }
                case param1 is LeaveDialogRequestAction:
                {
                    ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
                    return true;
                }
                case param1 is ExchangeLeaveMessage:
                {
                    _loc_10 = param1 as ExchangeLeaveMessage;
                    if (_loc_10.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
                    {
                        Kernel.getWorker().removeFrame(this);
                    }
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
            return true;
        }// end function

        private static function createCrafterDirectoryListEntry(param1:JobCrafterDirectoryListEntry) : Object
        {
            var _loc_2:* = new Object();
            _loc_2.playerInfo = param1.playerInfo;
            _loc_2.jobInfo = createCrafterDirectoryJobInfo(param1.jobInfo);
            return _loc_2;
        }// end function

        private static function createCrafterDirectoryJobInfo(param1:JobCrafterDirectoryEntryJobInfo) : Object
        {
            var _loc_2:* = new Object();
            _loc_2.jobId = param1.jobId;
            _loc_2.jobLevel = param1.jobLevel;
            _loc_2.minSlots = param1.minSlots;
            _loc_2.specialization = Job.getJobById(param1.jobId).specializationOfId > 0;
            _loc_2.notFree = (param1.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE) != 0;
            _loc_2.notFreeExceptOnFail = (param1.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE_EXCEPT_ON_FAIL) != 0;
            _loc_2.resourcesRequired = (param1.userDefinedParams & CrafterDirectoryParamBitEnum.CRAFT_OPTION_RESOURCES_REQUIRED) != 0;
            return _loc_2;
        }// end function

    }
}
