package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChallengeTargetsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChallengeTargetsListMessage() {
         this.targetIds = new Vector.<int>();
         this.targetCells = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 5613;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var targetIds:Vector.<int>;
      
      public var targetCells:Vector.<int>;
      
      override public function getMessageId() : uint {
         return 5613;
      }
      
      public function initChallengeTargetsListMessage(targetIds:Vector.<int>=null, targetCells:Vector.<int>=null) : ChallengeTargetsListMessage {
         this.targetIds = targetIds;
         this.targetCells = targetCells;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.targetIds = new Vector.<int>();
         this.targetCells = new Vector.<int>();
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
         this.serializeAs_ChallengeTargetsListMessage(output);
      }
      
      public function serializeAs_ChallengeTargetsListMessage(output:IDataOutput) : void {
         output.writeShort(this.targetIds.length);
         var _i1:uint = 0;
         while(_i1 < this.targetIds.length)
         {
            output.writeInt(this.targetIds[_i1]);
            _i1++;
         }
         output.writeShort(this.targetCells.length);
         var _i2:uint = 0;
         while(_i2 < this.targetCells.length)
         {
            if((this.targetCells[_i2] < -1) || (this.targetCells[_i2] > 559))
            {
               throw new Error("Forbidden value (" + this.targetCells[_i2] + ") on element 2 (starting at 1) of targetCells.");
            }
            else
            {
               output.writeShort(this.targetCells[_i2]);
               _i2++;
               continue;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChallengeTargetsListMessage(input);
      }
      
      public function deserializeAs_ChallengeTargetsListMessage(input:IDataInput) : void {
         var _val1:* = 0;
         var _val2:* = 0;
         var _targetIdsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _targetIdsLen)
         {
            _val1 = input.readInt();
            this.targetIds.push(_val1);
            _i1++;
         }
         var _targetCellsLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _targetCellsLen)
         {
            _val2 = input.readShort();
            if((_val2 < -1) || (_val2 > 559))
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of targetCells.");
            }
            else
            {
               this.targetCells.push(_val2);
               _i2++;
               continue;
            }
         }
      }
   }
}
