package com.ankamagames.dofus.datacenter.alignments
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class AlignmentTitle extends Object implements IDataCenter
    {
        public var sideId:int;
        public var namesId:Vector.<int>;
        public var shortsId:Vector.<int>;
        private static const MODULE:String = "AlignmentTitles";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentTitle));

        public function AlignmentTitle()
        {
            return;
        }// end function

        public function getNameFromGrade(param1:int) : String
        {
            return I18n.getText(this.namesId[param1]);
        }// end function

        public function getShortNameFromGrade(param1:int) : String
        {
            return I18n.getText(this.shortsId[param1]);
        }// end function

        public static function getAlignmentTitlesById(param1:int) : AlignmentTitle
        {
            return GameData.getObject(MODULE, param1) as AlignmentTitle;
        }// end function

        public static function getAlignmentTitles() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
