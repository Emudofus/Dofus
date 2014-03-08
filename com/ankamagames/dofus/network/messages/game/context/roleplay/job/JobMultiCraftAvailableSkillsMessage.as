package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class JobMultiCraftAvailableSkillsMessage extends JobAllowMultiCraftRequestMessage implements INetworkMessage
   {
      
      public function JobMultiCraftAvailableSkillsMessage() {
         this.skills = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 5747;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var playerId:uint = 0;
      
      public var skills:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 5747;
      }
      
      public function initJobMultiCraftAvailableSkillsMessage(enabled:Boolean=false, playerId:uint=0, skills:Vector.<uint>=null) : JobMultiCraftAvailableSkillsMessage {
         super.initJobAllowMultiCraftRequestMessage(enabled);
         this.playerId = playerId;
         this.skills = skills;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.playerId = 0;
         this.skills = new Vector.<uint>();
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_JobMultiCraftAvailableSkillsMessage(output);
      }
      
      public function serializeAs_JobMultiCraftAvailableSkillsMessage(output:IDataOutput) : void {
         super.serializeAs_JobAllowMultiCraftRequestMessage(output);
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            output.writeInt(this.playerId);
            output.writeShort(this.skills.length);
            _i2 = 0;
            while(_i2 < this.skills.length)
            {
               if(this.skills[_i2] < 0)
               {
                  throw new Error("Forbidden value (" + this.skills[_i2] + ") on element 2 (starting at 1) of skills.");
               }
               else
               {
                  output.writeShort(this.skills[_i2]);
                  _i2++;
                  continue;
               }
            }
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_JobMultiCraftAvailableSkillsMessage(input);
      }
      
      public function deserializeAs_JobMultiCraftAvailableSkillsMessage(input:IDataInput) : void {
         var _val2:uint = 0;
         super.deserialize(input);
         this.playerId = input.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of JobMultiCraftAvailableSkillsMessage.playerId.");
         }
         else
         {
            _skillsLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _skillsLen)
            {
               _val2 = input.readShort();
               if(_val2 < 0)
               {
                  throw new Error("Forbidden value (" + _val2 + ") on elements of skills.");
               }
               else
               {
                  this.skills.push(_val2);
                  _i2++;
                  continue;
               }
            }
            return;
         }
      }
   }
}
