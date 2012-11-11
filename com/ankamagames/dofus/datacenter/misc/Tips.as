package com.ankamagames.dofus.datacenter.misc
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Tips extends Object implements IDataCenter
    {
        public var id:int;
        public var descId:uint;
        private var _description:String;
        private static const MODULE:String = "Tips";

        public function Tips()
        {
            return;
        }// end function

        public function get description() : String
        {
            if (!this._description)
            {
                this._description = I18n.getText(this.descId);
            }
            return this._description;
        }// end function

        public static function getTipsById(param1:int) : Tips
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getAllTips() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
