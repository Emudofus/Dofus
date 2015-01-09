package com.ankamagames.dofus.modules.utils.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ModuleInstallCancelAction implements Action 
    {


        public static function create():ModuleInstallCancelAction
        {
            var action:ModuleInstallCancelAction = new (ModuleInstallCancelAction)();
            return (action);
        }


    }
}//package com.ankamagames.dofus.modules.utils.actions

