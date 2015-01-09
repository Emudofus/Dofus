package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GameActionFightSpellCastMessage extends AbstractGameActionFightTargetedAbilityMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 1010;

        private var _isInitialized:Boolean = false;
        public var spellId:uint = 0;
        public var spellLevel:uint = 0;
        public var portalsIds:Vector.<int>;

        public function GameActionFightSpellCastMessage()
        {
            this.portalsIds = new Vector.<int>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (1010);
        }

        public function initGameActionFightSpellCastMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, destinationCellId:int=0, critical:uint=1, silentCast:Boolean=false, spellId:uint=0, spellLevel:uint=0, portalsIds:Vector.<int>=null):GameActionFightSpellCastMessage
        {
            super.initAbstractGameActionFightTargetedAbilityMessage(actionId, sourceId, targetId, destinationCellId, critical, silentCast);
            this.spellId = spellId;
            this.spellLevel = spellLevel;
            this.portalsIds = portalsIds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.spellId = 0;
            this.spellLevel = 0;
            this.portalsIds = new Vector.<int>();
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
            this.serializeAs_GameActionFightSpellCastMessage(output);
        }

        public function serializeAs_GameActionFightSpellCastMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractGameActionFightTargetedAbilityMessage(output);
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element spellId.")));
            };
            output.writeVarShort(this.spellId);
            if ((((this.spellLevel < 1)) || ((this.spellLevel > 6))))
            {
                throw (new Error((("Forbidden value (" + this.spellLevel) + ") on element spellLevel.")));
            };
            output.writeByte(this.spellLevel);
            output.writeShort(this.portalsIds.length);
            var _i3:uint;
            while (_i3 < this.portalsIds.length)
            {
                output.writeShort(this.portalsIds[_i3]);
                _i3++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionFightSpellCastMessage(input);
        }

        public function deserializeAs_GameActionFightSpellCastMessage(input:ICustomDataInput):void
        {
            var _val3:int;
            super.deserialize(input);
            this.spellId = input.readVarUhShort();
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element of GameActionFightSpellCastMessage.spellId.")));
            };
            this.spellLevel = input.readByte();
            if ((((this.spellLevel < 1)) || ((this.spellLevel > 6))))
            {
                throw (new Error((("Forbidden value (" + this.spellLevel) + ") on element of GameActionFightSpellCastMessage.spellLevel.")));
            };
            var _portalsIdsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _portalsIdsLen)
            {
                _val3 = input.readShort();
                this.portalsIds.push(_val3);
                _i3++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.fight

