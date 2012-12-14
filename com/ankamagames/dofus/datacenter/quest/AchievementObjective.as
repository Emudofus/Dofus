package com.ankamagames.dofus.datacenter.quest
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class AchievementObjective extends Object implements IDataCenter
    {
        public var id:uint;
        public var achievementId:uint;
        public var nameId:uint;
        public var criterion:String;
        private var _name:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AchievementObjective));
        private static const MODULE:String = "AchievementObjectives";

        public function AchievementObjective()
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

        public static function getAchievementObjectiveById(param1:int) : AchievementObjective
        {
            return GameData.getObject(MODULE, param1) as AchievementObjective;
        }// end function

        public static function getAchievementObjectives() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
