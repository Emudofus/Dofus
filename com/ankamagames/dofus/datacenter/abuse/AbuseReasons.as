package com.ankamagames.dofus.datacenter.abuse
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;

    public class AbuseReasons implements IDataCenter 
    {

        public static const MODULE:String = "AbuseReasons";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbuseReasons));

        public var _abuseReasonId:uint;
        public var _mask:uint;
        public var _reasonTextId:int;
        private var _name:String;


        public static function getReasonNameById(id:uint):AbuseReasons
        {
            return ((GameData.getObject(MODULE, id) as AbuseReasons));
        }

        public static function getReasonNames():Array
        {
            return (GameData.getObjects(MODULE));
        }


        public function get name():String
        {
            if (!(this._name))
            {
                this._name = I18n.getText(this._reasonTextId);
            };
            return (this._name);
        }


    }
}//package com.ankamagames.dofus.datacenter.abuse

