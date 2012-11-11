package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.types.*;
    import flash.display.*;

    public class FightAddSubEntityStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _carriedEntityId:int;
        private var _category:uint;
        private var _slot:uint;
        private var _subEntityBehaviour:ISubEntityBehavior;

        public function FightAddSubEntityStep(param1:int, param2:int, param3:uint, param4:uint, param5:ISubEntityBehavior = null)
        {
            this._fighterId = param1;
            this._carriedEntityId = param2;
            this._category = param3;
            this._slot = param4;
            this._subEntityBehaviour = param5;
            return;
        }// end function

        public function get stepType() : String
        {
            return "addSubEntity";
        }// end function

        override public function start() : void
        {
            var _loc_1:* = DofusEntities.getEntity(this._fighterId);
            var _loc_2:* = DofusEntities.getEntity(this._carriedEntityId);
            var _loc_3:* = TiphonUtility.getEntityWithoutMount(_loc_1 as TiphonSprite) as TiphonSprite;
            if (_loc_2 && _loc_3 && _loc_3 is TiphonSprite)
            {
                if (this._subEntityBehaviour)
                {
                    _loc_3.setSubEntityBehaviour(this._category, this._subEntityBehaviour);
                }
                _loc_3.addSubEntity(DisplayObject(_loc_2), this._category, this._slot);
                if (_loc_3.getTmpSubEntitiesNb() > 0 && !_loc_3.libraryIsAvaible)
                {
                    _loc_3.addEventListener(TiphonEvent.SPRITE_INIT, this.forceRender);
                }
            }
            else
            {
                _log.warn("Unable to add a subentity to fighter " + this._fighterId + ", non-existing or not a sprite.");
            }
            if (_loc_1 is IMovable)
            {
                IMovable(_loc_1).movementBehavior.synchroniseSubEntitiesPosition(IMovable(_loc_1));
            }
            executeCallbacks();
            return;
        }// end function

        private function forceRender(event:TiphonEvent) : void
        {
            if ((event.currentTarget as TiphonSprite).hasEventListener(TiphonEvent.SPRITE_INIT))
            {
                (event.currentTarget as TiphonSprite).removeEventListener(TiphonEvent.SPRITE_INIT, this.forceRender);
                if ((event.currentTarget as TiphonSprite).getTmpSubEntitiesNb() > 0)
                {
                    (event.currentTarget as TiphonSprite).forceRender();
                }
            }
            return;
        }// end function

    }
}
