﻿package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AbstractGameActionFightTargetedAbilityMessage extends AbstractGameActionMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6118;

        private var _isInitialized:Boolean = false;
        public var targetId:int = 0;
        public var destinationCellId:int = 0;
        public var critical:uint = 1;
        public var silentCast:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6118);
        }

        public function initAbstractGameActionFightTargetedAbilityMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, destinationCellId:int=0, critical:uint=1, silentCast:Boolean=false):AbstractGameActionFightTargetedAbilityMessage
        {
            super.initAbstractGameActionMessage(actionId, sourceId);
            this.targetId = targetId;
            this.destinationCellId = destinationCellId;
            this.critical = critical;
            this.silentCast = silentCast;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.targetId = 0;
            this.destinationCellId = 0;
            this.critical = 1;
            this.silentCast = false;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_AbstractGameActionFightTargetedAbilityMessage(output);
        }

        public function serializeAs_AbstractGameActionFightTargetedAbilityMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractGameActionMessage(output);
            output.writeInt(this.targetId);
            if ((((this.destinationCellId < -1)) || ((this.destinationCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.destinationCellId) + ") on element destinationCellId.")));
            };
            output.writeShort(this.destinationCellId);
            output.writeByte(this.critical);
            output.writeBoolean(this.silentCast);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AbstractGameActionFightTargetedAbilityMessage(input);
        }

        public function deserializeAs_AbstractGameActionFightTargetedAbilityMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.targetId = input.readInt();
            this.destinationCellId = input.readShort();
            if ((((this.destinationCellId < -1)) || ((this.destinationCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.destinationCellId) + ") on element of AbstractGameActionFightTargetedAbilityMessage.destinationCellId.")));
            };
            this.critical = input.readByte();
            if (this.critical < 0)
            {
                throw (new Error((("Forbidden value (" + this.critical) + ") on element of AbstractGameActionFightTargetedAbilityMessage.critical.")));
            };
            this.silentCast = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.fight

