package com.ankamagames.dofus.datacenter.alignments
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class AlignmentOrder extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var sideId:uint;
        private var _name:String;
        private static const MODULE:String = "AlignmentOrder";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentOrder));

        public function AlignmentOrder()
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

        public static function getAlignmentOrderById(param1:int) : AlignmentOrder
        {
            return GameData.getObject(MODULE, param1) as AlignmentOrder;
        }// end function

        public static function getAlignmentOrders() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
