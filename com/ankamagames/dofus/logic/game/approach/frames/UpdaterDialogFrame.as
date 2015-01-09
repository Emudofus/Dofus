package com.ankamagames.dofus.logic.game.approach.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.logic.game.approach.actions.GetPartsListAction;
    import com.ankamagames.dofus.network.messages.updater.parts.GetPartsListMessage;
    import com.ankamagames.dofus.network.messages.updater.parts.PartsListMessage;
    import com.ankamagames.dofus.logic.game.approach.actions.DownloadPartAction;
    import com.ankamagames.dofus.logic.game.approach.actions.GetPartInfoAction;
    import com.ankamagames.dofus.network.messages.updater.parts.GetPartInfoMessage;
    import com.ankamagames.dofus.network.messages.updater.parts.PartInfoMessage;
    import com.ankamagames.dofus.network.messages.updater.parts.DownloadCurrentSpeedMessage;
    import com.ankamagames.dofus.network.messages.updater.parts.DownloadErrorMessage;
    import com.ankamagames.dofus.kernel.updater.UpdaterConnexionHandler;
    import com.ankamagames.dofus.logic.game.approach.managers.PartManager;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.game.common.managers.InactivityManager;
    import com.ankamagames.dofus.logic.game.approach.utils.DownloadMonitoring;
    import com.ankamagames.jerakine.messages.Message;

    public class UpdaterDialogFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UpdaterDialogFrame));


        public function get priority():int
        {
            return (Priority.LOWEST);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:GetPartsListAction;
            var _local_3:GetPartsListMessage;
            var _local_4:PartsListMessage;
            var _local_5:DownloadPartAction;
            var _local_6:GetPartInfoAction;
            var _local_7:GetPartInfoMessage;
            var _local_8:PartInfoMessage;
            var _local_9:int;
            var _local_10:DownloadCurrentSpeedMessage;
            var _local_11:DownloadErrorMessage;
            switch (true)
            {
                case (msg is GetPartsListAction):
                    _local_2 = (msg as GetPartsListAction);
                    _local_3 = new GetPartsListMessage();
                    _local_3.initGetPartsListMessage();
                    UpdaterConnexionHandler.getConnection().send(_local_3);
                    return (true);
                case (msg is PartsListMessage):
                    _local_4 = (msg as PartsListMessage);
                    PartManager.getInstance().receiveParts(_local_4.parts);
                    KernelEventsManager.getInstance().processCallback(HookList.PartsList, _local_4.parts);
                    return (true);
                case (msg is DownloadPartAction):
                    _local_5 = (msg as DownloadPartAction);
                    PartManager.getInstance().checkAndDownload(_local_5.id);
                    return (true);
                case (msg is GetPartInfoAction):
                    _local_6 = (msg as GetPartInfoAction);
                    _local_7 = new GetPartInfoMessage();
                    _local_7.initGetPartInfoMessage(_local_6.id);
                    UpdaterConnexionHandler.getConnection().send(_local_7);
                    return (true);
                case (msg is PartInfoMessage):
                    _local_8 = (msg as PartInfoMessage);
                    InactivityManager.getInstance().activity();
                    PartManager.getInstance().updatePart(_local_8.part);
                    _local_9 = PartManager.getInstance().getDownloadPercent(_local_8.installationPercent);
                    KernelEventsManager.getInstance().processCallback(HookList.PartInfo, _local_8.part, _local_9);
                    return (true);
                case (msg is DownloadCurrentSpeedMessage):
                    _local_10 = (msg as DownloadCurrentSpeedMessage);
                    DownloadMonitoring.getInstance().downloadSpeed = _local_10.downloadSpeed;
                    KernelEventsManager.getInstance().processCallback(HookList.DownloadSpeed, _local_10.downloadSpeed);
                    return (true);
                case (msg is DownloadErrorMessage):
                    _local_11 = (msg as DownloadErrorMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.DownloadError, _local_11.errorId, (((_local_11.message.length > 0)) ? _local_11.message : (null)), (((_local_11.helpUrl.length > 0)) ? _local_11.helpUrl : null));
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.frames

