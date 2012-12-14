package com.ankamagames.dofus.datacenter.appearance
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class TitleCategory extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        private var _name:String;
        private static const MODULE:String = "TitleCategories";

        public function TitleCategory()
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

        public static function getTitleCategoryById(param1:int) : TitleCategory
        {
            return GameData.getObject(MODULE, param1) as TitleCategory;
        }// end function

        public static function getTitleCategories() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
