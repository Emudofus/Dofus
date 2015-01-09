package com.ankamagames.dofus.network.messages.game.achievement
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AchievementFinishedInformationMessage extends AchievementFinishedMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6381;

        private var _isInitialized:Boolean = false;
        public var name:String = "";
        public var playerId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6381);
        }

        public function initAchievementFinishedInformationMessage(id:uint=0, finishedlevel:uint=0, name:String="", playerId:uint=0):AchievementFinishedInformationMessage
        {
            super.initAchievementFinishedMessage(id, finishedlevel);
            this.name = name;
            this.playerId = playerId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.name = "";
            this.playerId = 0;
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
            this.serializeAs_AchievementFinishedInformationMessage(output);
        }

        public function serializeAs_AchievementFinishedInformationMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AchievementFinishedMessage(output);
            output.writeUTF(this.name);
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AchievementFinishedInformationMessage(input);
        }

        public function deserializeAs_AchievementFinishedInformationMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.name = input.readUTF();
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of AchievementFinishedInformationMessage.playerId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.achievement

