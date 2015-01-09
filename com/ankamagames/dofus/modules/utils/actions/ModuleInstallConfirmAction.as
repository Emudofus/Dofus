package com.ankamagames.dofus.modules.utils.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ModuleInstallConfirmAction implements Action 
    {

        public var isUpdate:Boolean;


        public static function create(update:Boolean=false):ModuleInstallConfirmAction
        {
            var action:ModuleInstallConfirmAction = new (ModuleInstallConfirmAction)();
            action.isUpdate = update;
            return (action);
        }


    }
}//package com.ankamagames.dofus.modules.utils.actions

