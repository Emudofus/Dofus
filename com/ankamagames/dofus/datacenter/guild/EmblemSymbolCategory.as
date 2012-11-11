package com.ankamagames.dofus.datacenter.guild
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class EmblemSymbolCategory extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        private var _name:String;
        private static const MODULE:String = "EmblemSymbolCategories";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EmblemSymbolCategory));

        public function EmblemSymbolCategory()
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

        public static function getEmblemSymbolCategoryById(param1:int) : EmblemSymbolCategory
        {
            return GameData.getObject(MODULE, param1) as EmblemSymbolCategory;
        }// end function

        public static function getEmblemSymbolCategories() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
