package com.ankamagames.dofus.misc.interClient
{
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class InterClientManager extends Object
    {
        private var _client:InterClientSlave;
        private var _master:InterClientMaster;
        private var hex_chars:Array;
        private var _identity:String;
        public var clientListInfo:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(InterClientManager));
        private static var _self:InterClientManager;

        public function InterClientManager()
        {
            this.hex_chars = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];
            this.clientListInfo = new Array("_dofus", 0);
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        public function get flashKey() : String
        {
            if (!this._identity)
            {
                return this.getRandomFlashKey();
            }
            return this._identity;
        }// end function

        public function set flashKey(param1:String) : void
        {
            this._identity = param1;
            return;
        }// end function

        public function get isAlone() : Boolean
        {
            return isMaster() && this._master.isAlone;
        }// end function

        public function identifyFromFlashKey() : void
        {
            var _loc_1:* = CustomSharedObject.getLocal("uid");
            if (!_loc_1.data["identity"])
            {
                this._identity = this.getRandomFlashKey();
                _loc_1.data["identity"] = this._identity;
                _loc_1.flush();
            }
            else
            {
                this._identity = _loc_1.data["identity"];
            }
            _loc_1.close();
            return;
        }// end function

        public function update() : void
        {
            this._master = InterClientMaster.etreLeCalif();
            if (!this._master && !this._client)
            {
                this._client = new InterClientSlave();
                this._client.retreiveUid();
            }
            if (this._master && this._client)
            {
                try
                {
                    this._client.destroy();
                    this._client = null;
                }
                catch (ae:ArgumentError)
                {
                    _log.warn("Closing a disconnected LocalConnection in update(). Exception catched.");
                }
                this.gainFocus();
            }
            return;
        }// end function

        public function gainFocus() : void
        {
            var _loc_1:* = new Date().time;
            if (this._client)
            {
                this._client.gainFocus(_loc_1);
            }
            else if (this._master)
            {
                this._master.clientGainFocus("_dofus," + new Date().time);
            }
            return;
        }// end function

        public function resetFocus() : void
        {
            if (this._client)
            {
                this._client.gainFocus(0);
            }
            else if (this._master)
            {
                this._master.clientGainFocus("_dofus,0");
            }
            return;
        }// end function

        public function updateFocusList() : void
        {
            var _loc_1:* = this._master ? ("_dofus") : (this._client.connId);
            DofusFpsManager.updateFocusList(this.clientListInfo, _loc_1);
            return;
        }// end function

        private function getRandomFlashKey() : String
        {
            var _loc_1:* = "";
            var _loc_2:* = 20;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_1 = _loc_1 + this.getRandomChar();
                _loc_3 = _loc_3 + 1;
            }
            return _loc_1 + this.checksum(_loc_1);
        }// end function

        private function checksum(param1:String) : String
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2 = _loc_2 + param1.charCodeAt(_loc_3) % 16;
                _loc_3 = _loc_3 + 1;
            }
            return this.hex_chars[_loc_2 % 16];
        }// end function

        private function getRandomChar() : String
        {
            var _loc_1:* = Math.ceil(Math.random() * 100);
            if (_loc_1 <= 40)
            {
                return String.fromCharCode(Math.floor(Math.random() * 26) + 65);
            }
            if (_loc_1 <= 80)
            {
                return String.fromCharCode(Math.floor(Math.random() * 26) + 97);
            }
            return String.fromCharCode(Math.floor(Math.random() * 10) + 48);
        }// end function

        public static function getInstance() : InterClientManager
        {
            if (!_self)
            {
                _self = new InterClientManager;
            }
            return _self;
        }// end function

        public static function destroy() : void
        {
            if (_self)
            {
                try
                {
                    if (_self._client)
                    {
                        _self._client.destroy();
                    }
                    if (_self._master)
                    {
                        _self._master.destroy();
                    }
                }
                catch (ae:ArgumentError)
                {
                    _log.warn("Closing a disconnected LocalConnection in destroy(). Exception catched.");
                }
            }
            return;
        }// end function

        public static function isMaster() : Boolean
        {
            return getInstance()._master != null;
        }// end function

    }
}
