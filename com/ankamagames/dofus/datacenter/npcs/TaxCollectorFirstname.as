package com.ankamagames.dofus.datacenter.npcs
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class TaxCollectorFirstname extends Object implements IDataCenter
    {
        public var id:int;
        public var firstnameId:uint;
        private var _firstname:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(TaxCollectorFirstname));
        private static const MODULE:String = "TaxCollectorFirstnames";

        public function TaxCollectorFirstname()
        {
            return;
        }// end function

        public function get firstname() : String
        {
            if (!this._firstname)
            {
                this._firstname = I18n.getText(this.firstnameId);
            }
            return this._firstname;
        }// end function

        public static function getTaxCollectorFirstnameById(param1:int) : TaxCollectorFirstname
        {
            return GameData.getObject(MODULE, param1) as TaxCollectorFirstname;
        }// end function

    }
}
