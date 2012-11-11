package com.ankamagames.dofus.misc.interClient
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class InterClientSlave extends Object
    {
        private var _receiving_lc:LocalConnection;
        private var _sending_lc:LocalConnection;
        private var _statusTimer:Timer;
        private var _waitingFocusMessage:Array;
        public var connId:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(InterClientSlave));

        public function InterClientSlave()
        {
            this._waitingFocusMessage = new Array();
            this._receiving_lc = new LocalConnection();
            this._sending_lc = new LocalConnection();
            this._sending_lc.allowDomain("*");
            this._sending_lc.allowInsecureDomain("*");
            this._sending_lc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onError);
            this._sending_lc.addEventListener(StatusEvent.STATUS, this.onStatusEvent);
            this._receiving_lc.allowDomain("*");
            this._receiving_lc.allowInsecureDomain("*");
            this._receiving_lc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onError);
            this._receiving_lc.addEventListener(StatusEvent.STATUS, this.onStatusEvent);
            var idIsFree:Boolean;
            do
            {
                
                this.connId = "_dofus" + Math.floor(Math.random() * 100000000);
                try
                {
                    this._receiving_lc.connect(this.connId);
                    idIsFree;
                }
                catch (e:Error)
                {
                }
            }while (!idIsFree)
            this._sending_lc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._sending_lc.addEventListener(StatusEvent.STATUS, this.onStatusChange);
            this._receiving_lc.client = new Object();
            this._receiving_lc.client.setUId = this.setUId;
            this._receiving_lc.client.pong = this.pong;
            this._receiving_lc.client.updateFocusMessage = this.updateFocusMessage;
            this._statusTimer = new Timer(10000);
            this._statusTimer.addEventListener(TimerEvent.TIMER, this.onTick);
            this._statusTimer.start();
            return;
        }// end function

        public function destroy() : void
        {
            this._receiving_lc.close();
            this._statusTimer.removeEventListener(TimerEvent.TIMER, this.onTick);
            return;
        }// end function

        public function gainFocus(param1:Number) : void
        {
            var message:String;
            var time:* = param1;
            message = this.connId + "," + time;
            try
            {
                this._sending_lc.send("_dofus", "clientGainFocus", message);
            }
            catch (e:Error)
            {
                _waitingFocusMessage.push(message);
            }
            return;
        }// end function

        public function retreiveUid() : void
        {
            this._sending_lc.send("_dofus", "getUid", this.connId);
            return;
        }// end function

        public function updateFocusMessage(param1:String) : void
        {
            _log.info("Client : " + param1);
            InterClientManager.getInstance().clientListInfo = param1.split(",");
            InterClientManager.getInstance().updateFocusList();
            return;
        }// end function

        private function setUId(param1:String) : void
        {
            var _loc_2:* = CustomSharedObject.getLocal("uid");
            InterClientManager.getInstance().flashKey = param1;
            _loc_2.data["identity"] = param1;
            _loc_2.flush();
            _loc_2.close();
            return;
        }// end function

        private function pong() : void
        {
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

        private function onTick(event:Event) : void
        {
            this._sending_lc.send("_dofus", "ping", this.connId);
            return;
        }// end function

        private function onStatusChange(event:StatusEvent) : void
        {
            if (event.level == "error")
            {
                InterClientManager.getInstance().update();
                while (this._waitingFocusMessage.length)
                {
                    
                    this._sending_lc.send("_dofus", "clientGainFocus", this._waitingFocusMessage.shift());
                }
            }
            return;
        }// end function

        private function onSecurityError(param1:Error) : void
        {
            return;
        }// end function

    }
}
