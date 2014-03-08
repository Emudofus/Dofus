package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayArenaFightPropositionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayArenaFightPropositionMessage() {
         this.alliesId = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6276;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:uint = 0;
      
      public var alliesId:Vector.<uint>;
      
      public var duration:uint = 0;
      
      override public function getMessageId() : uint {
         return 6276;
      }
      
      public function initGameRolePlayArenaFightPropositionMessage(fightId:uint=0, alliesId:Vector.<uint>=null, duration:uint=0) : GameRolePlayArenaFightPropositionMessage {
         this.fightId = fightId;
         this.alliesId = alliesId;
         this.duration = duration;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.alliesId = new Vector.<uint>();
         this.duration = 0;
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
         this.serializeAs_GameRolePlayArenaFightPropositionMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaFightPropositionMessage(output:IDataOutput) : void {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            output.writeInt(this.fightId);
            output.writeShort(this.alliesId.length);
            _i2 = 0;
            while(_i2 < this.alliesId.length)
            {
               if(this.alliesId[_i2] < 0)
               {
                  throw new Error("Forbidden value (" + this.alliesId[_i2] + ") on element 2 (starting at 1) of alliesId.");
               }
               else
               {
                  output.writeInt(this.alliesId[_i2]);
                  _i2++;
                  continue;
               }
            }
            if(this.duration < 0)
            {
               throw new Error("Forbidden value (" + this.duration + ") on element duration.");
            }
            else
            {
               output.writeShort(this.duration);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayArenaFightPropositionMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaFightPropositionMessage(input:IDataInput) : void {
         var _val2:uint = 0;
         this.fightId = input.readInt();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameRolePlayArenaFightPropositionMessage.fightId.");
         }
         else
         {
            _alliesIdLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _alliesIdLen)
            {
               _val2 = input.readInt();
               if(_val2 < 0)
               {
                  throw new Error("Forbidden value (" + _val2 + ") on elements of alliesId.");
               }
               else
               {
                  this.alliesId.push(_val2);
                  _i2++;
                  continue;
               }
            }
            this.duration = input.readShort();
            if(this.duration < 0)
            {
               throw new Error("Forbidden value (" + this.duration + ") on element of GameRolePlayArenaFightPropositionMessage.duration.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
