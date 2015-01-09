package com.ankamagames.dofus.network.messages.game.achievement
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AchievementFinishedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6208;

        private var _isInitialized:Boolean = false;
        public var id:uint = 0;
        public var finishedlevel:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6208);
        }

        public function initAchievementFinishedMessage(id:uint=0, finishedlevel:uint=0):AchievementFinishedMessage
        {
            this.id = id;
            this.finishedlevel = finishedlevel;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.id = 0;
            this.finishedlevel = 0;
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
            this.serializeAs_AchievementFinishedMessage(output);
        }

        public function serializeAs_AchievementFinishedMessage(output:ICustomDataOutput):void
        {
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element id.")));
            };
            output.writeVarShort(this.id);
            if ((((this.finishedlevel < 0)) || ((this.finishedlevel > 200))))
            {
                throw (new Error((("Forbidden value (" + this.finishedlevel) + ") on element finishedlevel.")));
            };
            output.writeByte(this.finishedlevel);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AchievementFinishedMessage(input);
        }

        public function deserializeAs_AchievementFinishedMessage(input:ICustomDataInput):void
        {
            this.id = input.readVarUhShort();
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element of AchievementFinishedMessage.id.")));
            };
            this.finishedlevel = input.readUnsignedByte();
            if ((((this.finishedlevel < 0)) || ((this.finishedlevel > 200))))
            {
                throw (new Error((("Forbidden value (" + this.finishedlevel) + ") on element of AchievementFinishedMessage.finishedlevel.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.achievement

