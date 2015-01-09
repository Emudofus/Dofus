package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.IdentifiedEntityDispositionInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GameFightPlacementSwapPositionsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6544;

        private var _isInitialized:Boolean = false;
        public var dispositions:Vector.<IdentifiedEntityDispositionInformations>;

        public function GameFightPlacementSwapPositionsMessage()
        {
            this.dispositions = new Vector.<IdentifiedEntityDispositionInformations>(2, true);
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6544);
        }

        public function initGameFightPlacementSwapPositionsMessage(dispositions:Vector.<IdentifiedEntityDispositionInformations>=null):GameFightPlacementSwapPositionsMessage
        {
            this.dispositions = dispositions;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.dispositions = new Vector.<IdentifiedEntityDispositionInformations>(2, true);
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
            this.serializeAs_GameFightPlacementSwapPositionsMessage(output);
        }

        public function serializeAs_GameFightPlacementSwapPositionsMessage(output:ICustomDataOutput):void
        {
            var _i1:uint;
            while (_i1 < 2)
            {
                this.dispositions[_i1].serializeAs_IdentifiedEntityDispositionInformations(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightPlacementSwapPositionsMessage(input);
        }

        public function deserializeAs_GameFightPlacementSwapPositionsMessage(input:ICustomDataInput):void
        {
            var _i1:uint;
            while (_i1 < 2)
            {
                this.dispositions[_i1] = new IdentifiedEntityDispositionInformations();
                this.dispositions[_i1].deserialize(input);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

