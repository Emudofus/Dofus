package com.ankamagames.dofus.datacenter.alignments
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class AlignmentEffect extends Object implements IDataCenter
    {
        public var id:int;
        public var characteristicId:uint;
        public var descriptionId:uint;
        private var _description:String;
        private static const MODULE:String = "AlignmentEffect";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentEffect));

        public function AlignmentEffect()
        {
            return;
        }// end function

        public function get description() : String
        {
            if (!this._description)
            {
                this._description = I18n.getText(this.descriptionId);
            }
            return this._description;
        }// end function

        public static function getAlignmentEffectById(param1:int) : AlignmentEffect
        {
            return GameData.getObject(MODULE, param1) as AlignmentEffect;
        }// end function

        public static function getAlignmentEffects() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
