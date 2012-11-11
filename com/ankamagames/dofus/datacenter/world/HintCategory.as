package com.ankamagames.dofus.datacenter.world
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class HintCategory extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        private var _name:String;
        private static const MODULE:String = "HintCategory";

        public function HintCategory()
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

        public static function getHintCategoryById(param1:int) : HintCategory
        {
            return GameData.getObject(MODULE, param1) as HintCategory;
        }// end function

        public static function getHintCategories() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
