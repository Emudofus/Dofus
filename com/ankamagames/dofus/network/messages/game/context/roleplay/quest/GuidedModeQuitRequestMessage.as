package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuidedModeQuitRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6092;


        override public function get isInitialized():Boolean
        {
            return (true);
        }

        override public function getMessageId():uint
        {
            return (6092);
        }

        public function initGuidedModeQuitRequestMessage():GuidedModeQuitRequestMessage
        {
            return (this);
        }

        override public function reset():void
        {
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
        }

        public function serializeAs_GuidedModeQuitRequestMessage(output:ICustomDataOutput):void
        {
        }

        public function deserialize(input:ICustomDataInput):void
        {
        }

        public function deserializeAs_GuidedModeQuitRequestMessage(input:ICustomDataInput):void
        {
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.quest

