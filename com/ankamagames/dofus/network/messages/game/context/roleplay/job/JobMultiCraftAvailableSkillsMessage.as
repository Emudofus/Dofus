package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class JobMultiCraftAvailableSkillsMessage extends JobAllowMultiCraftRequestMessage implements INetworkMessage
   {
      
      public function JobMultiCraftAvailableSkillsMessage()
      {
         this.skills = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 5747;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var playerId:uint = 0;
      
      public var skills:Vector.<uint>;
      
      override public function getMessageId() : uint
      {
         return 5747;
      }
      
      public function initJobMultiCraftAvailableSkillsMessage(param1:Boolean = false, param2:uint = 0, param3:Vector.<uint> = null) : JobMultiCraftAvailableSkillsMessage
      {
         super.initJobAllowMultiCraftRequestMessage(param1);
         this.playerId = param2;
         this.skills = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.playerId = 0;
         this.skills = new Vector.<uint>();
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
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_JobMultiCraftAvailableSkillsMessage(param1);
      }
      
      public function serializeAs_JobMultiCraftAvailableSkillsMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_JobAllowMultiCraftRequestMessage(param1);
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            param1.writeVarInt(this.playerId);
            param1.writeShort(this.skills.length);
            var _loc2_:uint = 0;
            while(_loc2_ < this.skills.length)
            {
               if(this.skills[_loc2_] < 0)
               {
                  throw new Error("Forbidden value (" + this.skills[_loc2_] + ") on element 2 (starting at 1) of skills.");
               }
               else
               {
                  param1.writeVarShort(this.skills[_loc2_]);
                  _loc2_++;
                  continue;
               }
            }
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_JobMultiCraftAvailableSkillsMessage(param1);
      }
      
      public function deserializeAs_JobMultiCraftAvailableSkillsMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:uint = 0;
         super.deserialize(param1);
         this.playerId = param1.readVarUhInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of JobMultiCraftAvailableSkillsMessage.playerId.");
         }
         else
         {
            var _loc2_:uint = param1.readUnsignedShort();
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = param1.readVarUhShort();
               if(_loc4_ < 0)
               {
                  throw new Error("Forbidden value (" + _loc4_ + ") on elements of skills.");
               }
               else
               {
                  this.skills.push(_loc4_);
                  _loc3_++;
                  continue;
               }
            }
            return;
         }
      }
   }
}
