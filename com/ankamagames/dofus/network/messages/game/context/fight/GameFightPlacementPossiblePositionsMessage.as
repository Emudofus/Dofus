package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightPlacementPossiblePositionsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightPlacementPossiblePositionsMessage() {
         this.positionsForChallengers = new Vector.<uint>();
         this.positionsForDefenders = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 703;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var positionsForChallengers:Vector.<uint>;
      
      public var positionsForDefenders:Vector.<uint>;
      
      public var teamNumber:uint = 2;
      
      override public function getMessageId() : uint {
         return 703;
      }
      
      public function initGameFightPlacementPossiblePositionsMessage(positionsForChallengers:Vector.<uint>=null, positionsForDefenders:Vector.<uint>=null, teamNumber:uint=2) : GameFightPlacementPossiblePositionsMessage {
         this.positionsForChallengers = positionsForChallengers;
         this.positionsForDefenders = positionsForDefenders;
         this.teamNumber = teamNumber;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.positionsForChallengers = new Vector.<uint>();
         this.positionsForDefenders = new Vector.<uint>();
         this.teamNumber = 2;
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
         this.serializeAs_GameFightPlacementPossiblePositionsMessage(output);
      }
      
      public function serializeAs_GameFightPlacementPossiblePositionsMessage(output:IDataOutput) : void {
         output.writeShort(this.positionsForChallengers.length);
         var _i1:uint = 0;
         while(_i1 < this.positionsForChallengers.length)
         {
            if((this.positionsForChallengers[_i1] < 0) || (this.positionsForChallengers[_i1] > 559))
            {
               throw new Error("Forbidden value (" + this.positionsForChallengers[_i1] + ") on element 1 (starting at 1) of positionsForChallengers.");
            }
            else
            {
               output.writeShort(this.positionsForChallengers[_i1]);
               _i1++;
               continue;
            }
         }
         output.writeShort(this.positionsForDefenders.length);
         var _i2:uint = 0;
         while(_i2 < this.positionsForDefenders.length)
         {
            if((this.positionsForDefenders[_i2] < 0) || (this.positionsForDefenders[_i2] > 559))
            {
               throw new Error("Forbidden value (" + this.positionsForDefenders[_i2] + ") on element 2 (starting at 1) of positionsForDefenders.");
            }
            else
            {
               output.writeShort(this.positionsForDefenders[_i2]);
               _i2++;
               continue;
            }
         }
         output.writeByte(this.teamNumber);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightPlacementPossiblePositionsMessage(input);
      }
      
      public function deserializeAs_GameFightPlacementPossiblePositionsMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         var _val2:uint = 0;
         var _positionsForChallengersLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _positionsForChallengersLen)
         {
            _val1 = input.readShort();
            if((_val1 < 0) || (_val1 > 559))
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of positionsForChallengers.");
            }
            else
            {
               this.positionsForChallengers.push(_val1);
               _i1++;
               continue;
            }
         }
         var _positionsForDefendersLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _positionsForDefendersLen)
         {
            _val2 = input.readShort();
            if((_val2 < 0) || (_val2 > 559))
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of positionsForDefenders.");
            }
            else
            {
               this.positionsForDefenders.push(_val2);
               _i2++;
               continue;
            }
         }
         this.teamNumber = input.readByte();
         if(this.teamNumber < 0)
         {
            throw new Error("Forbidden value (" + this.teamNumber + ") on element of GameFightPlacementPossiblePositionsMessage.teamNumber.");
         }
         else
         {
            return;
         }
      }
   }
}
