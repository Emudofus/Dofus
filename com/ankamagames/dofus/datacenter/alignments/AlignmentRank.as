package com.ankamagames.dofus.datacenter.alignments
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class AlignmentRank extends Object implements IDataCenter
    {
        public var id:int;
        public var orderId:uint;
        public var nameId:uint;
        public var descriptionId:uint;
        public var minimumAlignment:int;
        public var objectsStolen:int;
        public var gifts:Vector.<int>;
        private var _name:String;
        private var _description:String;
        private static const MODULE:String = "AlignmentRank";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentRank));

        public function AlignmentRank()
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

        public static function getAlignmentRankById(param1:int) : AlignmentRank
        {
            return GameData.getObject(MODULE, param1) as AlignmentRank;
        }// end function

        public static function getAlignmentRanks() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
