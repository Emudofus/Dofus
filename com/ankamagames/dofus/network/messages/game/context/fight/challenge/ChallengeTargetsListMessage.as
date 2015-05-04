package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ChallengeTargetsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChallengeTargetsListMessage()
      {
         this.targetIds = new Vector.<int>();
         this.targetCells = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 5613;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var targetIds:Vector.<int>;
      
      public var targetCells:Vector.<int>;
      
      override public function getMessageId() : uint
      {
         return 5613;
      }
      
      public function initChallengeTargetsListMessage(param1:Vector.<int> = null, param2:Vector.<int> = null) : ChallengeTargetsListMessage
      {
         this.targetIds = param1;
         this.targetCells = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.targetIds = new Vector.<int>();
         this.targetCells = new Vector.<int>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ChallengeTargetsListMessage(param1);
      }
      
      public function serializeAs_ChallengeTargetsListMessage(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.targetIds.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.targetIds.length)
         {
            param1.writeInt(this.targetIds[_loc2_]);
            _loc2_++;
         }
         param1.writeShort(this.targetCells.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.targetCells.length)
         {
            if(this.targetCells[_loc3_] < -1 || this.targetCells[_loc3_] > 559)
            {
               throw new Error("Forbidden value (" + this.targetCells[_loc3_] + ") on element 2 (starting at 1) of targetCells.");
            }
            else
            {
               param1.writeShort(this.targetCells[_loc3_]);
               _loc3_++;
               continue;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeTargetsListMessage(param1);
      }
      
      public function deserializeAs_ChallengeTargetsListMessage(param1:ICustomDataInput) : void
      {
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = param1.readInt();
            this.targetIds.push(_loc6_);
            _loc3_++;
         }
         var _loc4_:uint = param1.readUnsignedShort();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = param1.readShort();
            if(_loc7_ < -1 || _loc7_ > 559)
            {
               throw new Error("Forbidden value (" + _loc7_ + ") on elements of targetCells.");
            }
            else
            {
               this.targetCells.push(_loc7_);
               _loc5_++;
               continue;
            }
         }
      }
   }
}
