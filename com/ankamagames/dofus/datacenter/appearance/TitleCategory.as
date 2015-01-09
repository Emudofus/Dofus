package com.ankamagames.dofus.datacenter.appearance
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;

    public class TitleCategory implements IDataCenter 
    {

        public static const MODULE:String = "TitleCategories";

        public var id:int;
        public var nameId:uint;
        private var _name:String;


        public static function getTitleCategoryById(id:int):TitleCategory
        {
            return ((GameData.getObject(MODULE, id) as TitleCategory));
        }

        public static function getTitleCategories():Array
        {
            return (GameData.getObjects(MODULE));
        }


        public function get name():String
        {
            if (!(this._name))
            {
                this._name = I18n.getText(this.nameId);
            };
            return (this._name);
        }


    }
}//package com.ankamagames.dofus.datacenter.appearance

