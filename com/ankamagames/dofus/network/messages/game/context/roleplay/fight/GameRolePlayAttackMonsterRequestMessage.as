package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameRolePlayAttackMonsterRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6191;

        private var _isInitialized:Boolean = false;
        public var monsterGroupId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6191);
        }

        public function initGameRolePlayAttackMonsterRequestMessage(monsterGroupId:int=0):GameRolePlayAttackMonsterRequestMessage
        {
            this.monsterGroupId = monsterGroupId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.monsterGroupId = 0;
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

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameRolePlayAttackMonsterRequestMessage(output);
        }

        public function serializeAs_GameRolePlayAttackMonsterRequestMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.monsterGroupId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayAttackMonsterRequestMessage(input);
        }

        public function deserializeAs_GameRolePlayAttackMonsterRequestMessage(input:ICustomDataInput):void
        {
            this.monsterGroupId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.fight

