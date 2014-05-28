package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MapObstacleUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MapObstacleUpdateMessage() {
         this.obstacles = new Vector.<MapObstacle>();
         super();
      }
      
      public static const protocolId:uint = 6051;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var obstacles:Vector.<MapObstacle>;
      
      override public function getMessageId() : uint {
         return 6051;
      }
      
      public function initMapObstacleUpdateMessage(obstacles:Vector.<MapObstacle> = null) : MapObstacleUpdateMessage {
         this.obstacles = obstacles;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.obstacles = new Vector.<MapObstacle>();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_MapObstacleUpdateMessage(output);
      }
      
      public function serializeAs_MapObstacleUpdateMessage(output:IDataOutput) : void {
         output.writeShort(this.obstacles.length);
         var _i1:uint = 0;
         while(_i1 < this.obstacles.length)
         {
            (this.obstacles[_i1] as MapObstacle).serializeAs_MapObstacle(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MapObstacleUpdateMessage(input);
      }
      
      public function deserializeAs_MapObstacleUpdateMessage(input:IDataInput) : void {
         var _item1:MapObstacle = null;
         var _obstaclesLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _obstaclesLen)
         {
            _item1 = new MapObstacle();
            _item1.deserialize(input);
            this.obstacles.push(_item1);
            _i1++;
         }
      }
   }
}
