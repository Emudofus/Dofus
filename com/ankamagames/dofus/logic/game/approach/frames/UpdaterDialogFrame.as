package com.ankamagames.dofus.logic.game.approach.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.misc.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.kernel.updater.*;
    import com.ankamagames.dofus.logic.game.approach.actions.*;
    import com.ankamagames.dofus.logic.game.approach.managers.*;
    import com.ankamagames.dofus.logic.game.approach.utils.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.packs.*;
    import com.ankamagames.dofus.network.messages.updater.parts.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class UpdaterDialogFrame extends Object implements Frame
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(UpdaterDialogFrame));

        public function UpdaterDialogFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.LOWEST;
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
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            switch(true)
            {
                case param1 is GetPartsListAction:
                {
                    _loc_2 = param1 as GetPartsListAction;
                    _loc_3 = new GetPartsListMessage();
                    _loc_3.initGetPartsListMessage();
                    UpdaterConnexionHandler.getConnection().send(_loc_3);
                    return true;
                }
                case param1 is PartsListMessage:
                {
                    _loc_4 = param1 as PartsListMessage;
                    PartManager.getInstance().receiveParts(_loc_4.parts);
                    KernelEventsManager.getInstance().processCallback(HookList.PartsList, _loc_4.parts);
                    return true;
                }
                case param1 is DownloadPartAction:
                {
                    _loc_5 = param1 as DownloadPartAction;
                    PartManager.getInstance().checkAndDownload(_loc_5.id);
                    return true;
                }
                case param1 is GetPartInfoAction:
                {
                    _loc_6 = param1 as GetPartInfoAction;
                    _loc_7 = new GetPartInfoMessage();
                    _loc_7.initGetPartInfoMessage(_loc_6.id);
                    UpdaterConnexionHandler.getConnection().send(_loc_7);
                    return true;
                }
                case param1 is PartInfoMessage:
                {
                    _loc_8 = param1 as PartInfoMessage;
                    InactivityManager.getInstance().activity();
                    PartManager.getInstance().updatePart(_loc_8.part);
                    _loc_9 = PartManager.getInstance().getDownloadPercent(_loc_8.installationPercent);
                    KernelEventsManager.getInstance().processCallback(HookList.PartInfo, _loc_8.part, _loc_9);
                    return true;
                }
                case param1 is DownloadCurrentSpeedMessage:
                {
                    _loc_10 = param1 as DownloadCurrentSpeedMessage;
                    DownloadMonitoring.getInstance().downloadSpeed = _loc_10.downloadSpeed;
                    KernelEventsManager.getInstance().processCallback(HookList.DownloadSpeed, _loc_10.downloadSpeed);
                    return true;
                }
                case param1 is PackRestrictedSubAreaMessage:
                {
                    _loc_11 = param1 as PackRestrictedSubAreaMessage;
                    _loc_12 = SubArea.getSubAreaById(_loc_11.subAreaId);
                    _loc_13 = Pack.getPackById(_loc_12.packId);
                    if (_loc_13.name == "subscribed")
                    {
                        PartManager.getInstance().checkAndDownload("all");
                    }
                    PartManager.getInstance().checkAndDownload(_loc_13.name);
                    KernelEventsManager.getInstance().processCallback(HookList.PackRestrictedSubArea, _loc_11.subAreaId);
                    return true;
                }
                case param1 is DownloadErrorMessage:
                {
                    _loc_14 = param1 as DownloadErrorMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.DownloadError, _loc_14.errorId, _loc_14.message.length > 0 ? (_loc_14.message) : (null), _loc_14.helpUrl.length > 0 ? (_loc_14.helpUrl) : (null));
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
            return true;
        }// end function

    }
}
