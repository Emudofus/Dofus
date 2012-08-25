package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MapObstacleUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var obstacles:Vector.<MapObstacle>;
        public static const protocolId:uint = 6051;

        public function MapObstacleUpdateMessage()
        {
            this.obstacles = new Vector.<MapObstacle>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6051;
        }// end function

        public function initMapObstacleUpdateMessage(param1:Vector.<MapObstacle> = null) : MapObstacleUpdateMessage
        {
            this.obstacles = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.obstacles = new Vector.<MapObstacle>;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_MapObstacleUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_MapObstacleUpdateMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.obstacles.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.obstacles.length)
            {
                
                (this.obstacles[_loc_2] as MapObstacle).serializeAs_MapObstacle(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MapObstacleUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_MapObstacleUpdateMessage(param1:IDataInput) : void
        {
            var _loc_4:MapObstacle = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new MapObstacle();
                _loc_4.deserialize(param1);
                this.obstacles.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
