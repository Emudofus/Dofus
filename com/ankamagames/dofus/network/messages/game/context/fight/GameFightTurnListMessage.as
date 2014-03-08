package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightTurnListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightTurnListMessage() {
         this.ids = new Vector.<int>();
         this.deadsIds = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 713;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var ids:Vector.<int>;
      
      public var deadsIds:Vector.<int>;
      
      override public function getMessageId() : uint {
         return 713;
      }
      
      public function initGameFightTurnListMessage(param1:Vector.<int>=null, param2:Vector.<int>=null) : GameFightTurnListMessage {
         this.ids = param1;
         this.deadsIds = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.ids = new Vector.<int>();
         this.deadsIds = new Vector.<int>();
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
         this.serializeAs_GameFightTurnListMessage(param1);
      }
      
      public function serializeAs_GameFightTurnListMessage(param1:IDataOutput) : void {
         param1.writeShort(this.ids.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.ids.length)
         {
            param1.writeInt(this.ids[_loc2_]);
            _loc2_++;
         }
         param1.writeShort(this.deadsIds.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.deadsIds.length)
         {
            param1.writeInt(this.deadsIds[_loc3_]);
            _loc3_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightTurnListMessage(param1);
      }
      
      public function deserializeAs_GameFightTurnListMessage(param1:IDataInput) : void {
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = param1.readInt();
            this.ids.push(_loc6_);
            _loc3_++;
         }
         var _loc4_:uint = param1.readUnsignedShort();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = param1.readInt();
            this.deadsIds.push(_loc7_);
            _loc5_++;
         }
      }
   }
}
