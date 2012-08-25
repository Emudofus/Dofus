package com.ankamagames.atouin.entities.behaviours.movements
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.errors.*;
    import com.ankamagames.jerakine.entities.behaviours.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class AnimatedMovementBehavior extends Object implements IMovementBehavior
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AnimatedMovementBehavior));
        static var _movingCount:uint;
        static var _aEntitiesMoving:Array = new Array();
        private static var _stoppingEntity:Dictionary = new Dictionary(true);
        private static var _enterFrameRegistered:Boolean;
        private static var _cellsManager:InteractiveCellManager = InteractiveCellManager.getInstance();

        public function AnimatedMovementBehavior()
        {
            return;
        }// end function

        public function move(param1:IMovable, param2:MovementPath, param3:Function = null) : void
        {
            var _loc_4:* = new TweenEntityData();
            new TweenEntityData().path = param2;
            _loc_4.entity = param1;
            if (this.getAnimation())
            {
                _loc_4.animation = this.getAnimation();
            }
            _loc_4.linearVelocity = this.getLinearVelocity();
            _loc_4.hDiagVelocity = this.getHorizontalDiagonalVelocity();
            _loc_4.vDiagVelocity = this.getVerticalDiagonalVelocity();
            _loc_4.callback = param3;
            this.initMovement(param1, _loc_4);
            Atouin.getInstance().handler.process(new EntityMovementStartMessage(param1));
            return;
        }// end function

        public function synchroniseSubEntitiesPosition(param1:IMovable, param2:DisplayObject = null) : void
        {
            var _loc_3:TiphonSprite = null;
            var _loc_4:Array = null;
            var _loc_5:* = undefined;
            var _loc_6:Array = null;
            var _loc_7:* = undefined;
            if (param1 is TiphonSprite)
            {
                _loc_3 = param1 as TiphonSprite;
                if (param2 && param2 is TiphonSprite)
                {
                    _loc_3 = TiphonSprite(param2);
                }
                _loc_4 = _loc_3.getSubEntitiesList();
                for each (_loc_5 in _loc_4)
                {
                    
                    if (_loc_5 is IMovable)
                    {
                        if (_loc_5.position && param1.position)
                        {
                            _loc_5.position.x = param1.position.x;
                            _loc_5.position.y = param1.position.y;
                        }
                        if (_loc_5.movementBehavior && _loc_5 != param1)
                        {
                            _loc_5.movementBehavior.synchroniseSubEntitiesPosition(_loc_5);
                        }
                        continue;
                    }
                    if (_loc_5 is TiphonSprite)
                    {
                        _loc_6 = TiphonSprite(_loc_5).getSubEntitiesList();
                        for each (_loc_7 in _loc_6)
                        {
                            
                            if (_loc_7 is IMovable && _loc_7.movementBehavior && _loc_7 != param1)
                            {
                                IMovable(_loc_7).movementBehavior.synchroniseSubEntitiesPosition(param1, _loc_5);
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        public function jump(param1:IMovable, param2:MapPoint) : void
        {
            this.processJump(param1, param2);
            return;
        }// end function

        public function stop(param1:IMovable, param2:Boolean = false) : void
        {
            if (param2)
            {
                _aEntitiesMoving[param1.id] = null;
                delete _aEntitiesMoving[param1.id];
            }
            else
            {
                _stoppingEntity[param1] = true;
            }
            return;
        }// end function

        public function isMoving(param1:IMovable) : Boolean
        {
            return _aEntitiesMoving[param1.id] != null;
        }// end function

        public function getNextCell(param1:IMovable) : MapPoint
        {
            return _aEntitiesMoving[param1.id] != null ? (TweenEntityData(_aEntitiesMoving[param1.id]).nextCell) : (null);
        }// end function

        protected function getLinearVelocity() : Number
        {
            throw new AtouinError("Abstract function call.");
        }// end function

        protected function getHorizontalDiagonalVelocity() : Number
        {
            throw new AtouinError("Abstract function call.");
        }// end function

        protected function getVerticalDiagonalVelocity() : Number
        {
            throw new AtouinError("Abstract function call.");
        }// end function

        protected function getAnimation() : String
        {
            throw new AtouinError("Abstract function call.");
        }// end function

        protected function mustChangeOrientation() : Boolean
        {
            return true;
        }// end function

        protected function initMovement(param1:IMovable, param2:TweenEntityData, param3:Boolean = false) : void
        {
            var _loc_4:PathElement = null;
            if (_aEntitiesMoving[param1.id] != null)
            {
                _log.warn("Moving an already moving entity. Replacing the previous move.");
                var _loc_6:* = _movingCount - 1;
                _movingCount = _loc_6;
            }
            _aEntitiesMoving[param1.id] = param2;
            var _loc_6:* = _movingCount + 1;
            _movingCount = _loc_6;
            if (!param3)
            {
                _loc_4 = param2.path.path.shift();
                if (_loc_4)
                {
                    param2.orientation = _loc_4.orientation;
                }
                if (this.mustChangeOrientation() && _loc_4)
                {
                    IAnimated(param1).setAnimationAndDirection(param2.animation, _loc_4.orientation);
                }
                else
                {
                    IAnimated(param1).setAnimation(param2.animation);
                }
            }
            this.goNextCell(param1);
            this.checkIfEnterFrameNeeded();
            return;
        }// end function

        protected function goNextCell(param1:IMovable) : void
        {
            var _loc_3:PathElement = null;
            var _loc_2:* = _aEntitiesMoving[param1.id];
            _loc_2.currentCell = param1.position;
            if (_stoppingEntity[param1])
            {
                this.stopMovement(param1);
                Atouin.getInstance().handler.process(new EntityMovementStoppedMessage(param1));
                delete _stoppingEntity[param1];
                return;
            }
            if (_loc_2.path.path.length > 0)
            {
                _loc_3 = _loc_2.path.path.shift() as PathElement;
                if (this.mustChangeOrientation())
                {
                    IAnimated(param1).setAnimationAndDirection(_loc_2.animation, _loc_2.orientation);
                }
                else
                {
                    IAnimated(param1).setAnimation(_loc_2.animation);
                }
                _loc_2.velocity = this.getVelocity(_loc_2, _loc_2.orientation);
                _loc_2.nextCell = _loc_3.step;
                _loc_2.orientation = _loc_3.orientation;
                _loc_2.start = getTimer();
            }
            else if (!_loc_2.currentCell.equals(_loc_2.path.end))
            {
                _loc_2.velocity = this.getVelocity(_loc_2, IAnimated(param1).getDirection());
                if (this.mustChangeOrientation())
                {
                    IAnimated(param1).setDirection(_loc_2.orientation);
                }
                _loc_2.nextCell = _loc_2.path.end;
                _loc_2.start = getTimer();
            }
            else
            {
                this.stopMovement(param1);
                Atouin.getInstance().handler.process(new EntityMovementCompleteMessage(param1));
            }
            _loc_2.barycentre = 0;
            return;
        }// end function

        protected function stopMovement(param1:IMovable) : void
        {
            IAnimated(param1).setAnimation("AnimStatique");
            var _loc_2:* = (_aEntitiesMoving[param1.id] as TweenEntityData).callback;
            delete _aEntitiesMoving[param1.id];
            var _loc_4:* = _movingCount - 1;
            _movingCount = _loc_4;
            this.checkIfEnterFrameNeeded();
            if (_loc_2 != null)
            {
                this._loc_2();
            }
            return;
        }// end function

        private function getVelocity(param1:TweenEntityData, param2:uint) : Number
        {
            if (param2 % 2 == 0)
            {
                if (param2 % 4 == 0)
                {
                    return param1.hDiagVelocity;
                }
                return param1.vDiagVelocity;
            }
            else
            {
                return param1.linearVelocity;
            }
        }// end function

        protected function processMovement(param1:TweenEntityData, param2:uint) : void
        {
            var _loc_4:ISoundPositionListener = null;
            var _loc_5:Point = null;
            param1.barycentre = param1.velocity * (param2 - param1.start);
            if (param1.barycentre > 1)
            {
                param1.barycentre = 1;
            }
            if (!param1.currentCellSprite)
            {
                param1.currentCellSprite = _cellsManager.getCell(param1.currentCell.cellId);
                param1.nextCellSprite = _cellsManager.getCell(param1.nextCell.cellId);
            }
            var _loc_3:* = DisplayObject(param1.entity);
            _loc_3.x = (1 - param1.barycentre) * param1.currentCellSprite.x + param1.barycentre * param1.nextCellSprite.x + param1.currentCellSprite.width / 2;
            _loc_3.y = (1 - param1.barycentre) * param1.currentCellSprite.y + param1.barycentre * param1.nextCellSprite.y + param1.currentCellSprite.height / 2;
            for each (_loc_4 in Atouin.getInstance().movementListeners)
            {
                
                _loc_5 = new Point(_loc_3.x, _loc_3.y);
                _loc_4.setSoundSourcePosition(param1.entity.id, _loc_5);
            }
            if (!param1.wasOrdered && param1.barycentre > 0.5)
            {
                EntitiesDisplayManager.getInstance().orderEntity(_loc_3, param1.nextCellSprite);
            }
            if (param1.barycentre >= 1)
            {
                param1.clear();
                IEntity(param1.entity).position = param1.nextCell;
                this.synchroniseSubEntitiesPosition(IMovable(param1.entity));
                this.goNextCell(IMovable(param1.entity));
            }
            return;
        }// end function

        protected function processJump(param1:IMovable, param2:MapPoint) : void
        {
            var _loc_3:* = InteractiveCellManager.getInstance().getCell(param2.cellId);
            var _loc_4:* = param1 as DisplayObject;
            (param1 as DisplayObject).x = _loc_3.x + _loc_3.width / 2;
            _loc_4.y = _loc_3.y + _loc_3.height / 2;
            if (_loc_4.stage != null)
            {
                EntitiesDisplayManager.getInstance().orderEntity(_loc_4, _loc_3);
            }
            param1.position = param2;
            this.synchroniseSubEntitiesPosition(param1);
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            var _loc_3:TweenEntityData = null;
            var _loc_2:* = getTimer();
            for each (_loc_3 in _aEntitiesMoving)
            {
                
                this.processMovement(_loc_3, _loc_2);
            }
            return;
        }// end function

        protected function checkIfEnterFrameNeeded() : void
        {
            if (_movingCount == 0 && _enterFrameRegistered)
            {
                EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
                _enterFrameRegistered = false;
            }
            else if (_movingCount > 0 && !_enterFrameRegistered)
            {
                EnterFrameDispatcher.addEventListener(this.onEnterFrame, "AnimatedMovementBehaviour", 50);
                _enterFrameRegistered = true;
            }
            return;
        }// end function

    }
}
