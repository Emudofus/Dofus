package com.ankamagames.dofus.datacenter.alignments
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.GameData;

    public class AlignmentRankJntGift implements IDataCenter 
    {

        public static const MODULE:String = "AlignmentRankJntGift";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentRankJntGift));

        public var id:int;
        public var gifts:Vector.<int>;
        public var parameters:Vector.<int>;
        public var levels:Vector.<int>;


        public static function getAlignmentRankJntGiftById(id:int):AlignmentRankJntGift
        {
            return ((GameData.getObject(MODULE, id) as AlignmentRankJntGift));
        }

        public static function getAlignmentRankJntGifts():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.alignments

