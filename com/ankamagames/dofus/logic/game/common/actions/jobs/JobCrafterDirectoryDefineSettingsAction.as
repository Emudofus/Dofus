package com.ankamagames.dofus.logic.game.common.actions.jobs
{
    import com.ankamagames.dofus.internalDatacenter.jobs.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.*;
    import com.ankamagames.jerakine.handlers.messages.*;

    public class JobCrafterDirectoryDefineSettingsAction extends Object implements Action
    {
        public var jobId:uint;
        public var minSlot:uint;
        public var notFree:Boolean;
        public var notFreeExceptOnFail:Boolean;
        public var resourcesRequired:Boolean;
        public var settings:JobCrafterDirectorySettings;

        public function JobCrafterDirectoryDefineSettingsAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:Boolean, param4:Boolean, param5:Boolean) : JobCrafterDirectoryDefineSettingsAction
        {
            var _loc_9:KnownJob = null;
            var _loc_6:* = new JobCrafterDirectoryDefineSettingsAction;
            new JobCrafterDirectoryDefineSettingsAction.jobId = param1;
            _loc_6.minSlot = param2;
            _loc_6.notFree = param3;
            _loc_6.notFreeExceptOnFail = param4;
            _loc_6.resourcesRequired = param5;
            _loc_6.settings = new JobCrafterDirectorySettings();
            var _loc_7:* = PlayedCharacterManager.getInstance().jobs;
            var _loc_8:uint = 0;
            while (_loc_8 < _loc_7.length)
            {
                
                _loc_9 = _loc_7[_loc_8];
                if (_loc_9 && _loc_9.jobDescription.jobId == param1)
                {
                    _loc_6.settings.initJobCrafterDirectorySettings(_loc_8, param2, (param3 ? (CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE) : (CrafterDirectoryParamBitEnum.CRAFT_OPTION_NONE)) + (param4 ? (CrafterDirectoryParamBitEnum.CRAFT_OPTION_NOT_FREE_EXCEPT_ON_FAIL) : (CrafterDirectoryParamBitEnum.CRAFT_OPTION_NONE)) + (param5 ? (CrafterDirectoryParamBitEnum.CRAFT_OPTION_RESOURCES_REQUIRED) : (CrafterDirectoryParamBitEnum.CRAFT_OPTION_NONE)));
                }
                _loc_8 = _loc_8 + 1;
            }
            return _loc_6;
        }// end function

    }
}
