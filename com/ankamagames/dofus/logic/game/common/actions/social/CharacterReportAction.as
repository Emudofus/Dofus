﻿package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class CharacterReportAction implements Action 
    {

        public var reportedId:uint;
        public var reason:uint;


        public static function create(reportedId:uint, reason:uint):CharacterReportAction
        {
            var a:CharacterReportAction = new (CharacterReportAction)();
            a.reportedId = reportedId;
            a.reason = reason;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

