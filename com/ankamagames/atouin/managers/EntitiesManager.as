package com.ankamagames.atouin.managers
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.tiphon.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class EntitiesManager extends Object
    {
        private var _entities:Array;
        private var _currentRandomEntity:uint = 1000000;
        private static const RANDOM_ENTITIES_ID_START:uint = 1000000;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EntitiesManager));
        private static var _self:EntitiesManager;

        public function EntitiesManager()
        {
            if (_self)
            {
                throw new SingletonError("Warning : MobilesManager is a singleton class and shoulnd\'t be instancied directly!");
            }
            this._entities = new Array();
            Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            return;
        }// end function

        public function initManager() : void
        {
            Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            return;
        }// end function

        public function addAnimatedEntity(param1:int, param2:IEntity, param3:uint) : void
        {
            if (this._entities[param1] != null)
            {
                _log.warn("Entity overwriting! Entity " + param1 + " has been replaced.");
            }
            this._entities[param1] = param2;
            if (param2 is IDisplayable)
            {
                EntitiesDisplayManager.getInstance().displayEntity(param2 as IDisplayable, param2.position, param3);
            }
            if (param2 is IInteractive)
            {
                this.registerInteractions(IInteractive(param2), true);
                Sprite(param2).buttonMode = IInteractive(param2).useHandCursor;
            }
            return;
        }// end function

        public function getEntity(param1:int) : IEntity
        {
            return this._entities[param1];
        }// end function

        public function getEntityID(param1:IEntity) : int
        {
            var _loc_2:* = null;
            for (_loc_2 in this._entities)
            {
                
                if (param1 === this._entities[_loc_2])
                {
                    return parseInt(_loc_2);
                }
            }
            return 0;
        }// end function

        public function removeEntity(param1:int) : void
        {
            if (this._entities[param1])
            {
                if (this._entities[param1] is IDisplayable)
                {
                    EntitiesDisplayManager.getInstance().removeEntity(this._entities[param1] as IDisplayable);
                }
                if (this._entities[param1] is IInteractive)
                {
                    this.registerInteractions(IInteractive(this._entities[param1]), false);
                }
                if (this._entities[param1] is IMovable && IMovable(this._entities[param1]).isMoving)
                {
                    IMovable(this._entities[param1]).stop(true);
                }
                delete this._entities[param1];
            }
            return;
        }// end function

        public function clearEntities() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_1:* = new Array();
            for (_loc_2 in this._entities)
            {
                
                _loc_1.push(_loc_2);
            }
            _loc_3 = -1;
            _loc_4 = _loc_1.length;
            while (++_loc_3 < _loc_4)
            {
                
                _loc_5 = _loc_1[_loc_3];
                _loc_6 = this._entities[_loc_5] as TiphonSprite;
                this.removeEntity(_loc_5);
                if (_loc_6)
                {
                    _loc_6.destroy();
                }
            }
            this._entities = new Array();
            return;
        }// end function

        public function get entities() : Array
        {
            return this._entities;
        }// end function

        public function getFreeEntityId() : int
        {
            do
            {
                
                var _loc_1:* = this;
                var _loc_2:* = this._currentRandomEntity + 1;
                _loc_1._currentRandomEntity = _loc_2;
                var _loc_1:* = this;
                _loc_1._currentRandomEntity = this._currentRandomEntity + 1;
            }while (this._entities[++this._currentRandomEntity] != null)
            return this._currentRandomEntity;
        }// end function

        private function registerInteractions(param1:IInteractive, param2:Boolean) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = param1.enabledInteractions;
            while (_loc_4 > 0)
            {
                
                this.registerInteraction(param1, 1 << _loc_3++, param2);
                _loc_4 = _loc_4 >> 1;
            }
            return;
        }// end function

        public function registerInteraction(param1:IInteractive, param2:uint, param3:Boolean) : void
        {
            var _loc_5:* = null;
            var _loc_4:* = InteractionsEnum.getEvents(param2);
            for each (_loc_5 in _loc_4)
            {
                
                if (param3 && !param1.hasEventListener(_loc_5))
                {
                    param1.addEventListener(_loc_5, this.onInteraction, false, 0, true);
                    continue;
                }
                if (!param3 && param1.hasEventListener(_loc_5))
                {
                    param1.removeEventListener(_loc_5, this.onInteraction, false);
                }
            }
            return;
        }// end function

        public function getEntityOnCell(param1:uint, param2 = null) : IEntity
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_3:* = param2 != null;
            var _loc_4:* = _loc_3 && param2 is Array;
            for each (_loc_5 in this._entities)
            {
                
                if (_loc_5 && _loc_5.position && _loc_5.position.cellId == param1)
                {
                    if (!_loc_4)
                    {
                        if (!_loc_3 || !_loc_4 && _loc_5 is param2)
                        {
                            return _loc_5;
                        }
                        continue;
                    }
                    _loc_6 = 0;
                    while (_loc_6 < (param2 as Array).length)
                    {
                        
                        if (_loc_5 is param2[_loc_6])
                        {
                            return _loc_5;
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                }
            }
            return null;
        }// end function

        public function getEntitiesOnCell(param1:uint, param2 = null) : Array
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_3:* = param2 != null;
            var _loc_4:* = _loc_3 && param2 is Array;
            var _loc_5:* = [];
            for each (_loc_6 in this._entities)
            {
                
                if (_loc_6 && _loc_6.position && _loc_6.position.cellId == param1)
                {
                    if (!_loc_4)
                    {
                        if (!_loc_3 || !_loc_4 && _loc_6 is param2)
                        {
                            _loc_5.push(_loc_6);
                        }
                        continue;
                    }
                    _loc_7 = 0;
                    while (_loc_7 < (param2 as Array).length)
                    {
                        
                        if (_loc_6 is param2[_loc_7])
                        {
                            _loc_5.push(_loc_6);
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                }
            }
            return _loc_5;
        }// end function

        private function onInteraction(event:Event) : void
        {
            var _loc_2:* = IInteractive(event.target);
            var _loc_3:* = InteractionsEnum.getMessage(event.type);
            _loc_2.handler.process(new _loc_3(_loc_2));
            return;
        }// end function

        private function onPropertyChanged(event:PropertyChangeEvent) : void
        {
            var _loc_2:* = null;
            if (event.propertyName == "transparentOverlayMode")
            {
                for each (_loc_2 in this._entities)
                {
                    
                    if (_loc_2 is IDisplayable)
                    {
                        EntitiesDisplayManager.getInstance().refreshAlphaEntity(_loc_2 as IDisplayable, _loc_2.position);
                    }
                }
            }
            return;
        }// end function

        public static function getInstance() : EntitiesManager
        {
            if (!_self)
            {
                _self = new EntitiesManager;
            }
            return _self;
        }// end function

    }
}
