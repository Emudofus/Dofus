package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class StatsUpgradeRequestAction implements Action 
    {

        public var useAdditionnal:Boolean;
        public var statId:uint;
        public var boostPoint:uint;


        public static function create(useAdditionnal:Boolean, statId:uint, boostPoint:uint):StatsUpgradeRequestAction
        {
            var a:StatsUpgradeRequestAction = new (StatsUpgradeRequestAction)();
            a.useAdditionnal = useAdditionnal;
            a.statId = statId;
            a.boostPoint = boostPoint;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions

