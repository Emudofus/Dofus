package com.ankamagames.dofus.network.messages.game.almanach
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AlmanachCalendarDateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6341;

        private var _isInitialized:Boolean = false;
        public var date:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6341);
        }

        public function initAlmanachCalendarDateMessage(date:int=0):AlmanachCalendarDateMessage
        {
            this.date = date;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.date = 0;
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
            this.serializeAs_AlmanachCalendarDateMessage(output);
        }

        public function serializeAs_AlmanachCalendarDateMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.date);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AlmanachCalendarDateMessage(input);
        }

        public function deserializeAs_AlmanachCalendarDateMessage(input:ICustomDataInput):void
        {
            this.date = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.almanach

