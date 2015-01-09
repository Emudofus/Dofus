package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameRolePlayPlayerFightRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5731;

        private var _isInitialized:Boolean = false;
        public var targetId:uint = 0;
        public var targetCellId:int = 0;
        public var friendly:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5731);
        }

        public function initGameRolePlayPlayerFightRequestMessage(targetId:uint=0, targetCellId:int=0, friendly:Boolean=false):GameRolePlayPlayerFightRequestMessage
        {
            this.targetId = targetId;
            this.targetCellId = targetCellId;
            this.friendly = friendly;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.targetId = 0;
            this.targetCellId = 0;
            this.friendly = false;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            if (HASH_FUNCTION != null)
            {
                HASH_FUNCTION(data);
            };
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameRolePlayPlayerFightRequestMessage(output);
        }

        public function serializeAs_GameRolePlayPlayerFightRequestMessage(output:ICustomDataOutput):void
        {
            if (this.targetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.targetId) + ") on element targetId.")));
            };
            output.writeVarInt(this.targetId);
            if ((((this.targetCellId < -1)) || ((this.targetCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.targetCellId) + ") on element targetCellId.")));
            };
            output.writeShort(this.targetCellId);
            output.writeBoolean(this.friendly);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayPlayerFightRequestMessage(input);
        }

        public function deserializeAs_GameRolePlayPlayerFightRequestMessage(input:ICustomDataInput):void
        {
            this.targetId = input.readVarUhInt();
            if (this.targetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.targetId) + ") on element of GameRolePlayPlayerFightRequestMessage.targetId.")));
            };
            this.targetCellId = input.readShort();
            if ((((this.targetCellId < -1)) || ((this.targetCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.targetCellId) + ") on element of GameRolePlayPlayerFightRequestMessage.targetCellId.")));
            };
            this.friendly = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.fight

