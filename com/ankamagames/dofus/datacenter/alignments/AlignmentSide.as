package com.ankamagames.dofus.datacenter.alignments
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class AlignmentSide extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var canConquest:Boolean;
        private var _name:String;
        private static const MODULE:String = "AlignmentSides";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentSide));

        public function AlignmentSide()
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

        public static function getAlignmentSideById(param1:int) : AlignmentSide
        {
            return GameData.getObject(MODULE, param1) as AlignmentSide;
        }// end function

        public static function getAlignmentSides() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
