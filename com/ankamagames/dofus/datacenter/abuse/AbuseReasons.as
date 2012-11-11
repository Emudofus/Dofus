package com.ankamagames.dofus.datacenter.abuse
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class AbuseReasons extends Object implements IDataCenter
    {
        public var _abuseReasonId:uint;
        public var _mask:uint;
        public var _reasonTextId:int;
        private var _name:String;
        private static const MODULE:String = "AbuseReasons";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AbuseReasons));

        public function AbuseReasons()
        {
            return;
        }// end function

        public function get name() : String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this._reasonTextId);
            }
            return this._name;
        }// end function

        public static function getReasonNameById(param1:uint) : AbuseReasons
        {
            return GameData.getObject(MODULE, param1) as AbuseReasons;
        }// end function

        public static function getReasonNames() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
