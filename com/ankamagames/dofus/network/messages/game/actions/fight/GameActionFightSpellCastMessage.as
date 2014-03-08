package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightSpellCastMessage extends AbstractGameActionFightTargetedAbilityMessage implements INetworkMessage
   {
      
      public function GameActionFightSpellCastMessage() {
         super();
      }
      
      public static const protocolId:uint = 1010;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var spellId:uint = 0;
      
      public var spellLevel:uint = 0;
      
      override public function getMessageId() : uint {
         return 1010;
      }
      
      public function initGameActionFightSpellCastMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, destinationCellId:int=0, critical:uint=1, silentCast:Boolean=false, spellId:uint=0, spellLevel:uint=0) : GameActionFightSpellCastMessage {
         super.initAbstractGameActionFightTargetedAbilityMessage(actionId,sourceId,targetId,destinationCellId,critical,silentCast);
         this.spellId = spellId;
         this.spellLevel = spellLevel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameActionFightSpellCastMessage(output);
      }
      
      public function serializeAs_GameActionFightSpellCastMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionFightTargetedAbilityMessage(output);
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
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightSpellCastMessage(input);
      }
      
      public function deserializeAs_GameActionFightSpellCastMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.spellId = input.readShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightSpellCastMessage.spellId.");
         }
         else
         {
            this.spellLevel = input.readByte();
            if((this.spellLevel < 1) || (this.spellLevel > 6))
            {
               throw new Error("Forbidden value (" + this.spellLevel + ") on element of GameActionFightSpellCastMessage.spellLevel.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
