package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ShowCellSpectatorMessage extends ShowCellMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6158;

        private var _isInitialized:Boolean = false;
        public var playerName:String = "";


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6158);
        }

        public function initShowCellSpectatorMessage(sourceId:int=0, cellId:uint=0, playerName:String=""):ShowCellSpectatorMessage
        {
            super.initShowCellMessage(sourceId, cellId);
            this.playerName = playerName;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.playerName = "";
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
            this.serializeAs_ShowCellSpectatorMessage(output);
        }

        public function serializeAs_ShowCellSpectatorMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ShowCellMessage(output);
            output.writeUTF(this.playerName);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ShowCellSpectatorMessage(input);
        }

        public function deserializeAs_ShowCellSpectatorMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.playerName = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context

