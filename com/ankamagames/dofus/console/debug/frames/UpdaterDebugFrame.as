package com.ankamagames.dofus.console.debug.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.updater.parts.PartsListMessage;
    import com.ankamagames.dofus.network.messages.updater.parts.PartInfoMessage;
    import com.ankamagames.dofus.network.messages.updater.parts.DownloadCurrentSpeedMessage;
    import com.ankamagames.dofus.network.types.updater.ContentPart;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.network.messages.updater.parts.GetPartsListMessage;
    import com.ankamagames.dofus.kernel.updater.UpdaterConnexionHandler;
    import com.ankamagames.dofus.network.messages.updater.parts.GetPartInfoMessage;
    import com.ankamagames.dofus.network.messages.updater.parts.DownloadSetSpeedRequestMessage;
    import com.ankamagames.dofus.network.messages.updater.parts.DownloadGetCurrentSpeedRequestMessage;
    import com.ankamagames.dofus.network.messages.updater.parts.DownloadPartMessage;

    public class UpdaterDebugFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UpdaterDebugFrame));

        private var _partInfoCallback:Function;
        private var _updaterSpeedCallback:Function;


        public function get priority():int
        {
            return (Priority.LOW);
        }

        public function pushed():Boolean
        {
            this._partInfoCallback = null;
            this._updaterSpeedCallback = null;
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:PartsListMessage;
            var _local_3:PartInfoMessage;
            var _local_4:DownloadCurrentSpeedMessage;
            var cp:ContentPart;
            switch (true)
            {
                case (msg is PartsListMessage):
                    _local_2 = (msg as PartsListMessage);
                    if (this._partInfoCallback != null)
                    {
                        for each (cp in _local_2.parts)
                        {
                            this._partInfoCallback(cp);
                        };
                        this._partInfoCallback = null;
                    };
                    return (false);
                case (msg is PartInfoMessage):
                    _local_3 = (msg as PartInfoMessage);
                    if (this._partInfoCallback != null)
                    {
                        this._partInfoCallback(_local_3.part);
                        this._partInfoCallback = null;
                    };
                    return (false);
                case (msg is DownloadCurrentSpeedMessage):
                    _local_4 = (msg as DownloadCurrentSpeedMessage);
                    if (this._updaterSpeedCallback != null)
                    {
                        this._updaterSpeedCallback(_local_4.downloadSpeed);
                        this._updaterSpeedCallback = null;
                    };
                    return (false);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        public function partListRequest(partInfoCallback:Function):void
        {
            _log.info("Send part list request");
            this._partInfoCallback = partInfoCallback;
            var gplmsg:GetPartsListMessage = new GetPartsListMessage();
            gplmsg.initGetPartsListMessage();
            UpdaterConnexionHandler.getConnection().send(gplmsg);
        }

        public function partInfoRequest(id:String, partInfoCallback:Function):void
        {
            _log.info("Send part info request");
            this._partInfoCallback = partInfoCallback;
            var gpimsg:GetPartInfoMessage = new GetPartInfoMessage();
            gpimsg.initGetPartInfoMessage(id);
            UpdaterConnexionHandler.getConnection().send(gpimsg);
        }

        public function setUpdaterSpeedRequest(speed:int, updaterSpeedCallback:Function):void
        {
            _log.info("Send updater speed request");
            this._updaterSpeedCallback = updaterSpeedCallback;
            var dssrmsg:DownloadSetSpeedRequestMessage = new DownloadSetSpeedRequestMessage();
            dssrmsg.initDownloadSetSpeedRequestMessage(speed);
            UpdaterConnexionHandler.getConnection().send(dssrmsg);
        }

        public function getUpdaterSpeedRequest(updaterSpeedCallback:Function):void
        {
            _log.info("Send updater speed request");
            this._updaterSpeedCallback = updaterSpeedCallback;
            var dgcsrmsg:DownloadGetCurrentSpeedRequestMessage = new DownloadGetCurrentSpeedRequestMessage();
            dgcsrmsg.initDownloadGetCurrentSpeedRequestMessage();
            UpdaterConnexionHandler.getConnection().send(dgcsrmsg);
        }

        public function downloadPartRequest(id:String, partInfoCallback:Function):void
        {
            _log.info("Send download part request");
            this._partInfoCallback = partInfoCallback;
            var dpmsg:DownloadPartMessage = new DownloadPartMessage();
            dpmsg.initDownloadPartMessage(id);
            UpdaterConnexionHandler.getConnection().send(dpmsg);
        }


    }
}//package com.ankamagames.dofus.console.debug.frames

