package com.ankamagames.dofus.misc.utils
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.misc.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class DofusApiAction extends ApiAction
    {
        private var _description:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(DofusApiAction));
        private static var _actionList:Vector.<DofusApiAction> = new Vector.<DofusApiAction>;

        public function DofusApiAction(param1:String, param2:Class)
        {
            _actionList.push(this);
            super(param1, param2, true, false, 0, 0, false);
            return;
        }// end function

        public function get description() : String
        {
            return this._description;
        }// end function

        public static function updateInfo() : void
        {
            var _loc_1:DofusApiAction = null;
            var _loc_2:ActionDescription = null;
            for each (_loc_1 in _actionList)
            {
                
                _loc_2 = ActionDescription.getActionDescriptionByName(_loc_1.name);
                if (_loc_2)
                {
                    _loc_1._trusted = _loc_2.trusted;
                    _loc_1._needInteraction = _loc_2.needInteraction;
                    _loc_1._maxUsePerFrame = _loc_2.maxUsePerFrame;
                    _loc_1._minimalUseInterval = _loc_2.minimalUseInterval;
                    _loc_1._needConfirmation = _loc_2.needConfirmation;
                    _loc_1._description = _loc_2.description;
                    continue;
                }
                _log.warn("No data for Action \'" + _loc_1.name + "\'");
            }
            return;
        }// end function

        public static function getApiActionByName(param1:String) : DofusApiAction
        {
            return _apiActionNameList[param1];
        }// end function

        public static function getApiActionsList() : Array
        {
            return _apiActionNameList;
        }// end function

    }
}
