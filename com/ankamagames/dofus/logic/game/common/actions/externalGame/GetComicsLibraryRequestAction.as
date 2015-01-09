package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GetComicsLibraryRequestAction implements Action 
    {

        public var accountId:String;


        public static function create(pAccountId:String):GetComicsLibraryRequestAction
        {
            var gclra:GetComicsLibraryRequestAction = new (GetComicsLibraryRequestAction)();
            gclra.accountId = pAccountId;
            return (gclra);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.externalGame

