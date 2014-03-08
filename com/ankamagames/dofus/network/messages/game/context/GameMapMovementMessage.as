package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameMapMovementMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameMapMovementMessage() {
         this.keyMovements = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 951;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var keyMovements:Vector.<uint>;
      
      public var actorId:int = 0;
      
      override public function getMessageId() : uint {
         return 951;
      }
      
      public function initGameMapMovementMessage(param1:Vector.<uint>=null, param2:int=0) : GameMapMovementMessage {
         this.keyMovements = param1;
         this.actorId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.keyMovements = new Vector.<uint>();
         this.actorId = 0;
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
         this.serializeAs_GameMapMovementMessage(param1);
      }
      
      public function serializeAs_GameMapMovementMessage(param1:IDataOutput) : void {
         param1.writeShort(this.keyMovements.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.keyMovements.length)
         {
            if(this.keyMovements[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.keyMovements[_loc2_] + ") on element 1 (starting at 1) of keyMovements.");
            }
            else
            {
               param1.writeShort(this.keyMovements[_loc2_]);
               _loc2_++;
               continue;
            }
         }
         param1.writeInt(this.actorId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameMapMovementMessage(param1);
      }
      
      public function deserializeAs_GameMapMovementMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readShort();
            if(_loc4_ < 0)
            {
               throw new Error("Forbidden value (" + _loc4_ + ") on elements of keyMovements.");
            }
            else
            {
               this.keyMovements.push(_loc4_);
               _loc3_++;
               continue;
            }
         }
         this.actorId = param1.readInt();
      }
   }
}
