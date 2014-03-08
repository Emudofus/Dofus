package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
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
      
      public function initMapObstacleUpdateMessage(param1:Vector.<MapObstacle>=null) : MapObstacleUpdateMessage {
         this.obstacles = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.obstacles = new Vector.<MapObstacle>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_MapObstacleUpdateMessage(param1);
      }
      
      public function serializeAs_MapObstacleUpdateMessage(param1:IDataOutput) : void {
         param1.writeShort(this.obstacles.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.obstacles.length)
         {
            (this.obstacles[_loc2_] as MapObstacle).serializeAs_MapObstacle(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MapObstacleUpdateMessage(param1);
      }
      
      public function deserializeAs_MapObstacleUpdateMessage(param1:IDataInput) : void {
         var _loc4_:MapObstacle = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new MapObstacle();
            _loc4_.deserialize(param1);
            this.obstacles.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
