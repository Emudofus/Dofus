package com.ankamagames.dofus.externalnotification
{
    import com.ankamagames.jerakine.json.*;

    public class ExternalNotificationRequest extends Object
    {
        private var _notificationType:int;
        private var _clientId:String;
        private var _otherClientsIds:Array;
        private var _id:String;
        private var _showMode:int;
        private var _hookName:String;
        private var _hookParams:Array;
        private var _uiName:String;
        private var _displayData:Object;
        private var _playSound:Boolean;
        private var _notify:Boolean;

        public function ExternalNotificationRequest(param1:int, param2:String, param3:Array, param4:String, param5:int, param6:String, param7:Object, param8:Boolean, param9:Boolean, param10:String = null, param11:Array = null)
        {
            this._notificationType = param1;
            this._clientId = param2;
            this._otherClientsIds = param3;
            this._id = param4;
            this._showMode = param5;
            this._uiName = param6;
            this._displayData = param7;
            this._playSound = param8;
            this._notify = param9;
            this._hookName = param10;
            this._hookParams = param11;
            return;
        }// end function

        public function get notificationType() : int
        {
            return this._notificationType;
        }// end function

        public function get instanceId() : String
        {
            return this._clientId + "#" + this._id;
        }// end function

        public function get clientId() : String
        {
            return this._clientId;
        }// end function

        public function get otherClientsIds() : Array
        {
            return this._otherClientsIds;
        }// end function

        public function get id() : String
        {
            return this._id;
        }// end function

        public function get showMode() : int
        {
            return this._showMode;
        }// end function

        public function get uiName() : String
        {
            return this._uiName;
        }// end function

        public function get displayData() : Object
        {
            return this._displayData;
        }// end function

        public function get hookName() : String
        {
            return this._hookName;
        }// end function

        public function get hookParams() : Array
        {
            return this._hookParams;
        }// end function

        public function get playSound() : Boolean
        {
            return this._playSound;
        }// end function

        public function get notify() : Boolean
        {
            return this._notify;
        }// end function

        public static function createFromJSONString(param1:String) : ExternalNotificationRequest
        {
            var _loc_2:* = JSON.decode(param1);
            var _loc_3:* = new ExternalNotificationRequest(_loc_2.notificationType, _loc_2.clientId, _loc_2.otherClientsIds, _loc_2.id, _loc_2.showMode, _loc_2.uiName, _loc_2.displayData, _loc_2.playSound, _loc_2.notify, _loc_2.hookName, _loc_2.hookParams);
            return _loc_3;
        }// end function

    }
}
