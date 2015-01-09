package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GetComicRequestAction implements Action 
    {

        public var remoteId:String;
        public var language:String;
        public var previewOnly:Boolean;


        public static function create(pRemoteId:String, pLanguage:String, pPreviewOnly:Boolean):GetComicRequestAction
        {
            var gcra:GetComicRequestAction = new (GetComicRequestAction)();
            gcra.remoteId = pRemoteId;
            gcra.language = pLanguage;
            gcra.previewOnly = pPreviewOnly;
            return (gcra);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.externalGame

