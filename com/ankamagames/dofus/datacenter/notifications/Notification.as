package com.ankamagames.dofus.datacenter.notifications
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;

    public class Notification implements IDataCenter 
    {

        public static const MODULE:String = "Notifications";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Notification));

        public var id:int;
        public var titleId:uint;
        public var messageId:uint;
        public var iconId:int;
        public var typeId:int;
        public var trigger:String;
        private var _title:String;
        private var _message:String;


        public static function getNotificationById(id:int):Notification
        {
            return ((GameData.getObject(MODULE, id) as Notification));
        }

        public static function getNotifications():Array
        {
            return (GameData.getObjects(MODULE));
        }


        public function get title():String
        {
            if (!(this._title))
            {
                this._title = I18n.getText(this.titleId);
            };
            return (this._title);
        }

        public function get message():String
        {
            if (!(this._message))
            {
                this._message = I18n.getText(this.messageId);
            };
            return (this._message);
        }


    }
}//package com.ankamagames.dofus.datacenter.notifications

