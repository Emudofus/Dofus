package com.ankamagames.dofus.datacenter.npcs
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class TaxCollectorName extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        private var _name:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(TaxCollectorName));
        private static const MODULE:String = "TaxCollectorNames";

        public function TaxCollectorName()
        {
            return;
        }// end function

        public function get name() : String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            }
            return this._name;
        }// end function

        public static function getTaxCollectorNameById(param1:int) : TaxCollectorName
        {
            return GameData.getObject(MODULE, param1) as TaxCollectorName;
        }// end function

        public static function getTaxCollectorNames() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
