package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
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
      
      public function initGameMapMovementMessage(keyMovements:Vector.<uint>=null, actorId:int=0) : GameMapMovementMessage {
         this.keyMovements = keyMovements;
         this.actorId = actorId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.keyMovements = new Vector.<uint>();
         this.actorId = 0;
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
         this.serializeAs_GameMapMovementMessage(output);
      }
      
      public function serializeAs_GameMapMovementMessage(output:IDataOutput) : void {
         output.writeShort(this.keyMovements.length);
         var _i1:uint = 0;
         while(_i1 < this.keyMovements.length)
         {
            if(this.keyMovements[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.keyMovements[_i1] + ") on element 1 (starting at 1) of keyMovements.");
            }
            else
            {
               output.writeShort(this.keyMovements[_i1]);
               _i1++;
               continue;
            }
         }
         output.writeInt(this.actorId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameMapMovementMessage(input);
      }
      
      public function deserializeAs_GameMapMovementMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         var _keyMovementsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _keyMovementsLen)
         {
            _val1 = input.readShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of keyMovements.");
            }
            else
            {
               this.keyMovements.push(_val1);
               _i1++;
               continue;
            }
         }
         this.actorId = input.readInt();
      }
   }
}
