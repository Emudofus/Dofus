package com.ankamagames.dofus.datacenter.quest
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class QuestObjectiveType extends Object implements IDataCenter
    {
        public var id:uint;
        public var nameId:uint;
        private var _name:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(QuestObjectiveType));
        private static const MODULE:String = "QuestObjectiveTypes";

        public function QuestObjectiveType()
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

        public static function getQuestObjectiveTypeById(param1:int) : QuestObjectiveType
        {
            return GameData.getObject(MODULE, param1) as QuestObjectiveType;
        }// end function

        public static function getQuestObjectiveTypes() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
