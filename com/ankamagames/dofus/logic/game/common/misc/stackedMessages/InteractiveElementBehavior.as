package com.ankamagames.dofus.logic.game.common.misc.stackedMessages
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.dofus.datacenter.interactives.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.logic.game.roleplay.messages.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.dofus.network.messages.game.interactive.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;

    public class InteractiveElementBehavior extends AbstractBehavior
    {
        public var interactiveElement:InteractiveElement;
        public var currentSkillInstanceId:int;
        private var _tmpInteractiveElementId:int;
        private var _isMoving:Boolean;
        private var _time:int = 1000;
        private var _startTime:int = 0;
        private var _timeOutRecolte:int = 0;
        private var _duration:int;
        private var _lastCellExpected:int = -1;
        private var _isFreeMovement:Boolean = false;
        private static var interactiveElements:Array = new Array();
        private static var currentElementId:int = -1;
        private static const FILTER_1:GlowFilter = new GlowFilter(16777215, 0.8, 6, 6, 4);
        private static const FILTER_2:GlowFilter = new GlowFilter(2845168, 0.8, 4, 4, 2);

        public function InteractiveElementBehavior()
        {
            this._startTime = 0;
            this._timeOutRecolte = 0;
            type = ALWAYS;
            isAvailableToStart = false;
            this._isMoving = false;
            return;
        }// end function

        override public function processInputMessage(param1:Message, param2:String) : Boolean
        {
            var _loc_5:InteractiveElementActivationMessage = null;
            var _loc_6:Interactive = null;
            var _loc_7:InteractiveElementUpdatedMessage = null;
            canBeStacked = true;
            var _loc_3:* = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            var _loc_4:Boolean = false;
            if (param1 is MouseClickMessage)
            {
                this._isFreeMovement = !((param1 as MouseClickMessage).target is SpriteWrapper);
                return false;
            }
            switch(_loc_6.actionId)
            {
                case 3:
                case 15:
                {
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            if (param2 == ALWAYS)
            {
            }
            if (param1 is GameMapMovementMessage && (param1 as GameMapMovementMessage).actorId == PlayedCharacterManager.getInstance().id && (param1 as GameMapMovementMessage).keyMovements[0] == _loc_3.position.cellId)
            {
                if (this._isFreeMovement)
                {
                }
                else
                {
                }
            }
            else if (param1 is CharacterMovementStoppedMessage)
            {
            }
            else if (param2 == ALWAYS && param1 is CellClickMessage && this._isMoving)
            {
            }
            else if (param1 is InteractiveElementUpdatedMessage)
            {
                if (_loc_7.interactiveElement.enabledSkills.length)
                {
                }
                else if (_loc_7.interactiveElement.disabledSkills.length && interactiveElements[_loc_7.interactiveElement.elementId])
                {
                }
            }
            return _loc_4;
        }// end function

        override public function checkAvailability(param1:Message) : void
        {
            if (this._startTime != 0 && getTimer() >= this._startTime + this._time)
            {
                isAvailableToStart = false;
                this._startTime = 0;
            }
            if (PlayedCharacterManager.getInstance().isFighting)
            {
                this._startTime = 0;
                isAvailableToStart = false;
            }
            else if (param1 is InteractiveUsedMessage && (param1 as InteractiveUsedMessage).entityId == PlayedCharacterManager.getInstance().id)
            {
                isAvailableToStart = true;
                this._tmpInteractiveElementId = (param1 as InteractiveUsedMessage).elemId;
                this._startTime = 0;
            }
            else if (param1 is InteractiveUseEndedMessage && this._tmpInteractiveElementId == (param1 as InteractiveUseEndedMessage).elemId)
            {
                this._startTime = getTimer();
            }
            return;
        }// end function

        override public function processOutputMessage(param1:Message, param2:String) : Boolean
        {
            var _loc_4:int = 0;
            var _loc_5:IEntity = null;
            var _loc_3:Boolean = false;
            if (param1 is InteractiveUseEndedMessage)
            {
                this.stopAction();
                _loc_3 = true;
            }
            else if (param1 is InteractiveUsedMessage && (param1 as InteractiveUsedMessage).entityId == PlayedCharacterManager.getInstance().id)
            {
                this.removeIcon();
                this._duration = (param1 as InteractiveUsedMessage).duration * 100;
                this._timeOutRecolte = getTimer();
                actionStarted = true;
                _loc_3 = this._duration == 0;
            }
            else if (this._timeOutRecolte > 0 && getTimer() > this._timeOutRecolte + this._duration + 1000)
            {
                this.stopAction();
                _loc_3 = true;
            }
            else if (param1 is CharacterMovementStoppedMessage)
            {
                _loc_4 = PlayedCharacterManager.getInstance().currentWeapon == null ? (0) : (PlayedCharacterManager.getInstance().currentWeapon.range);
                _loc_5 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                if (_loc_5 && _loc_5.position.distanceTo(position) > _loc_4)
                {
                    this.stopAction();
                    _loc_3 = true;
                    actionStarted = true;
                    _log.debug("Distance: " + _loc_5.position.distanceTo(position) + " > " + _loc_4);
                }
            }
            return _loc_3;
        }// end function

        private function stopAction() : void
        {
            actionStarted = false;
            InteractiveElementBehavior.currentElementId = -1;
            this.removeIcon();
            return;
        }// end function

        override public function isAvailableToProcess(param1:Message) : Boolean
        {
            if (interactiveElements[this.interactiveElement.elementId])
            {
                return true;
            }
            return false;
        }// end function

        override public function addIcon() : void
        {
            var _loc_1:int = 0;
            var _loc_2:InteractiveElementSkill = null;
            var _loc_3:Skill = null;
            var _loc_4:InteractiveObject = null;
            if (this.interactiveElement == null)
            {
                return;
            }
            for each (_loc_2 in this.interactiveElement.enabledSkills)
            {
                
                if (_loc_2.skillInstanceUid == this.currentSkillInstanceId)
                {
                    _loc_1 = _loc_2.skillId;
                    break;
                }
            }
            _loc_3 = Skill.getSkillById(_loc_1);
            sprite = RoleplayInteractivesFrame.getCursor(_loc_3.cursor, true, false);
            sprite.y = sprite.y - sprite.height;
            sprite.x = sprite.x - sprite.width / 2;
            sprite.transform.colorTransform = new ColorTransform(0.33, 0.33, 0.33, 0.5, 0, 0, 0, 0);
            _loc_4 = Atouin.getInstance().getIdentifiedElement(this.interactiveElement.elementId);
            FiltersManager.getInstance().addEffect(_loc_4, FILTER_1);
            FiltersManager.getInstance().addEffect(_loc_4, FILTER_2);
            super.addIcon();
            return;
        }// end function

        override public function removeIcon() : void
        {
            if (this.interactiveElement == null)
            {
                return;
            }
            var _loc_1:* = Atouin.getInstance().getIdentifiedElement(this.interactiveElement.elementId);
            if (_loc_1)
            {
                FiltersManager.getInstance().removeEffect(_loc_1, FILTER_1);
                FiltersManager.getInstance().removeEffect(_loc_1, FILTER_2);
            }
            super.removeIcon();
            return;
        }// end function

        override public function remove() : void
        {
            InteractiveElementBehavior.currentElementId = -1;
            super.remove();
            return;
        }// end function

        override public function copy() : AbstractBehavior
        {
            var _loc_1:* = new InteractiveElementBehavior();
            _loc_1.pendingMessage = this.pendingMessage;
            _loc_1.interactiveElement = this.interactiveElement;
            _loc_1.position = this.position;
            _loc_1.sprite = this.sprite;
            _loc_1.currentSkillInstanceId = this.currentSkillInstanceId;
            _loc_1.isAvailableToStart = this.isAvailableToStart;
            _loc_1.type = this.type;
            return _loc_1;
        }// end function

        override public function isMessageCatchable(param1:Message) : Boolean
        {
            if (param1 is GameMapMovementMessage)
            {
                return !(this._isMoving || actionStarted);
            }
            return true;
        }// end function

        override public function get canBeRemoved() : Boolean
        {
            return this.interactiveElement.elementId != InteractiveElementBehavior.currentElementId;
        }// end function

        override public function get needToWait() : Boolean
        {
            return this._isMoving && this._lastCellExpected != -1;
        }// end function

        override public function getFakePosition() : MapPoint
        {
            var _loc_1:* = new MapPoint();
            _loc_1.cellId = this._lastCellExpected;
            return _loc_1;
        }// end function

    }
}
