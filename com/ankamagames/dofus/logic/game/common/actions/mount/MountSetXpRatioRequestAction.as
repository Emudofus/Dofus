package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class MountSetXpRatioRequestAction implements Action 
    {

        public var xpRatio:uint;


        public static function create(xpRatio:uint):MountSetXpRatioRequestAction
        {
            var o:MountSetXpRatioRequestAction = new (MountSetXpRatioRequestAction)();
            o.xpRatio = xpRatio;
            return (o);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.mount

