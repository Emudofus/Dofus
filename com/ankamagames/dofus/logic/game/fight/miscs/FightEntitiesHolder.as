package com.ankamagames.dofus.logic.game.fight.miscs
{
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.tiphon.display.*;
    import flash.utils.*;

    public class FightEntitiesHolder extends Object implements IEntityLocalizer
    {
        private var _holdedEntities:Dictionary;
        private static var _self:FightEntitiesHolder;

        public function FightEntitiesHolder()
        {
            this._holdedEntities = new Dictionary();
            return;
        }// end function

        public function getEntity(param1:int) : IEntity
        {
            return this._holdedEntities[param1];
        }// end function

        public function holdEntity(param1:IEntity) : void
        {
            this._holdedEntities[param1.id] = param1;
            return;
        }// end function

        public function unholdEntity(param1:int) : void
        {
            delete this._holdedEntities[param1];
            return;
        }// end function

        public function reset() : void
        {
            this._holdedEntities = new Dictionary();
            return;
        }// end function

        public function getEntities() : Dictionary
        {
            return this._holdedEntities;
        }// end function

        public function unregistered() : void
        {
            var _loc_1:IEntity = null;
            for each (_loc_1 in this._holdedEntities)
            {
                
                if (_loc_1 is IDisplayable)
                {
                    (_loc_1 as IDisplayable).remove();
                }
                if (_loc_1 is TiphonSprite)
                {
                    (_loc_1 as TiphonSprite).destroy();
                }
            }
            this._holdedEntities = null;
            _self = null;
            return;
        }// end function

        public static function getInstance() : FightEntitiesHolder
        {
            if (!_self)
            {
                _self = new FightEntitiesHolder;
                DofusEntities.registerLocalizer(_self);
            }
            return _self;
        }// end function

    }
}
