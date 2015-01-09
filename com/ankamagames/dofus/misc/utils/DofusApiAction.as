package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.berilia.types.data.ApiAction;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.misc.ActionDescription;
    import __AS3__.vec.*;

    public class DofusApiAction extends ApiAction 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DofusApiAction));
        private static var _actionList:Vector.<DofusApiAction> = new Vector.<DofusApiAction>();

        private var _description:String;

        public function DofusApiAction(name:String, actionClass:Class)
        {
            _actionList.push(this);
            super(name, actionClass, true, false, 0, 0, false);
        }

        public static function updateInfo():void
        {
            var action:DofusApiAction;
            var actiondesc:ActionDescription;
            for each (action in _actionList)
            {
                actiondesc = ActionDescription.getActionDescriptionByName(action.name);
                if (actiondesc)
                {
                    action._trusted = actiondesc.trusted;
                    action._needInteraction = actiondesc.needInteraction;
                    action._maxUsePerFrame = actiondesc.maxUsePerFrame;
                    action._minimalUseInterval = actiondesc.minimalUseInterval;
                    action._needConfirmation = actiondesc.needConfirmation;
                    action._description = actiondesc.description;
                }
                else
                {
                    _log.warn((("No data for Action '" + action.name) + "'"));
                };
            };
        }

        public static function getApiActionByName(name:String):DofusApiAction
        {
            return (_apiActionNameList[name]);
        }

        public static function getApiActionsList():Array
        {
            return (_apiActionNameList);
        }


        public function get description():String
        {
            return (this._description);
        }


    }
}//package com.ankamagames.dofus.misc.utils

