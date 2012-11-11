package com.ankamagames.dofus.datacenter.alignments
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class AlignmentGift extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var effectId:int;
        public var gfxId:uint;
        private var _name:String;
        private static const MODULE:String = "AlignmentGift";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentGift));

        public function AlignmentGift()
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

        public static function getAlignmentGiftById(param1:int) : AlignmentGift
        {
            return GameData.getObject(MODULE, param1) as AlignmentGift;
        }// end function

        public static function getAlignmentGifts() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
