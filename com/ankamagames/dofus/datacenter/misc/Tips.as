package com.ankamagames.dofus.datacenter.misc
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;

    public class Tips implements IDataCenter 
    {

        public static const MODULE:String = "Tips";

        public var id:int;
        public var descId:uint;
        private var _description:String;


        public static function getTipsById(id:int):Tips
        {
            return ((GameData.getObject(MODULE, id) as Tips));
        }

        public static function getAllTips():Array
        {
            return (GameData.getObjects(MODULE));
        }


        public function get description():String
        {
            if (!(this._description))
            {
                this._description = I18n.getText(this.descId);
            };
            return (this._description);
        }


    }
}//package com.ankamagames.dofus.datacenter.misc

