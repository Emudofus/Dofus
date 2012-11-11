package com.ankamagames.dofus.logic.game.common.misc.stackedMessages
{
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.logic.game.roleplay.messages.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.entities.messages.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.positions.*;

    public class MoveBehavior extends AbstractBehavior
    {
        private var _abstractEntitiesFrame:AbstractEntitiesFrame;
        private var _fakepos:int = -1;

        public function MoveBehavior()
        {
            type = NORMAL;
            sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP", false);
            isAvailableToStart = true;
            return;
        }// end function

        override public function processInputMessage(param1:Message, param2:String) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            canBeStacked = false;
            if (this._abstractEntitiesFrame == null)
            {
                this._abstractEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            }
            if ((param1 is CellClickMessage || param1 is EntityClickMessage) && !PlayedCharacterManager.getInstance().isFighting && param2 == type)
            {
                _loc_3 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                if (param1 is CellClickMessage)
                {
                    _loc_4 = (param1 as CellClickMessage).cellId;
                }
                else if (param1 is EntityClickMessage && this._abstractEntitiesFrame.getEntityInfos((param1 as EntityClickMessage).entity.id) is GameRolePlayGroupMonsterInformations)
                {
                    _loc_4 = (param1 as EntityClickMessage).entity.position.cellId;
                }
                else
                {
                    return false;
                }
                if (_loc_3 != null && _loc_3.position.cellId != _loc_4)
                {
                    pendingMessage = param1;
                    canBeStacked = true;
                    isAvailableToStart = true;
                    if (param1 is CellClickMessage)
                    {
                        position = (param1 as CellClickMessage).cell;
                    }
                    else if (param1 is EntityClickMessage)
                    {
                        position = (param1 as EntityClickMessage).entity.position;
                    }
                    return true;
                }
            }
            else if (param1 is CellClickMessage && !PlayedCharacterManager.getInstance().isFighting && param2 == ALWAYS)
            {
                this._fakepos = (param1 as CellClickMessage).cellId;
                return true;
            }
            return false;
        }// end function

        override public function processOutputMessage(param1:Message, param2:String) : Boolean
        {
            var _loc_3:* = null;
            if (param1 is CellClickMessage && param2 == ALWAYS)
            {
                isAvailableToStart = false;
            }
            else if (param1 is CharacterMovementStoppedMessage || param1 is EntityMovementStoppedMessage)
            {
                this._fakepos = -1;
                _loc_3 = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
                if (_loc_3 != null && _loc_3.position.cellId == position.cellId)
                {
                    this._fakepos = -1;
                    actionStarted = true;
                    return true;
                }
                this._fakepos = _loc_3.position.cellId;
            }
            return false;
        }// end function

        override public function checkAvailability(param1:Message) : void
        {
            if (PlayedCharacterManager.getInstance().isFighting)
            {
                isAvailableToStart = false;
            }
            else
            {
                isAvailableToStart = true;
            }
            return;
        }// end function

        override public function copy() : AbstractBehavior
        {
            var _loc_1:* = new MoveBehavior();
            _loc_1.pendingMessage = this.pendingMessage;
            _loc_1.position = this.position;
            _loc_1.type = this.type;
            return _loc_1;
        }// end function

        override public function get needToWait() : Boolean
        {
            return this._fakepos != -1;
        }// end function

        override public function getFakePosition() : MapPoint
        {
            var _loc_1:* = new MapPoint();
            _loc_1.cellId = this._fakepos;
            return _loc_1;
        }// end function

    }
}
