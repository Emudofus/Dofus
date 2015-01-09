package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class OpenMapAction implements Action 
    {

        public var conquest:Boolean;
        public var pocket:Boolean;
        public var ignoreSetting:Boolean;


        public static function create(ignoreSetting:Boolean=false, pocket:Boolean=true, conquest:Boolean=false):OpenMapAction
        {
            var a:OpenMapAction = new (OpenMapAction)();
            a.ignoreSetting = ignoreSetting;
            a.pocket = pocket;
            a.conquest = conquest;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

