package com.ankamagames.dofus.externalnotification
{
    import com.ankamagames.jerakine.json.*;

    public class ExternalNotificationRequest extends Object
    {
        private var _notificationType:int;
        private var _clientId:String;
        private var _id:String;
        private var _showMode:int;
        private var _title:String;
        private var _iconId:int;
        private var _iconBgColorId:String;
        private var _message:String;
        private var _css:String;
        private var _cssClass:String;

        public function ExternalNotificationRequest(param1:int, param2:String, param3:String, param4:int, param5:String, param6:int, param7:String, param8:String, param9:String, param10:String)
        {
            this._notificationType = param1;
            this._clientId = param2;
            this._id = param3;
            this._showMode = param4;
            this._title = param5;
            this._iconId = param6;
            this._iconBgColorId = param7;
            this._message = param8;
            this._css = param9;
            this._cssClass = param10;
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

        public function get id() : String
        {
            return this._id;
        }// end function

        public function get showMode() : int
        {
            return this._showMode;
        }// end function

        public function get title() : String
        {
            return this._title;
        }// end function

        public function get iconId() : int
        {
            return this._iconId;
        }// end function

        public function get iconBgColorId() : String
        {
            return this._iconBgColorId;
        }// end function

        public function get message() : String
        {
            return this._message;
        }// end function

        public function get css() : String
        {
            return this._css;
        }// end function

        public function get cssClass() : String
        {
            return this._cssClass;
        }// end function

        public static function createFromJSONString(param1:String) : ExternalNotificationRequest
        {
            var _loc_2:* = JSON.decode(param1);
            var _loc_3:* = new ExternalNotificationRequest(_loc_2.notificationType, _loc_2.clientId, _loc_2.id, _loc_2.showMode, _loc_2.title, _loc_2.iconId, _loc_2.iconBgColorId, _loc_2.message, _loc_2.css, _loc_2.cssClass);
            return _loc_3;
        }// end function

    }
}
