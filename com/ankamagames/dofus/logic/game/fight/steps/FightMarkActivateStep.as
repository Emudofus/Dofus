package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.types.entities.Glyph;
    import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
    import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
    import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
    import com.ankamagames.dofus.types.enums.PortalAnimationEnum;

    public class FightMarkActivateStep extends AbstractSequencable implements IFightStep 
    {

        private var _markId:int;
        private var _activate:Boolean;

        public function FightMarkActivateStep(markId:int, activate:Boolean)
        {
            this._markId = markId;
            this._activate = activate;
        }

        public function get stepType():String
        {
            return ("markActivate");
        }

        override public function start():void
        {
            var glyph:Glyph;
            var mark:MarkInstance = MarkedCellsManager.getInstance().getMarkDatas(this._markId);
            if (mark)
            {
                mark.active = this._activate;
                glyph = MarkedCellsManager.getInstance().getGlyph(mark.markId);
                if (glyph)
                {
                    if (mark.markType == GameActionMarkTypeEnum.PORTAL)
                    {
                        glyph.setAnimation(((this._activate) ? PortalAnimationEnum.STATE_NORMAL : PortalAnimationEnum.STATE_DISABLED));
                    };
                };
            };
            executeCallbacks();
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.steps

