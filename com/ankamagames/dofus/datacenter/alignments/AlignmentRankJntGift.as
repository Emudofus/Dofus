package com.ankamagames.dofus.datacenter.alignments
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class AlignmentRankJntGift extends Object implements IDataCenter
    {
        public var id:int;
        public var gifts:Vector.<int>;
        public var parameters:Vector.<int>;
        public var levels:Vector.<int>;
        private static const MODULE:String = "AlignmentRankJntGift";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentRankJntGift));

        public function AlignmentRankJntGift()
        {
            return;
        }// end function

        public static function getAlignmentRankJntGiftById(param1:int) : AlignmentRankJntGift
        {
            return GameData.getObject(MODULE, param1) as AlignmentRankJntGift;
        }// end function

        public static function getAlignmentRankJntGifts() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
