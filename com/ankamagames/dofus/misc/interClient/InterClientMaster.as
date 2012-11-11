package com.ankamagames.dofus.misc.interClient
{
    import com.ankamagames.jerakine.logger.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class InterClientMaster extends Object
    {
        private var _sending_lc:LocalConnection;
        private var _lastPingTs:uint;
        private var _lastClientPing:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(InterClientSlave));
        private static var _receiving_lc:LocalConnection;

        public function InterClientMaster()
        {
            this._lastClientPing = new Array();
            InterClientManager.getInstance().identifyFromFlashKey();
            this._sending_lc = new LocalConnection();
            this._sending_lc.allowDomain("*");
            this._sending_lc.allowInsecureDomain("*");
            this._sending_lc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onError);
            this._sending_lc.addEventListener(StatusEvent.STATUS, this.onStatusEvent);
            _receiving_lc.client = new Object();
            _receiving_lc.allowDomain("*");
            _receiving_lc.allowInsecureDomain("*");
            _receiving_lc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onError);
            _receiving_lc.addEventListener(StatusEvent.STATUS, this.onStatusEvent);
            _receiving_lc.client.getUid = this.getUid;
            _receiving_lc.client.ping = this.ping;
            _receiving_lc.client.clientGainFocus = this.clientGainFocus;
            _receiving_lc.client.updateFocusMessage = this.updateFocusMessage;
            this._lastPingTs = getTimer();
            return;
        }// end function

        public function get isAlone() : Boolean
        {
            return getTimer() - this._lastPingTs > 20000;
        }// end function

        public function destroy() : void
        {
            this._sending_lc = null;
            _receiving_lc.close();
            return;
        }// end function

        public function clientGainFocus(param1:String) : void
        {
            var clientListInfo:Array;
            var num:int;
            var i:int;
            var id:String;
            var baseInfo:* = param1;
            var info:* = baseInfo.split(",");
            var connId:* = info[0];
            var time:* = info[1];
            clientListInfo = InterClientManager.getInstance().clientListInfo;
            var index:* = clientListInfo.indexOf(connId);
            if (index == -1)
            {
                clientListInfo.push(connId, time);
            }
            else
            {
                clientListInfo[(index + 1)] = time;
            }
            var baseClientListInfo:* = clientListInfo.join(",");
            num = clientListInfo.length;
            i;
            while (i < num)
            {
                
                id = clientListInfo[i];
                try
                {
                    this._sending_lc.send(id, "updateFocusMessage", baseClientListInfo);
                }
                catch (e:Error)
                {
                    _log.debug(e.getStackTrace());
                    clientListInfo.splice(i, 2);
                    i = i - 2;
                    num = num - 2;
                }
                i = i + 2;
            }
            return;
        }// end function

        private function onError(event:AsyncErrorEvent) : void
        {
            _log.debug(event.error.getStackTrace());
            return;
        }// end function

        private function onStatusEvent(event:StatusEvent) : void
        {
            return;
        }// end function

        public function updateFocusMessage(param1:String) : void
        {
            InterClientManager.getInstance().clientListInfo = param1.split(",");
            InterClientManager.getInstance().updateFocusList();
            return;
        }// end function

        private function getUid(param1:String) : void
        {
            this._sending_lc.send(param1, "setUId", InterClientManager.getInstance().flashKey);
            return;
        }// end function

        private function ping(param1:String) : void
        {
            var _loc_5:* = null;
            this._lastPingTs = getTimer();
            this._sending_lc.send(param1, "pong");
            this._lastClientPing[param1] = this._lastPingTs;
            var _loc_2:* = InterClientManager.getInstance().clientListInfo;
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2[_loc_4];
                if (_loc_5 == "_dofus")
                {
                }
                else if (this._lastClientPing[_loc_5])
                {
                    if (this._lastPingTs - this._lastClientPing[_loc_5] > 20000)
                    {
                        _loc_2.splice(_loc_4, 2);
                        _loc_4 = _loc_4 - 2;
                        _loc_3 = _loc_3 - 2;
                    }
                }
                else
                {
                    this._lastClientPing[_loc_5] = this._lastPingTs;
                }
                _loc_4 = _loc_4 + 2;
            }
            return;
        }// end function

        public static function etreLeCalif() : InterClientMaster
        {
            try
            {
                if (!_receiving_lc)
                {
                    _receiving_lc = new LocalConnection();
                }
                _receiving_lc.connect("_dofus");
                return new InterClientMaster;
            }
            catch (e:ArgumentError)
            {
            }
            return null;
        }// end function

    }
}
