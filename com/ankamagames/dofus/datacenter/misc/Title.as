package com.ankamagames.dofus.datacenter.misc
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Title extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var color:String;
        private var _name:String;
        private static const MODULE:String = "Titles";

        public function Title()
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

        public static function getTitleById(param1:int) : Title
        {
            return GameData.getObject(MODULE, param1) as Title;
        }// end function

        public static function getAllTitle() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
