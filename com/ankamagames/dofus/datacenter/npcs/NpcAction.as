package com.ankamagames.dofus.datacenter.npcs
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.data.GameData;
    import com.ankamagames.jerakine.data.I18n;

    public class NpcAction implements IDataCenter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcAction));
        public static const MODULE:String = "NpcActions";

        public var id:int;
        public var realId:int;
        public var nameId:uint;
        private var _name:String;


        public static function getNpcActionById(id:int):NpcAction
        {
            return ((GameData.getObject(MODULE, id) as NpcAction));
        }

        public static function getNpcActions():Array
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
}//package com.ankamagames.dofus.datacenter.npcs

