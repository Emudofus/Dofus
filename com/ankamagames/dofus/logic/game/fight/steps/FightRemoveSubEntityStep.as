﻿package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.tiphon.display.TiphonSprite;

    public class FightRemoveSubEntityStep extends AbstractSequencable implements IFightStep 
    {

        private var _fighterId:int;
        private var _category:uint;
        private var _slot:uint;

        public function FightRemoveSubEntityStep(fighterId:int, category:uint, slot:uint)
        {
            this._fighterId = fighterId;
            this._category = category;
            this._slot = slot;
        }

        public function get stepType():String
        {
            return ("removeSubEntity");
        }

        override public function start():void
        {
            var parentEntity:IEntity = DofusEntities.getEntity(this._fighterId);
            if (((parentEntity) && ((parentEntity is TiphonSprite))))
            {
                (parentEntity as TiphonSprite).look.removeSubEntity(this._category, this._slot);
            }
            else
            {
                _log.warn((("Unable to remove a subentity from fighter " + this._fighterId) + ", non-existing or not a sprite."));
            };
            executeCallbacks();
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.steps

