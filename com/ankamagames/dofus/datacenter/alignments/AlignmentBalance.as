package com.ankamagames.dofus.datacenter.alignments
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class AlignmentBalance extends Object implements IDataCenter
    {
        public var id:int;
        public var startValue:int;
        public var endValue:int;
        public var nameId:uint;
        public var descriptionId:uint;
        private var _name:String;
        private var _description:String;
        private static const MODULE:String = "AlignmentBalance";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentBalance));

        public function AlignmentBalance()
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

        public function get description() : String
        {
            if (!this._description)
            {
                this._description = I18n.getText(this.descriptionId);
            }
            return this._description;
        }// end function

        public static function getAlignmentBalanceById(param1:int) : AlignmentBalance
        {
            return GameData.getObject(MODULE, param1) as AlignmentBalance;
        }// end function

        public static function getAlignmentBalances() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
