package com.ankamagames.dofus.console.debug.frames
{
    import com.ankamagames.dofus.kernel.updater.*;
    import com.ankamagames.dofus.network.messages.updater.parts.*;
    import com.ankamagames.dofus.network.types.updater.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class UpdaterDebugFrame extends Object implements Frame
    {
        private var _partInfoCallback:Function;
        private var _updaterSpeedCallback:Function;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(UpdaterDebugFrame));

        public function UpdaterDebugFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.LOW;
        }// end function

        public function pushed() : Boolean
        {
            this._partInfoCallback = null;
            this._updaterSpeedCallback = null;
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:PartsListMessage = null;
            var _loc_3:PartInfoMessage = null;
            var _loc_4:DownloadCurrentSpeedMessage = null;
            var _loc_5:ContentPart = null;
            switch(true)
            {
                case param1 is PartsListMessage:
                {
                    _loc_2 = param1 as PartsListMessage;
                    if (this._partInfoCallback != null)
                    {
                        for each (_loc_5 in _loc_2.parts)
                        {
                            
                            this._partInfoCallback(_loc_5);
                        }
                        this._partInfoCallback = null;
                    }
                    return false;
                }
                case param1 is PartInfoMessage:
                {
                    _loc_3 = param1 as PartInfoMessage;
                    if (this._partInfoCallback != null)
                    {
                        this._partInfoCallback(_loc_3.part);
                        this._partInfoCallback = null;
                    }
                    return false;
                }
                case param1 is DownloadCurrentSpeedMessage:
                {
                    _loc_4 = param1 as DownloadCurrentSpeedMessage;
                    if (this._updaterSpeedCallback != null)
                    {
                        this._updaterSpeedCallback(_loc_4.downloadSpeed);
                        this._updaterSpeedCallback = null;
                    }
                    return false;
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

        public function partListRequest(param1:Function) : void
        {
            _log.info("Send part list request");
            this._partInfoCallback = param1;
            var _loc_2:* = new GetPartsListMessage();
            _loc_2.initGetPartsListMessage();
            UpdaterConnexionHandler.getConnection().send(_loc_2);
            return;
        }// end function

        public function partInfoRequest(param1:String, param2:Function) : void
        {
            _log.info("Send part info request");
            this._partInfoCallback = param2;
            var _loc_3:* = new GetPartInfoMessage();
            _loc_3.initGetPartInfoMessage(param1);
            UpdaterConnexionHandler.getConnection().send(_loc_3);
            return;
        }// end function

        public function setUpdaterSpeedRequest(param1:int, param2:Function) : void
        {
            _log.info("Send updater speed request");
            this._updaterSpeedCallback = param2;
            var _loc_3:* = new DownloadSetSpeedRequestMessage();
            _loc_3.initDownloadSetSpeedRequestMessage(param1);
            UpdaterConnexionHandler.getConnection().send(_loc_3);
            return;
        }// end function

        public function getUpdaterSpeedRequest(param1:Function) : void
        {
            _log.info("Send updater speed request");
            this._updaterSpeedCallback = param1;
            var _loc_2:* = new DownloadGetCurrentSpeedRequestMessage();
            _loc_2.initDownloadGetCurrentSpeedRequestMessage();
            UpdaterConnexionHandler.getConnection().send(_loc_2);
            return;
        }// end function

        public function downloadPartRequest(param1:String, param2:Function) : void
        {
            _log.info("Send download part request");
            this._partInfoCallback = param2;
            var _loc_3:* = new DownloadPartMessage();
            _loc_3.initDownloadPartMessage(param1);
            UpdaterConnexionHandler.getConnection().send(_loc_3);
            return;
        }// end function

    }
}
