package com.ankamagames.dofus.network.messages.game.context.roleplay.visual
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlaySpellAnimMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlaySpellAnimMessage() {
         super();
      }
      
      public static const protocolId:uint = 6114;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var casterId:int = 0;
      
      public var targetCellId:uint = 0;
      
      public var spellId:uint = 0;
      
      public var spellLevel:uint = 0;
      
      override public function getMessageId() : uint {
         return 6114;
      }
      
      public function initGameRolePlaySpellAnimMessage(casterId:int=0, targetCellId:uint=0, spellId:uint=0, spellLevel:uint=0) : GameRolePlaySpellAnimMessage {
         this.casterId = casterId;
         this.targetCellId = targetCellId;
         this.spellId = spellId;
         this.spellLevel = spellLevel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.casterId = 0;
         this.targetCellId = 0;
         this.spellId = 0;
         this.spellLevel = 0;
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
         this.serializeAs_GameRolePlaySpellAnimMessage(output);
      }
      
      public function serializeAs_GameRolePlaySpellAnimMessage(output:IDataOutput) : void {
         output.writeInt(this.casterId);
         if((this.targetCellId < 0) || (this.targetCellId > 559))
         {
            throw new Error("Forbidden value (" + this.targetCellId + ") on element targetCellId.");
         }
         else
         {
            output.writeShort(this.targetCellId);
            if(this.spellId < 0)
            {
               throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
            }
            else
            {
               output.writeShort(this.spellId);
               if((this.spellLevel < 1) || (this.spellLevel > 6))
               {
                  throw new Error("Forbidden value (" + this.spellLevel + ") on element spellLevel.");
               }
               else
               {
                  output.writeByte(this.spellLevel);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlaySpellAnimMessage(input);
      }
      
      public function deserializeAs_GameRolePlaySpellAnimMessage(input:IDataInput) : void {
         this.casterId = input.readInt();
         this.targetCellId = input.readShort();
         if((this.targetCellId < 0) || (this.targetCellId > 559))
         {
            throw new Error("Forbidden value (" + this.targetCellId + ") on element of GameRolePlaySpellAnimMessage.targetCellId.");
         }
         else
         {
            this.spellId = input.readShort();
            if(this.spellId < 0)
            {
               throw new Error("Forbidden value (" + this.spellId + ") on element of GameRolePlaySpellAnimMessage.spellId.");
            }
            else
            {
               this.spellLevel = input.readByte();
               if((this.spellLevel < 1) || (this.spellLevel > 6))
               {
                  throw new Error("Forbidden value (" + this.spellLevel + ") on element of GameRolePlaySpellAnimMessage.spellLevel.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
