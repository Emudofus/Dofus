package com.ankamagames.dofus.modules.utils.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ModuleDeleteRequestAction implements Action 
    {

        public var moduleDirectory:String;


        public static function create(directoryName:String):ModuleDeleteRequestAction
        {
            var action:ModuleDeleteRequestAction = new (ModuleDeleteRequestAction)();
            action.moduleDirectory = directoryName;
            return (action);
        }


    }
}//package com.ankamagames.dofus.modules.utils.actions

